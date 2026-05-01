# Build Scripts Update for GameHub 6.0.0

**Date:** 2026-05-01  
**Task:** Item 2.3 - Update build scripts for new base APK

---

## Overview

The BannerHub build process uses GitHub Actions workflows (`.github/workflows/build.yml` and `build-quick.yml`). These need updates to work with GameHub 6.0.0 base APK.

---

## Required Changes

### 1. Create New Base APK Release

The build workflow downloads the base APK from a GitHub release tagged `base-apk`:

```yaml
- name: Download original APK
  run: |
    gh release download base-apk --pattern "*.apk" -D base/ -R ${{ github.repository }}
```

**Action needed:**
- Create a new release tagged `base-apk` with the GameHub 6.0.0 APK (`base.apk` in worktree)
- Or update the workflow to reference a different release/tag

### 2. Update Hardcoded Version Strings

The workflow patches two smali files to hardcode the phone-home version string:

**File:** `.github/workflows/build.yml` (lines ~80-110)

```python
# Current (5.3.5):
patch(
    'apktool_out_base/smali_classes13/com/xj/common/http/ClientParams.smali',
    ...
    '    const-string v3, "5.3.5"\n',
    'ClientParams: hardcode AppUtils.getAppVersionName() -> 5.3.5'
)

patch(
    'apktool_out_base/smali_classes7/com/xj/common/http/TokenInterceptor.smali',
    ...
    '    const-string v8, "5.3.5"\n',
    'TokenInterceptor: hardcode AppUtils.getAppVersionName() -> 5.3.5'
)
```

**Changes needed:**
- Update version string from `"5.3.5"` to `"6.0.0"`
- **CRITICAL:** Update smali file paths:
  - `smali_classes13/` → Check if this DEX exists in 6.0.0 (DEX count changed from 11→6)
  - `smali_classes7/` → May need to update path

**New paths to verify (after decompiling 6.0.0 base):**
- Find `ClientParams.smali` in decompiled 6.0.0 tree
- Find `TokenInterceptor.smali` in decompiled 6.0.0 tree

### 3. Update DEX Index Workaround

The workflow extracts `classes12.dex` to skip smali reassembly (DEX index limit workaround):

```yaml
- name: Remove uncompilable apktool artifacts
  run: |
    ...
    # Extract original classes12.dex and skip smali reassembly (dex index limit workaround)
    APK=$(ls base/*.apk | head -1)
    unzip -p "$APK" classes12.dex > apktool_out_base/classes12.dex
    rm -rf apktool_out_base/smali_classes12
```

**Issue:** GameHub 6.0.0 only has 6 DEXs (not 12+ like 5.3.5)

**Action needed:**
- After decompiling 6.0.0, check how many DEX files exist
- Update or remove this workaround section
- May need new DEX limit strategy (add smali7/, smali8/ for extensions)

### 4. Update Grant Root Access Patch Paths

The workflow patches `SettingBtnHolder.smali` for the "Grant Root Access" button:

```python
patch(
    'apktool_out_base/smali_classes6/com/xj/landscape/launcher/ui/setting/holder/SettingBtnHolder.smali',
    ...
)
```

**Action needed:**
- Verify `SettingBtnHolder.smali` location in 6.0.0 (package `com.xiaoji.egggame.*` now)
- Update path from `smali_classes6/com/xj/...` to new location

### 5. Update Activity Injection (if needed)

The `component-manager-patch/build.yml` injects activity declarations into `AndroidManifest.xml`:

```python
injection = (
    '        <activity android:configChanges="..."'
    ' android:name="com.xj.landscape.launcher.ui.menu.ComponentManagerActivity"'
    ...
)
```

**Action needed:**
- If component manager is still needed, update injected activity names to match 6.0.0 package structure

---

## Build Script Update Checklist

- [ ] Upload GameHub 6.0.0 APK to `base-apk` release
- [ ] Update `ClientParams.smali` path (find in 6.0.0 tree)
- [ ] Update `TokenInterceptor.smali` path (find in 6.0.0 tree)
- [ ] Update hardcoded version `"5.3.5"` → `"6.0.0"`
- [ ] Review DEX index workaround (classes12.dex may not exist in 6.0.0)
- [ ] Update `SettingBtnHolder.smali` path for root grant patch
- [ ] Test build with `workflow_dispatch` manual trigger

---

## Next Steps

1. **Decompile 6.0.0 base APK locally:**
   ```bash
   apktool d base.apk -o /tmp/bh6_test
   ```

2. **Find updated smali file paths:**
   ```bash
   find /tmp/bh6_test -name "ClientParams.smali"
   find /tmp/bh6_test -name "TokenInterceptor.smali"
   find /tmp/bh6_test -name "SettingBtnHolder.smali"
   ```

3. **Update `.github/workflows/build.yml`** with new paths

4. **Test build** with manual `workflow_dispatch` trigger

---

## Notes

- The main build logic (apktool decompile → patch → rebuild → sign) remains the same
- Only file paths and version strings need updating
- DEX allocation strategy: BannerHub extensions go in `smali7/` and `smali8/` (created in Item 2.2)
- Test the build early (use `workflow_dispatch` for manual builds without creating a tag)

---

**Status:** Documentation complete. Actual workflow updates blocked on decompiling 6.0.0 and finding new smali paths.
