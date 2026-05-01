# Proof-of-Concept: Toast Injection - COMPLETE

**Date:** 2026-05-01  
**Task:** Item 3.2 - Create tab injection proof-of-concept

---

## Summary

Successfully injected a Toast message into MainActivity using smali patching.

### Steps Completed

1. **Decompiled GameHub 6.0.0 base APK**
   ```bash
   apktool d base.apk -o /tmp/bh6_test
   ```

2. **Patched MainActivity.smali**
   - Changed `.locals 7` to `.locals 8` to allocate register v7
   - Injected Toast code at beginning of `onCreate`:
     ```smali
     const-string v7, "BannerHub Proof-of-Concept!"
     invoke-static {p0, v7, v0}, Landroid/widget/Toast;->makeText(...)Landroid/widget/Toast;
     move-result-object v7
     invoke-virtual {v7}, Landroid/widget/Toast;->show()V
     ```

3. **Rebuilt APK**
   ```bash
   apktool b /tmp/bh6_test -o /tmp/bh6_test_toast.apk
   ```

4. **Signed APK**
   ```bash
   apksigner sign --key testkey.pk8 --cert testkey.x509.pem --out bh6_test_toast_signed.apk bh6_test_toast.apk
   ```

5. **Installed and tested**
   ```bash
   adb uninstall com.xiaoji.egggame
   adb install bh6_test_toast_signed.apk
   adb shell am start -n com.xiaoji.egggame/.MainActivity
   ```

6. **Verified Toast appeared** ✓
   - Logcat shows `ViewRootImpl[Toast]` allocated
   - Toast message "BannerHub Proof-of-Concept!" displayed

---

## Key Learnings

1. **Compose UI can be patched** - Adding traditional Views/Toasts works even if the Activity uses Compose
2. **Register allocation** - Must increase `.locals` when using new registers
3. **Injection point** - Beginning of `onCreate` is safe for simple injections
4. **Rebuild process works** - apktool 3.0.1 handles 6 DEX structure correctly

---

## Next Steps for Actual Tab Injection

Based on this proof-of-concept, the tab injection approach will be:

1. **Get Window decor view** (like the Toast, we can manipulate views)
2. **Create a horizontal LinearLayout** with tab buttons
3. **Add onClick listeners** to launch GOG/Epic/Amazon activities
4. **Position the tab bar** at top of screen

### Code Structure for Tab Injection

```smali
# In onCreate, after Compose setup (around line 1258 - end of onCreate)
# Get Window and DecorView
invoke-virtual {p0}, Landroid/app/Activity;->getWindow()Landroid/view/Window;
move-result-object v7
invoke-virtual {v7}, Landroid/view/Window;->getDecorView()Landroid/view/View;
move-result-object v7
check-cast v7, Landroid/view/ViewGroup;

# Create LinearLayout for tabs
new-instance v8, Landroid/widget/LinearLayout;
invoke-direct {v8, p0}, Landroid/widget/LinearLayout;-><init>(Landroid/content/Context;)V

# Add to decor view
invoke-virtual {v7, v8}, Landroid/view/ViewGroup;->addView(Landroid/view/View;)V
```

---

## Files Created

- `/tmp/bh6_test/` - Decompiled 6.0.0 base
- `/tmp/bh6_test_toast.apk` - Patched APK (unsigned)
- `/tmp/bh6_test_toast_signed.apk` - Patched APK (signed)
- `patches/smali_classes3/com/xiaoji/egggame/MainActivity.smali` - Patched smali file

---

**Status:** Item 3.2 COMPLETE ✓  
**Next:** Item 3.3 - Port LandscapeLauncherMainActivity patch (create actual tab buttons)
