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
 * Uses Application.ActivityLifecycleCallbacks to detect when the app
 * goes to background (onPause) or foreground (onResume).
 * 
 * This approach works on all Android versions (unlike manifest-declared receivers
 * which are restricted on Android 8+).
 */
public class BhSuspendProvider extends ContentProvider {
    private static final String TAG = "BH_SUSPEND_PROV";
    
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
            public void onActivityStarted(Activity activity) {}
            
            @Override
            public void onActivityResumed(Activity activity) {
                // App came to foreground - resume suspended processes
                Log.i(TAG, "Activity resumed: " + activity.getClass().getSimpleName());
                BhSuspendPolicy.resumeIfSuspended();
            }
            
            @Override
            public void onActivityPaused(Activity activity) {
                // App went to background - suspend processes if policy allows
                Log.i(TAG, "Activity paused: " + activity.getClass().getSimpleName());
                BhSuspendPolicy.suspendIfAllowed(activity);
            }
            
            @Override
            public void onActivityStopped(Activity activity) {}
            
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
