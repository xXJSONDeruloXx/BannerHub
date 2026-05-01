package app.revanced.extension.gamehub;

import android.content.Context;
import android.content.SharedPreferences;
import android.util.Log;

import java.io.File;
import java.util.List;
import java.util.ArrayList;
import java.io.FileInputStream;
import java.io.BufferedReader;
import java.io.InputStreamReader;
import java.io.IOException;

/**
 * Suspend policy manager for BannerHub.
 * 
 * Suspend policies (mirrors GameNative's Container.SUSPEND_POLICY_*):
 * - "auto":     Suspend on app background, auto-resume on foreground.
 * - "manual":   Suspend on app background, require Resume button (default).
 * - "never":    Never suspend; keep Wine processes running.
 *
 * Wine processes are tracked via /proc and signaled with SIGSTOP/SIGCONT.
 */
public class BhSuspendPolicy {
    private static final String TAG = "BH_SUSPEND";

    public static final String POLICY_AUTO   = "auto";
    public static final String POLICY_MANUAL = "manual";
    public static final String POLICY_NEVER  = "never";

    // SharedPreferences keys for per-container suspend policy.
    // Container settings are stored in "pc_g_setting{containerId}" (same as GameHub).
    private static final String KEY_SUSPEND_POLICY = "suspendPolicy";

    // Runtime state
    private static boolean sSuspended = false;
    private static String sActivePolicy = POLICY_MANUAL; // default until set
    private static String sActiveContainerId = "";

    // Signal constants (same as ProcessHelper in GameNative)
    private static final int SIGSTOP = 19;
    private static final int SIGCONT = 18;

    // ------------------------------------------------------------------------
    //  Policy persistence (per container)
    // ------------------------------------------------------------------------

    /** Read suspend policy for a given container ID. */
    public static String getSuspendPolicy(Context ctx, String containerId) {
        SharedPreferences sp = ctx.getSharedPreferences("pc_g_setting" + containerId, Context.MODE_PRIVATE);
        String policy = sp.getString(KEY_SUSPEND_POLICY, null);
        return normalizePolicy(policy);
    }

    /** Set suspend policy for a container. */
    public static void setSuspendPolicy(Context ctx, String containerId, String policy) {
        String normalized = normalizePolicy(policy);
        SharedPreferences sp = ctx.getSharedPreferences("pc_g_setting" + containerId, Context.MODE_PRIVATE);
        sp.edit().putString(KEY_SUSPEND_POLICY, normalized).apply();
        Log.i(TAG, "Container " + containerId + " suspend policy set to " + normalized);
    }

    /** Normalize policy string (handles null, case, etc.) */
    public static String normalizePolicy(String policy) {
        if (policy == null) return POLICY_MANUAL;
        switch (policy.toLowerCase()) {
            case POLICY_AUTO:   return POLICY_AUTO;
            case POLICY_NEVER:  return POLICY_NEVER;
            case POLICY_MANUAL:
            default:            return POLICY_MANUAL;
        }
    }

    // ------------------------------------------------------------------------
    //  Active session management (called from activity lifecycle / Wine task manager)
    // ------------------------------------------------------------------------

    /** Call when a Wine session starts. Sets the active policy for the current container. */
    public static void onSessionStart(Context ctx, String containerId) {
        sActiveContainerId = containerId != null ? containerId : "";
        if (!sActiveContainerId.isEmpty() && ctx != null) {
            sActivePolicy = getSuspendPolicy(ctx, sActiveContainerId);
        } else {
            sActivePolicy = getDefaultPolicy(ctx != null ? ctx : null);
        }
        sSuspended = false;
        Log.i(TAG, "Session start: container=" + sActiveContainerId + " policy=" + sActivePolicy);
    }

    /** Call when Wine session ends. */
    public static void onSessionEnd() {
        sActiveContainerId = "";
        sActivePolicy = POLICY_MANUAL;
        sSuspended = false;
        Log.i(TAG, "Session end");
    }

    /** Returns true if the current session is suspended. */
    public static boolean isSuspended() {
        return sSuspended;
    }

    /** Returns the active suspend policy for the current session. */
    public static String getActivePolicy() {
        return sActivePolicy;
    }

    // ------------------------------------------------------------------------
    //  Suspend / Resume actions (called from onPause / onResume / UI button)
    // ------------------------------------------------------------------------

