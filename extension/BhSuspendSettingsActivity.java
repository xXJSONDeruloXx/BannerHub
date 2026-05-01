package app.revanced.extension.gamehub;

import android.app.Activity;
import android.os.Bundle;
import android.widget.RadioGroup;
import android.widget.RadioButton;
import android.widget.Button;
import android.widget.TextView;
import android.util.Log;
import android.widget.Toast;

/**
 * Settings Activity for Suspend Policy.
 * Allows user to choose: auto / manual / never.
 */
public class BhSuspendSettingsActivity extends Activity {
    private static final String TAG = "BH_SUSPEND_SETTINGS";
    private RadioGroup policyGroup;
    private String currentPolicy;

    @Override
    protected void onCreate(Bundle savedInstanceState) {
        super.onCreate(savedInstanceState);
        
        // Simple layout programmatically
        RadioGroup layout = new RadioGroup(this);
        layout.setOrientation(RadioGroup.VERTICAL);
        layout.setPadding(50, 50, 50, 50);
        
        TextView title = new TextView(this);
        title.setText("Suspend Behavior");
        title.setTextSize(24);
        layout.addView(title);
        
        // Current policy
        currentPolicy = BhSuspendPolicy.getDefaultPolicy(this);
        Log.i(TAG, "Current policy: " + currentPolicy);
        
        // Radio buttons
        RadioButton autoBtn = new RadioButton(this);
        autoBtn.setText("Suspend and auto-resume");
        autoBtn.setId(1);
        layout.addView(autoBtn);
        
        RadioButton manualBtn = new RadioButton(this);
        manualBtn.setText("Suspend until Resume button (Default)");
        manualBtn.setId(2);
        layout.addView(manualBtn);
        
        RadioButton neverBtn = new RadioButton(this);
        neverBtn.setText("Never suspend");
        neverBtn.setId(3);
        layout.addView(neverBtn);
        
        // Set current selection
        if (BhSuspendPolicy.POLICY_AUTO.equals(currentPolicy)) {
            autoBtn.setChecked(true);
        } else if (BhSuspendPolicy.POLICY_MANUAL.equals(currentPolicy)) {
            manualBtn.setChecked(true);
        } else if (BhSuspendPolicy.POLICY_NEVER.equals(currentPolicy)) {
            neverBtn.setChecked(true);
        }
        
        policyGroup = new RadioGroup(this);
        policyGroup.addView(autoBtn);
        policyGroup.addView(manualBtn);
        policyGroup.addView(neverBtn);
        
        // Save button
        Button saveBtn = new Button(this);
        saveBtn.setText("Save");
        saveBtn.setOnClickListener(v -> {
            int checkedId = policyGroup.getCheckedRadioButtonId();
            String newPolicy;
            if (checkedId == 1) {
                newPolicy = BhSuspendPolicy.POLICY_AUTO;
            } else if (checkedId == 2) {
                newPolicy = BhSuspendPolicy.POLICY_MANUAL;
            } else {
                newPolicy = BhSuspendPolicy.POLICY_NEVER;
            }
            
            BhSuspendPolicy.setDefaultPolicy(BhSuspendSettingsActivity.this, newPolicy);
            Toast.makeText(BhSuspendSettingsActivity.this, "Policy saved: " + newPolicy, Toast.LENGTH_SHORT).show();
            Log.i(TAG, "Policy saved: " + newPolicy);
            finish();
        });
        layout.addView(saveBtn);
        
        setContentView(layout);
    }
}
