# Extension Classes Build Guide - BannerHub 6.0

**Date:** 2026-05-01  
**Task:** Phase 5 - Extension Classes (Items 5.1-5.5)

---

## Overview

BannerHub's extension classes (GOG, Epic, Amazon activities) are written in Java and need to be:
1. Compiled with the correct Android SDK (API level matching 6.0.0)
2. Disassembled from `.class` to `.smali` using `baksmali`
3. Placed in the correct DEX directories (`smali_classes7/`, `smali_classes8/`)

---

## Extension Classes Copied

### GOG Activities (6 classes) - Item 5.1
- `GogMainActivity.java`
- `GogLoginActivity.java`
- `GogGamesActivity.java`
- `GogGameDetailActivity.java`
- `GogDownloadManager.java`
- `GogLaunchHelper.java`
- Plus: `GogCloudSaveManager.java`, `GogTokenRefresh.java`, `GogInstallPath.java`, `GogGame.java`

### Epic Activities (7 classes) - Item 5.2
- `EpicMainActivity.java`
- `EpicLoginActivity.java`
- `EpicGamesActivity.java`
- `EpicGameDetailActivity.java`
- `EpicFreeGamesActivity.java`
- `EpicApiClient.java`
- `EpicAuthClient.java`

### Amazon Activities (8 classes) - Item 5.3
- `AmazonMainActivity.java`
- `AmazonLoginActivity.java`
- `AmazonGamesActivity.java`
- `AmazonGameDetailActivity.java`
- `AmazonApiClient.java`
- `AmazonAuthClient.java`
- `AmazonLaunchHelper.java`
- `AmazonManifest.java`
- Plus: `AmazonSdkManager.java`, `AmazonCredentialStore.java`, `AmazonPKCEGenerator.java`

### Core BannerHub Classes - Item 5.4
- `BhDownloadService.java` + helpers
- `BhGameConfigsActivity.java`
- `BhSettingsExporter.java`
- `BhDashboardDownloadBtn.java`
- `BhDetailedHud.java`
- `BhFrameRating.java`
- `BhKonkrHud.java`
- Plus: `BhDownloadsActivity.java`, `BhGameConfigsActivity.java`

---

## Build Process

### Step 1: Set Up Android SDK
```bash
# Check ANDROID_HOME and ANDROID_SDK_ROOT
echo $ANDROID_HOME
# Should point to Android SDK (e.g., /opt/homebrew/share/android-commandlinetools)

# Find the correct compileSdkVersion for GameHub 6.0.0
# Check the decompiled manifest or build.gradle
grep -i "compileSdkVersion\|targetSdkVersion" /tmp/bh6_test/AndroidManifest.xml
```

### Step 2: Compile Java Sources
```bash
# Create output directory for .class files
mkdir -p /tmp/bh6_extension_classes

# Compile with correct classpath (include GameHub's classes.dex converted to .jar)
# This is complex - might need to use the decompiled classes as classpath

# Simpler approach: Use the BannerHub build system
# Check if BannerHub has a build.gradle or script
ls /Users/danhimebauch/Developer/BannerHub/*.gradle 2>/dev/null
```

### Step 3: Disassemble to Smali
```bash
# Use baksmali (comes with apktool) to convert .class to .smali
# Example:
java -jar baksmali.jar -o /tmp/bh6_smali_output /tmp/bh6_extension_classes/

# Then organize into smali_classes7/ and smali_classes8/
```

### Step 4: Place in Correct DEX Directories
```bash
# GOG + Epic → smali_classes7/
mkdir -p /Users/danhimebauch/Developer/BannerHub-6.0-port/patches/smali_classes7/com/revanced/extension/gamehub/
cp -r /tmp/bh6_smali_output/com/revanced/extension/gamehub/gog/ patches/smali_classes7/com/revanced/extension/gamehub/
cp -r /tmp/bh6_smali_output/com/revanced/extension/gamehub/epic/ patches/smali_classes7/com/revanced/extension/gamehub/

# Amazon + helpers → smali_classes8/
mkdir -p /Users/danhimebauch/Developer/BannerHub-6.0-port/patches/smali_classes8/com/revanced/extension/gamehub/
cp -r /tmp/bh6_smali_output/com/revanced/extension/gamehub/amazon/ patches/smali_classes8/com/revanced/extension/gamehub/
cp -r /tmp/bh6_smali_output/com/revanced/extension/gamehub/bh/ patches/smali_classes8/com/revanced/extension/gamehub/
```

---

## Package Structure in 6.0.0

From the original BannerHub build, the extension classes are in:
- `com.revanced.extension.gamehub.gog.*`
- `com.revanced.extension.gamehub.epic.*`
- `com.revanced.extension.gamehub.amazon.*`
- `com.revanced.extension.gamehub.bh.*`

These should work in 6.0.0 without changes (they're independent of GameHub's internal refactoring).

---

## Next Steps (Items 5.1-5.5)

- [x] **Item 5.1** - Copy GOG activities (Java sources) ✓
- [x] **Item 5.2** - Copy Epic activities (Java sources) ✓
- [x] **Item 5.3** - Copy Amazon activities (Java sources) ✓
- [x] **Item 5.4** - Copy core BannerHub classes (Java sources) ✓
- [ ] **Item 5.5** - Register in AndroidManifest.xml (pending compilation)

**Blocked on:** Compiling Java sources with correct Android SDK + GameHub classpath.

**Recommendation:** Use BannerHub's existing build system to compile, then port the output.

---

**Status:** Items 5.1-5.4 Java sources copied. Item 5.5 blocked on compilation.