    /** Suspend Wine processes if policy allows. Needs Context to read policy. */
    public static boolean suspendIfAllowed(Context ctx) {
        if (sSuspended) return true;
        String policy = getEffectivePolicy(ctx);
        if (POLICY_NEVER.equals(policy)) {
            Log.i(TAG, "Suspend skipped: policy=never");
            return false;
        }
        suspendWineProcesses();
        sSuspended = true;
        Log.i(TAG, "Suspended (policy=" + policy + ")");
        return true;
    }

    /** Resume Wine processes if suspended. */
    public static void resumeIfSuspended() {
        if (!sSuspended) return;
        resumeWineProcesses();
        sSuspended = false;
        Log.i(TAG, "Resumed");
    }

    /** Get the effective suspend policy: per-container if active, else global default. */
    private static String getEffectivePolicy(Context ctx) {
        if (!sActiveContainerId.isEmpty() && ctx != null) {
            String containerPolicy = getSuspendPolicy(ctx, sActiveContainerId);
            if (containerPolicy != null) return containerPolicy;
        }
        if (ctx != null) {
            return getDefaultPolicy(ctx);
        }
        return POLICY_MANUAL; // fallback
    }

    /** Read global default suspend policy from "bh_prefs". */
    public static String getDefaultPolicy(Context ctx) {
        SharedPreferences sp = ctx.getSharedPreferences("bh_prefs", Context.MODE_PRIVATE);
        return normalizePolicy(sp.getString("suspend_policy", POLICY_MANUAL));
    }

    /** Set global default suspend policy in "bh_prefs". */
    public static void setDefaultPolicy(Context ctx, String policy) {
        String normalized = normalizePolicy(policy);
        SharedPreferences sp = ctx.getSharedPreferences("bh_prefs", Context.MODE_PRIVATE);
        sp.edit().putString("suspend_policy", normalized).apply();
        Log.i(TAG, "Default suspend policy set to " + normalized);
    }

    /** Toggle suspend state (for manual resume button). Needs Context to read policy. */
    public static void toggleSuspend(Context ctx) {
        if (sSuspended) {
            resumeIfSuspended();
        } else {
            suspendIfAllowed(ctx);
        }
    }

    // ------------------------------------------------------------------------
    //  Wine process enumeration & signal (same as GameNative's ProcessHelper)
    // ------------------------------------------------------------------------

    /** Send SIGSTOP to all wine-related processes. */
    private static void suspendWineProcesses() {
        List<String> pids = listWinePids();
        for (String pid : pids) {
            try {
                int pidInt = Integer.parseInt(pid);
                sendSignal(pidInt, SIGSTOP);
                Log.d(TAG, "SIGSTOP sent to pid " + pid);
            } catch (NumberFormatException ignored) {}
        }
    }

    /** Send SIGCONT to all wine-related processes. */
    private static void resumeWineProcesses() {
        List<String> pids = listWinePids();
        for (String pid : pids) {
            try {
                int pidInt = Integer.parseInt(pid);
                sendSignal(pidInt, SIGCONT);
                Log.d(TAG, "SIGCONT sent to pid " + pid);
            } catch (NumberFormatException ignored) {}
        }
    }

    /** List all PIDs whose /proc/<pid>/stat contains "wine" or ".exe". */
    private static List<String> listWinePids() {
        List<String> result = new ArrayList<>();
        File proc = new File("/proc");
        String[] subdirs = proc.list();
        if (subdirs == null) return result;

        for (String name : subdirs) {
            if (!name.matches("\\d+")) continue;
            File statFile = new File(proc, name + "/stat");
            if (!statFile.exists()) continue;
            try (BufferedReader br = new BufferedReader(new InputStreamReader(new FileInputStream(statFile)))) {
                String line = br.readLine();
                if (line != null && (line.contains("wine") || line.contains(".exe"))) {
                    result.add(name);
                }
            } catch (IOException ignored) {}
        }
        return result;
    }

    /** Send a signal to a process (uses android.os.Process.sendSignal). */
    private static void sendSignal(int pid, int signal) {
        try {
            android.os.Process.sendSignal(pid, signal);
        } catch (Exception e) {
            Log.e(TAG, "Failed to send signal " + signal + " to pid " + pid + ": " + e);
        }
    }
}
