# Build Variants - BannerHub 6.0 #

**Date:** 2026-05-01  
**Task:** Item 7.2 - Build all variants (BLOCKED documentation)#

---

## Current Build Status #

### ✅ What Works #
- **apktool 3.0.1** - Decompiles GameHub 6.0.0 successfully`
- **Patch application** - 38+ HUD/sidebar patches applied`
- **BannerHubHelper.smali** - Created in `patches/smali_classes7/com/xiaoji/eggame/` `

### 🚫 What's BLOCKED #
1. **BannerHubHelper.smali build failure**
   ```
   bh6_with_helper/smali_classes7/com/xiaoji/eggame/BannerHubHelper.smali[71,0] Error for input '.end class'
   Invalid directive
   ```
   **Cause:** Syntax error in smali file (line 71)`
   **Fix:** Check `.end class` directive syntax`

2. **Java → smali workflow missing**
   - Extension classes are `.java` sources in `extension/`
   - Need baksmali to convert `.class` → `.smali`
   - BannerHub repo has build system but blocked on access`

---

## Build Variants Plan #

### 1. Normal Build (banner.hub)
```bash
# Apply patches to 6.0.0 base
cp -r patches/* /tmp/bh6_test/
apktool b /tmp/bh6_test -o bh6_normal.apk
apksigner sign --key testkey.pk8 --cert testkey.x509.pem bh6_normal.apk
```

### 2. Normal.GHL Build (gamehub.lite)
```bash
# Change package name in AndroidManifest.xml
# Change app label/icon
apktool b /tmp/bh6_test -o bh6_ghl.apk
```

### 3. PuBG Build (com.tencent.ig)
```bash
# Change package to com.tencent.ig
# Performance spoofing (higher heat)
```

### 4. Other Variants
- AnTuTu, Genshin, etc.

---

## Baksmali Workflow (For Phase 6 Integration)#

### Step 1: Compile Java Sources
```bash
# Use BannerHub's build.gradle or manual javac
javac -cp /path/to/android.jar extension/*.java
```

### Step 2: Convert .class → .smali
```bash
# Use baksmali (comes with apktool)
java -jar baksmali.jar -o output/ compiled_classes/
```

### Step 3: Organize into smali_classes7/8/
```bash
# GOG + Epic → smali_classes7/
# Amazon + helpers → smali_classes8/
```

---

## Next Steps #

1. **Fix BannerHubHelper.smali** (line 71 syntax error)`
2. **Test build** with fixed file`
3. **Set up baksmali** for Java extensions`
4. **Build all variants** (Items 7.2-7.4)`

---

**Status:** Item 7.2 BLOCKED on build issues  
**Next:** Fix BannerHubHelper.smali syntax, then build variants`
