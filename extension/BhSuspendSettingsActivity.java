package app.revanced.extension.gamehub;

import android.app.Activity;
import android.graphics.Color;
import android.graphics.Typeface;
import android.os.Bundle;
import android.view.Gravity;
import android.view.View;
import android.widget.Button;
import android.widget.LinearLayout;
import android.widget.RadioButton;
import android.widget.RadioGroup;
import android.widget.TextView;
import android.widget.Toast;
import android.util.Log;
import android.view.ViewGroup;
import android.widget.ScrollView;

/**
 * Settings Activity for Suspend Policy.
 *
 * Allows the user to choose a global suspend policy:
 *  - Auto:   Suspend on background, auto-resume on foreground.
 *  - Manual: Suspend on background, user must press Resume (default).
 *  - Never:  Never suspend Wine processes.
 *
 * When the current policy is "manual" and the session is suspended,
 * a large "Resume Wine" button is shown to let the user resume.
 *
 * Launch via:
 *   adb shell am start -n gamehub.lite/app.revanced.extension.gamehub.BhSuspendSettingsActivity
 */
public class BhSuspendSettingsActivity extends Activity {
    private static final String TAG = "BH_SUSPEND_SETTINGS";

    private RadioGroup policyGroup;
    private TextView statusText;
    private Button resumeBtn;
    private String currentPolicy;

    @Override
    protected void onCreate(Bundle savedInstanceState) {
        super.onCreate(savedInstanceState);

        currentPolicy = BhSuspendPolicy.getDefaultPolicy(this);
        Log.i(TAG, "Current policy: " + currentPolicy);

        // ---- Root layout ----
        LinearLayout root = new LinearLayout(this);
        root.setOrientation(LinearLayout.VERTICAL);
        int pad = dp(16);
        root.setPadding(pad, pad, pad, pad);
        root.setBackgroundColor(Color.parseColor("#1E1E1E"));

        // ---- Title ----
        TextView title = new TextView(this);
        title.setText("Suspend Behavior");
        title.setTextSize(22);
        title.setTypeface(null, Typeface.BOLD);
        title.setTextColor(Color.WHITE);
        title.setGravity(Gravity.CENTER);
        title.setPadding(0, 0, 0, dp(12));
        root.addView(title);

        // ---- Current status ----
        statusText = new TextView(this);
        statusText.setTextSize(14);
        statusText.setTextColor(Color.parseColor("#AAAAAA"));
        statusText.setGravity(Gravity.CENTER);
        statusText.setPadding(0, 0, 0, dp(16));
        updateStatusText();
        root.addView(statusText);

        // ---- Divider ----
        root.addView(makeDivider());

        // ---- Radio buttons ----
        policyGroup = new RadioGroup(this);
        policyGroup.setOrientation(RadioGroup.VERTICAL);

        RadioButton autoBtn = makeRadio("Auto", "Suspend on background, auto-resume on foreground", 1);
        RadioButton manualBtn = makeRadio("Manual", "Suspend on background, tap Resume to continue (default)", 2);
        RadioButton neverBtn = makeRadio("Never", "Never suspend Wine processes", 3);

        policyGroup.addView(autoBtn);
        policyGroup.addView(manualBtn);
        policyGroup.addView(neverBtn);

        // Set current selection
        switch (currentPolicy) {
            case BhSuspendPolicy.POLICY_AUTO:   autoBtn.setChecked(true);   break;
            case BhSuspendPolicy.POLICY_MANUAL: manualBtn.setChecked(true); break;
            case BhSuspendPolicy.POLICY_NEVER:  neverBtn.setChecked(true);  break;
        }

        root.addView(policyGroup);

        // ---- Divider ----
        root.addView(makeDivider());

        // ---- Resume button (only useful for manual policy) ----
        resumeBtn = new Button(this);
        resumeBtn.setText("▶  Resume Wine");
        resumeBtn.setTextSize(18);
        resumeBtn.setAllCaps(false);
        resumeBtn.setTextColor(Color.WHITE);
        resumeBtn.setBackgroundColor(Color.parseColor("#2E7D32"));
        resumeBtn.setPadding(dp(16), dp(16), dp(16), dp(16));
        LinearLayout.LayoutParams resumeLp = new LinearLayout.LayoutParams(
                ViewGroup.LayoutParams.MATCH_PARENT, ViewGroup.LayoutParams.WRAP_CONTENT);
        resumeLp.setMargins(0, dp(8), 0, dp(8));
        resumeBtn.setLayoutParams(resumeLp);
        resumeBtn.setOnClickListener(v -> {
            BhSuspendPolicy.resumeIfSuspended();
            updateStatusText();
            Toast.makeText(this, "Wine resumed", Toast.LENGTH_SHORT).show();
            Log.i(TAG, "User pressed Resume");
        });
        resumeBtn.setVisibility(BhSuspendPolicy.isSuspended() ? Button.VISIBLE : Button.GONE);
        root.addView(resumeBtn);

        // ---- Save button ----
        Button saveBtn = new Button(this);
        saveBtn.setText("Save Policy");
        saveBtn.setTextSize(16);
        saveBtn.setAllCaps(false);
        saveBtn.setTextColor(Color.WHITE);
        saveBtn.setBackgroundColor(Color.parseColor("#1565C0"));
        saveBtn.setPadding(dp(12), dp(12), dp(12), dp(12));
        LinearLayout.LayoutParams saveLp = new LinearLayout.LayoutParams(
                ViewGroup.LayoutParams.MATCH_PARENT, ViewGroup.LayoutParams.WRAP_CONTENT);
        saveLp.setMargins(0, dp(8), 0, 0);
        saveBtn.setLayoutParams(saveLp);
        saveBtn.setOnClickListener(v -> {
            int checkedId = policyGroup.getCheckedRadioButtonId();
            String newPolicy;
            if (checkedId == 1) {
                newPolicy = BhSuspendPolicy.POLICY_AUTO;
            } else if (checkedId == 2) {
                newPolicy = BhSuspendPolicy.POLICY_MANUAL;
            } else if (checkedId == 3) {
                newPolicy = BhSuspendPolicy.POLICY_NEVER;
            } else {
                newPolicy = currentPolicy; // no change
            }
            BhSuspendPolicy.setDefaultPolicy(this, newPolicy);
            currentPolicy = newPolicy;
            updateStatusText();
            Toast.makeText(this, "Saved: " + newPolicy, Toast.LENGTH_SHORT).show();
            Log.i(TAG, "Policy saved: " + newPolicy);
        });
        root.addView(saveBtn);

        // ---- Help text ----
        TextView help = new TextView(this);
        help.setText("Auto: Wine pauses when you leave the app and resumes when you return.\n\n"
                + "Manual: Wine pauses when you leave the app. Tap Resume Wine to continue.\n\n"
                + "Never: Wine keeps running even when the app is in the background.");
        help.setTextSize(12);
        help.setTextColor(Color.parseColor("#888888"));
        help.setPadding(0, dp(16), 0, 0);
        root.addView(help);

        // ---- Wrap in ScrollView ----
        ScrollView scrollView = new ScrollView(this);
        scrollView.addView(root);
        setContentView(scrollView);
    }

