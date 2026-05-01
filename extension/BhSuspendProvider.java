package app.revanced.extension.gamehub;

import android.app.Activity;
import android.app.Application;
import android.content.ContentProvider;
import android.content.ContentValues;
import android.content.Context;
import android.database.Cursor;
import android.database.MatrixCursor;
import android.net.Uri;
import android.os.Bundle;
import android.util.Log;

/**
 * ContentProvider that initializes the suspend policy feature.
 * 
 * Runs when the app starts (before any activity).
 * Uses started/stopped activity counting to detect real app-level
 * foreground/background transitions (not per-activity pause/resume).
 *
 * This approach works on all Android versions (unlike manifest-declared receivers
 * which are restricted on Android 8+).
 */
public class BhSuspendProvider extends ContentProvider {
    private static final String TAG = "BH_SUSPEND_PROV";

    /** Number of activities currently in the started state. */
    private static int sStartedCount = 0;
    /**
     * Whether the data directory has been created.
     * We use this to determine if the provider is being called for the first time.
     */
    private static boolean sInitialized = false;

    @Override
    public boolean onCreate() {
        Log.i(TAG, "Initializing suspend policy provider...");
        Context ctx = getContext();
        if (ctx == null) {
            Log.e(TAG, "Context is null, cannot initialize");
            return false;
        }

        // Get the Application context
        Application app = (Application) ctx.getApplicationContext();
        if (app == null) {
            Log.e(TAG, "Application is null, cannot register lifecycle callbacks");
            return false;
        }

        // Register activity lifecycle callbacks
        app.registerActivityLifecycleCallbacks(new Application.ActivityLifecycleCallbacks() {
            @Override
            public void onActivityCreated(Activity activity, Bundle savedInstanceState) {}

            @Override
            public void onActivityStarted(Activity activity) {
                sStartedCount++;
                Log.d(TAG, "Activity started: " + activity.getClass().getSimpleName()
                        + " (count=" + sStartedCount + ")");

                // App transitioned from background to foreground
                if (sStartedCount == 1 && sInitialized) {
                    Log.i(TAG, "App came to foreground");
                    // Only auto-resume for POLICY_AUTO; manual requires explicit user action
                    String policy = BhSuspendPolicy.getDefaultPolicy(activity);
                    if (BhSuspendPolicy.POLICY_AUTO.equals(policy)) {
                        BhSuspendPolicy.resumeIfSuspended();
                    } else {
                        Log.i(TAG, "Resume skipped: policy=" + policy);
                    }
                }
                sInitialized = true;
            }

            @Override
            public void onActivityStopped(Activity activity) {
                sStartedCount--;
                Log.d(TAG, "Activity stopped: " + activity.getClass().getSimpleName()
                        + " (count=" + sStartedCount + ")");

                // App transitioned from foreground to background
                if (sStartedCount == 0) {
                    Log.i(TAG, "App went to background");
                    BhSuspendPolicy.suspendIfAllowed(activity);
                }
            }

            @Override
            public void onActivityResumed(Activity activity) {}

            @Override
            public void onActivityPaused(Activity activity) {}

            @Override
            public void onActivitySaveInstanceState(Activity activity, Bundle outState) {}

            @Override
            public void onActivityDestroyed(Activity activity) {}
        });

        Log.i(TAG, "Suspend policy provider initialized - lifecycle callbacks registered");
        return true;
    }
    
    @Override
    public Cursor query(Uri uri, String[] projection, String selection, String[] selectionArgs, String sortOrder) {
        return new MatrixCursor(new String[]{"status"});
    }
    
    @Override
    public String getType(Uri uri) {
        return null;
    }
    
    @Override
    public Uri insert(Uri uri, ContentValues values) {
        return null;
    }
    
    @Override
    public int delete(Uri uri, String selection, String[] selectionArgs) {
        return 0;
    }
    
    @Override
    public int update(Uri uri, ContentValues values, String selection, String[] selectionArgs) {
        return 0;
    }
}
