# Tab Injection Progress - Issues & Solution

**Date:** 2026-05-01  
**Task:** Items 3.3-3.4 - Port Launcher Patch & Add Store Tabs

---

## Current Status

### What Works ✓
- Toast injection proof-of-concept (Item 3.2) - SUCCESS
- APK rebuild and install works
- Basic injection into MainActivity works

### What Fails ✗
- Tab injection with Button widgets fails with VerifyError:
  ```
  java.lang.VerifyError: Verifier rejected class com.xiaoji.egggame.MainActivity
  android.widget.Button not instanceof Throwable
  ```

---

## Root Cause Analysis

The error occurs because:

1. **onCreate has exception handling** (`.catchall` at line 754)
2. **Register conflicts** - The verifier tracks register types across the entire method
3. **Try-catch coverage** - The exception handler expects certain registers to hold `Throwable`

When I inject code that uses registers (v0-v12) that the verifier thinks should be `Throwable`, it fails.

---

## Attempted Solutions

### 1. Use higher registers (v9-v12) - FAILED
- Still conflicts with exception handler register allocation

### 2. Separate method approach - NEEDS WORK
- Create `addBannerHubTabs()` method
- Call it from onCreate
- Issue: Method injection syntax/placement complex

---

## Recommended Solution

### Option A: Separate Class (CLEANEST)
Create a new class `BannerHubHelper` with a static method:
```java
public static void addTabsToActivity(Activity activity) {
    // Create LinearLayout with buttons
    // Add to decor view
}
```

Inject a call to this method from MainActivity.onCreate:
```smali
invoke-static {p0}, LBannerHubHelper;->addTabsToActivity(Landroid/app/Activity;)V
```

**Advantage:** Separate class = separate verification scope = no conflicts

### Option B: Broadcast Receiver
- Register a broadcast receiver in MainActivity
- Send broadcast after onCreate completes
- Receiver creates and adds the tab bar

### Option C: Post-Delayed to Handler
- Use `Handler.postDelayed()` to add tabs after onCreate finishes
- Might avoid verifier issues since it runs later

---

## Next Steps (To Be Continued)

1. **Create BannerHubHelper class** (Option A)
   - New file: `smali_classes7/com/xiaoji/egggame/BannerHubHelper.smali`
   - Static method `addTabsToActivity()`
   - Creates LinearLayout with 3 buttons (GOG, Epic, Amazon)
   - Adds to decor view

2. **Inject call in MainActivity**
   - Simple one-liner: `invoke-static {p0}, LBannerHubHelper;->addTabsToActivity(Landroid/app/Activity;)V`
   - Much less likely to conflict with exception handling

3. **Add onClick listeners**
   - For now, show Toasts
   - Later (Phase 5): Launch actual store activities

---

## Files Modified

- `/tmp/bh6_test/smali_classes3/com/xiaoji/egggame/MainActivity.smali`
  - Multiple injection attempts
  - Current state: Has failed tab injection code (needs cleanup)
  
- `/tmp/bh6_test_tabs.apk` - Built APK with tab injection (crashes)
- `/tmp/bh6_test_toast.apk` - Built APK with Toast (works)

---

## Recommendation for Next Iteration

**Continue with Items 3.3-3.4** using Option A (separate class):

1. Create `BannerHubHelper.smali` in `smali_classes7/`
2. Implement `addTabsToActivity()` with tab creation
3. Inject simple call in MainActivity
4. Test and verify

**Alternative:** Move to **Phase 4 (Sidebar Retargeting)** and come back to tabs later.

---

**Status:** IN PROGRESS - blocked on verifier issues  
**Next iteration:** Continue with separate class approach or pivot to Phase 4