    @Override
    protected void onResume() {
        super.onResume();
        // Refresh suspended state each time the activity comes to foreground
        if (resumeBtn != null) {
            resumeBtn.setVisibility(BhSuspendPolicy.isSuspended() ? Button.VISIBLE : Button.GONE);
        }
        if (statusText != null) {
            updateStatusText();
        }
    }

    // ---- Helpers ----

    private void updateStatusText() {
        boolean suspended = BhSuspendPolicy.isSuspended();
        statusText.setText("Policy: " + currentPolicy + "  |  Wine: " + (suspended ? "SUSPENDED" : "running"));
        statusText.setTextColor(suspended ? Color.parseColor("#FF8A65") : Color.parseColor("#81C784"));
    }

    private RadioButton makeRadio(String label, String desc, int id) {
        RadioButton rb = new RadioButton(this);
        rb.setText(label + "  —  " + desc);
        rb.setTextSize(14);
        rb.setTextColor(Color.WHITE);
        rb.setPadding(dp(8), dp(8), dp(8), dp(8));
        rb.setId(id);
        return rb;
    }

    private View makeDivider() {
        View v = new View(this);
        LinearLayout.LayoutParams lp = new LinearLayout.LayoutParams(
                ViewGroup.LayoutParams.MATCH_PARENT, dp(1));
        lp.setMargins(0, dp(12), 0, dp(12));
        v.setLayoutParams(lp);
        v.setBackgroundColor(Color.parseColor("#333333"));
        return v;
    }

    private int dp(int value) {
        float density = getResources().getDisplayMetrics().density;
        return Math.round(value * density);
    }
}
