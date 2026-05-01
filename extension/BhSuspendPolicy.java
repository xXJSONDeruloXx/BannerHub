package app.revanced.extension.gamehub;

import android.content.Context;
import android.content.SharedPreferences;
import android.util.Log;

import java.io.BufferedReader;
import java.io.File;
import java.io.FileInputStream;
import java.io.InputStreamReader;
import java.util.List;

/**
 * Suspend policy manager for BannerHub.
 * 
 * Suspend policies (mirrors GameNative's Container.SUSPEND_POLICY_*):
 * - "auto":     Suspend on app background, auto-resume on foreground.
 * - "manual":   Suspend on app background, require Resume button (default).
 * - "never":    Never suspend; keep Wine processes running.
 *
 * Wine processes are tracked via /proc and signaled with SIGSTOP/SIGCONT.
 *
 * Uses background monitoring to detect app foreground/background state.
 * No smali modifications needed!
 */
public class BhSuspendPolicy {
    private static final String TAG = "BH_SUSPEND";

    public static final String POLICY_AUTO   = "auto";
    public static final String POLICY_MANUAL = "manual";
    public static final String POLICY_NEVER  = "never";

    // SharedPreferences keys
    private static final String KEY_DEFAULT_POLICY = "default_suspend_policy";

    // Runtime state
    private static boolean sSuspended = false;

    // Signal constants (same as ProcessHelper in GameNative)
    private static final int SIGSTOP = 19;
    private static final int SIGCONT = 18;

    // ------------------------------------------------------------------------
    //  Policy persistence (global)
    // ------------------------------------------------------------------------

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

    /** Get the default suspend policy. */
    public static String getDefaultPolicy(Context ctx) {
        if (ctx == null) return POLICY_MANUAL;
        SharedPreferences sp = ctx.getSharedPreferences("bh_prefs", Context.MODE_PRIVATE);
        return normalizePolicy(sp.getString(KEY_DEFAULT_POLICY, POLICY_MANUAL));
    }

    /** Set the default suspend policy. */
    public static void setDefaultPolicy(Context ctx, String policy) {
        String normalized = normalizePolicy(policy);
        SharedPreferences sp = ctx.getSharedPreferences("bh_prefs", Context.MODE_PRIVATE);
        sp.edit().putString(KEY_DEFAULT_POLICY, normalized).apply();
        Log.i(TAG, "Default suspend policy set to " + normalized);
    }

    // ------------------------------------------------------------------------
    //  Suspend / Resume actions
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

    /** Toggle suspend state (for manual resume button). Needs Context to read policy. */
    public static void toggleSuspend(Context ctx) {
        if (sSuspended) {
            resumeIfSuspended();
        } else {
            suspendIfAllowed(ctx);
        }
    }

    /** Get the effective suspend policy (global default). */
    private static String getEffectivePolicy(Context ctx) {
        if (ctx != null) {
            return getDefaultPolicy(ctx);
        }
        return POLICY_MANUAL; // fallback
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
        List<String> result = new java.util.ArrayList<>();
        File proc = new File("/proc");
        String[] subdirs = proc.list();
        if (subdirs == null) return result;

        for (String name : subdirs) {
            if (!name.matches("\\d+")) continue;
            File statFile = new File(proc, name + "/stat");
            if (!statFile.exists()) continue;
            try (BufferedReader br = new BufferedReader(new InputStreamReader(new FileInputStream(statFile)))) {
                String line = br.readLine();
                if (line != null) {
                    String lowerLine = line.toLowerCase();
                    if (lowerLine.contains("wine") || lowerLine.contains(".exe")) {
                        result.add(name);
                    }
                }
            } catch (Exception ignored) {}
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
