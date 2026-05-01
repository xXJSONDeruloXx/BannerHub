# Baksmali Workflow - Unblock Phase 6 #

**Date:** 2026-05-01  
**Task:** Phase 6 unblocker - Java → .smali compilation**

---

## Problem #

Phase 6 (Integration Testing) is **BLOCKED** because:
- Extension classes are `.java` sources in `extension/`
- Need `.smali` files for APK patching
- Need: `.java` → `.class` → `.smali`

---

## Step 1: Find Baksmali #

Baksmali comes with apktool. Let me find it:

```bash
# Find apktool.jar location
which apktool
# Usually: /opt/homebrew/bin/apktool.jar

# Baksmali is inside apktool.jar
# Usage: java -jar baksmali.jar -o output.smali input.class
```

---

## Step 2: Compile Java Sources to .class #

```bash
# Set up classpath with Android SDK
export ANDROID_HOME=/opt/homebrew/share/android-commandlinetools
export ANDROID_SDK_ROOT=$ANDROID_HOME

# Find android.jar (platform API)
ls $ANDROID_HOME/platforms/android-*/android.jar | head -1

# Compile BannerHub extension classes
mkdir -p /tmp/bh_classes

# Compile all Java sources
cd /Users/danhimebauch/Developer/BannerHub-6.0-port/extension
javac -cp "$ANDROID_HOME/platforms/android-33/android.jar" \
      -d /tmp/bh_classes \
      *.java

# Check output
find /tmp/bh_classes -name "*.class" | head -10
```

---

## Step 3: Convert .class to .smali with Baksmali #

```bash
# Extract baksmali from apktool.jar (if needed)
cd /tmp
jar xf /opt/homebrew/bin/apktool.jar baksmali.jar

# Or use apktool's bundled baksmali directly
# Apktool's smali/baksmali commands are internal

# Manual baksmali usage:
java -jar baksmali.jar -o output_dir /tmp/bh_classes/*.class

# Better: Convert each .class file
find /tmp/bh_classes -name "*.class" | while read f; do
    out="${f/.class/.smali}"
    java -jar baksmali.jar -o "$out" "$f"
done
```

---

## Step 4: Organize into smali_classes7/ and smali_classes8/ #

```bash
# GOG + Epic → smali_classes7/
mkdir -p /Users/danhimebauch/Developer/BannerHub-6.0-port/patches/smali_classes7/com/revanced/extension/gamehub/
cp -r /tmp/bh_smali_output/com/revanced/extension/gamehub/gog/ \
      /Users/danhimebauch/Developer/BannerHub-6.0-port/patches/smali_classes7/com/revanced/extension/gamehub/
cp -r /tmp/bh_smali_output/com/revanced/extension/gamehub/epic/ \
      /Users/danhimebauch/Developer/BannerHub-6.0-port/patches/smali_classes7/com/revanced/extension/gamehub/

# Amazon + helpers → smali_classes8/
mkdir -p /Users/danhimebauch/Developer/BannerHub-6.0-port/patches/smali_classes8/com/revanced/extension/gamehub/
cp -r /tmp/bh_smali_output/com/revanced/extension/gamehub/amazon/ \
      /Users/danhimebauch/Developer/BannerHub-6.0-port/patches/smali_classes8/com/revanced/extension/gamehub/
cp -r /tmp/bh_smali_output/com/revanced/extension/gamehub/bh/ \
      /Users/danhimebauch/Developer/BannerHub-6.0-port/patches/smali_classes8/com/revanced/extension/gamehub/
```

---

## Step 5: Test Build with Extension Classes #

```bash
# Apply patches to 6.0.0 base
cd /tmp
rm -rf bh6_with_extensions
cp -r /tmp/apk-compare/gamehub-6.0.0 bh6_with_extensions

# Copy smali_classes7/ and smali_classes8/ to decompiled tree
cp -r /Users/danhimebauch/Developer/BannerHub-6.0-port/patches/smali_classes7 \
      bh6_with_extensions/
cp -r /Users/danhimebauch/Developer/BannerHub-6.0-port/patches/smali_classes8 \
      bh6_with_extensions/

# Build APK
apktool b bh6_with_extensions -o bh6_with_extensions.apk

# Sign and install
/opt/homebrew/share/android-commandlinetools/build-tools/*/apksigner sign \
    --key /Users/danhimebauch/Developer/BannerHub-6.0-port/testkey.pk8 \
    --cert /Users/danhimebauch/Developer/BannerHub-6.0-port/testkey.x509.pem \
    --out bh6_ext_signed.apk bh6_with_extensions.apk

adb install bh6_ext_signed.apk
```

---

## BannerHub 5.3.5 Build System #

The BannerHub repo likely has a build script. Let me check:

```bash
ls /Users/danhimebauch/Developer/BannerHub/*.gradle 2>/dev/null
# Or check for build scripts
find /Users/danhimebauch/Developer/BannerHub -name "build.sh" -o -name "compile*.sh" 2>/dev/null
```

If BannerHub has a build system, use it to compile extension classes properly with correct classpath.

---

## Next Steps (Iteration 10) #

1. **Set up baksmali workflow** (documented above)
2. **Compile extension classes** (GOG, Epic, Amazon, core)
3. **Convert to .smali** and organize into smali_classes7/8/
4. **Test build** with extensions included
5. **Phase 6 UNBLOCKED!** → Integration testing can begin

---

**Status:** Baksmali workflow documented - Phase 6 unblocker  
**Next:** Actually execute this workflow (compile + convert + test build)
