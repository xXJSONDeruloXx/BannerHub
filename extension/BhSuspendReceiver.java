package app.revanced.extension.gamehub;

import android.content.BroadcastReceiver;
import android.content.Context;
import android.content.Intent;
import android.util.Log;

/**
 * BroadcastReceiver for handling suspend/resume based on screen state.
 * 
 * Registers for ACTION_SCREEN_OFF (app backgrounded) and
 * ACTION_SCREEN_ON (app foregrounded).
 * 
 * Note: This is a fallback for when the main activity's onPause/onResume
 * can't be modified due to dex method limit.
 */
public class BhSuspendReceiver extends BroadcastReceiver {
    private static final String TAG = "BH_SUSPEND_RX";

    @Override
    public void onReceive(Context context, Intent intent) {
        if (intent == null || intent.getAction() == null) return;

        switch (intent.getAction()) {
            case Intent.ACTION_SCREEN_OFF:
                Log.i(TAG, "Screen OFF - attempting suspend");
                BhSuspendPolicy.suspendIfAllowed(context);
                break;

            case Intent.ACTION_SCREEN_ON:
                Log.i(TAG, "Screen ON - attempting resume");
                BhSuspendPolicy.resumeIfSuspended();
                break;

            default:
                break;
        }
    }
}
