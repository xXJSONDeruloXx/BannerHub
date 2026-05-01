# BannerHub 6.0 Class Mapping Document

**Date:** 2026-05-01  
**Base APKs:**
- Source (5.3.5): `GameHub_5.3.5_e5e1b35b774c482a66333afc51eb14b2.apk`
- Target (6.0.0): `GameHub_beta_6.0.0_global.apk`

---

## Executive Summary

**Package Migration:**
- `com.xj.*` → `com.xiaoji.egggame.*` + `com.winemu.*`
- 11 DEXs → 6 DEXs (method count consolidation)
- Traditional Views → Jetpack Compose (1107 smali files reference Compose)

**BannerHub Impact:**
- Main launcher tab injection: **COMPLETE REWRITE** (Compose-based)
- Sidebar/HUD patches (77 files): **HIGH EFFORT** (retarget to `com.winemu.*`)
- Extension classes (GOG/Epic/Amazon): **LOW EFFORT** (bytecode reuse possible)

---

## 1. Package Structure Mapping

### 1.1 Core Package Migration

| Old (5.3.5) | New (6.0.0) | DEX Location (6.0) | Notes |
|--------------|--------------|-------------------|-------|
| `com.xj.landscape.launcher.*` | `com.xiaoji.egggame.features.winemu.launcher` | smali_classes4 | Main launcher moved to features |
| `com.xj.winemu.sidebar.*` | `com.winemu.ui` + `com.xiaoji.egggame.features.winemu.*` | smali_classes3/4 | Sidebar split across packages |
| `com.xj.winemu.*` | `com.winemu.*` | smali_classes3 | Core winemu moved to root |
| `com.xj.module.steam.*` | `com.xiaoji.egggame.common.steam.*` | smali_classes4 | Steam module in common |
| `com.xj.ota.*` | `com.xiaoji.egggame.common.gamepadota.*` | smali_classes4 | OTA in common package |

### 1.2 Key Class Mapping

#### Main Launcher
| 5.3.5 Class | 6.0.0 Equivalent | Status | BannerHub Patch Action |
|-------------|------------------|--------|----------------------|
| `com.xj.landscape.launcher.ui.main.LandscapeLauncherMainActivity` | `com.xiaoji.egggame.MainActivity` | **Compose Rewrite** | Must rewrite tab injection for Compose |
| (no direct equivalent) | `com.xiaoji.egggame.features.winemu.launcher.*` | New | May contain launcher fragments |

#### Sidebar/HUD Classes
| 5.3.5 Class | 6.0.0 Equivalent | Status | BannerHub Patch Action |
|-------------|------------------|--------|----------------------|
| `com.xj.winemu.sidebar.SidebarControlsFragment` | `com.winemu.ui.UnifiedHUDView` | **Needs Research** | Retarget HUD injection |
| `com.xj.winemu.sidebar.SidebarPerformanceFragment` | `com.winemu.ui.HUDConfig` | **Needs Research** | Retarget performance toggles |
| `com.xj.winemu.sidebar.hud.HUDLayout` | `com.winemu.ui.HUDLayer` | **Needs Research** | Retarget HUD overlay |
| (unknown) | `com.xiaoji.egggame.features.winemu.ui.gameSetting.*` | New | Game settings UI (Compose) |

#### Core WinEmu Classes
| 5.3.5 Package | 6.0.0 Package | DEX |
|--------------|--------------|-----|
| `com.xj.winemu.core.*` | `com.winemu.core.*` | smali_classes3 |
| `com.xj.winemu.core.input.*` | `com.winemu.core.input.*` | smali_classes3 |
| `com.xj.winemu.core.gamepad.*` | `com.winemu.core.gamepad.*` | smali_classes3 |
| `com.xj.winemu.core.server.*` | `com.winemu.core.server.*` | smali_classes3 |

---

## 2. BannerHub Patch Inventory & Mapping

### 2.1 Patches to Existing GameHub Classes

#### Main Launcher Patches
| BannerHub Patch File | 5.3.5 Location | 6.0.0 Target | Porting Action | Effort |
|---------------------|----------------|--------------|----------------|--------|
| `LandscapeLauncherMainActivity.smali` | `smali_classes11/com/xj/landscape/launcher/ui/main/` | `smali_classes3/com/xiaoji/egggame/MainActivity.smali` | **REWRITE** - Compose injection needed | **HIGH** (2-3 days) |

#### Sidebar/HUD Patches (77 files in smali_classes16)

**HUD Injection Patches (15 files)**
| Patch File | 5.3.5 Path | 6.0.0 Target | Action |
|-----------|-------------|--------------|--------|
| `BhHudInjector.smali` | `com/xj/winemu/sidebar/hud/` | `com/winemu/ui/HUDLayer` or `UnifiedHUDView` | Retarget |
| `BhHudOpacityListener.smali` | `com/xj/winemu/sidebar/hud/` | TBD (search in com.winemu.ui) | Retarget |
| `BhHudExtraDetailListener.smali` | `com/xj/winemu/sidebar/hud/` | TBD | Retarget |
| `BhHudKonkrListener.smali` | `com/xj/winemu/sidebar/hud/` | TBD | Retarget |
| `BhHudStyleSwitchListener.smali` | `com/xj/winemu/sidebar/hud/` | TBD | Retarget |

**RTS Controls Patches (10 files)**
| Patch File | 5.3.5 Path | 6.0.0 Target | Action |
|-----------|-------------|--------------|--------|
| `RtsSwitchClickListener.smali` | `com/xj/winemu/sidebar/rts/` | TBD in `com.winemu.core.input` or `com.winemu.ui` | Retarget |
| `RtsGestureConfigDialog*.smali` (8 files) | `com/xj/winemu/sidebar/rts/` | TBD | Retarget |

**Performance Sidebar Patches (20 files)**
| Patch File | 5.3.5 Path | 6.0.0 Target | Action |
|-----------|-------------|--------------|--------|
| `BhPerfSetupDelegate.smali` | `com/xj/winemu/sidebar/perf/` | TBD in `com.winemu.ui` or `com.xiaoji.egggame.features.winemu.perf` | Retarget |
| `BhApiSelectorListener.smali` | `com/xj/winemu/sidebar/perf/` | TBD | Retarget |
| `BhStorageToggleListener.smali` | `com/xj/winemu/sidebar/perf/` | TBD | Retarget |
| `BhRootGrantHelper*.smali` (3 files) | `com/xj/winemu/sidebar/perf/` | TBD | Retarget |

**Task Manager Patches (15 files)**
| Patch File | 5.3.5 Path | 6.0.0 Target | Action |
|-----------|-------------|--------------|--------|
| `BhTaskManagerFragment*.smali` (8 files) | `com/xj/winemu/sidebar/task/` | TBD | Retarget |
| `BhBrowseToRunnable.smali` | `com/xj/winemu/sidebar/task/` | TBD | Retarget |
| `BhExeLaunchListener.smali` | `com/xj/winemu/sidebar/task/` | TBD | Retarget |
| `BhKillListener.smali` | `com/xj/winemu/sidebar/task/` | TBD | Retarget |

**Misc Sidebar Patches (17 files)**
| Patch File | 5.3.5 Path | 6.0.0 Target | Action |
|-----------|-------------|--------------|--------|
| `BhTabListener.smali` | `com/xj/winemu/sidebar/misc/` | TBD | Retarget |
| `BhFolderListener.smali` | `com/xj/winemu/sidebar/misc/` | TBD | Retarget |

### 2.2 BannerHub Extension Classes (New Code - Reusable)

These classes don't exist in stock GameHub and can likely be reused with minimal changes:

| Class | Current DEX (5.3.5) | New DEX (6.0.0) | Purpose | Port Action |
|-------|---------------------|-----------------|---------|-------------|
| **GOG Activities (6 classes)** | | | | |
| `GogMainActivity` | smali_classes16/18 | smali_classes7 | GOG store UI | **COPY** - bytecode reuse |
| `GogLoginActivity` | smali_classes16/18 | smali_classes7 | GOG OAuth login | **COPY** |
| `GogGamesActivity` | smali_classes16/18 | smali_classes7 | GOG games list | **COPY** |
| `GogGameDetailActivity` | smali_classes16/18 | smali_classes7 | GOG game details | **COPY** |
| `GogDownloadManager` | smali_classes16/18 | smali_classes7 | GOG download handling | **COPY** |
| `GogLaunchHelper` | smali_classes16/18 | smali_classes7 | GOG game launch | **COPY** |
| **Epic Activities (7 classes)** | | | | |
| `EpicMainActivity` | smali_classes16/18 | smali_classes7 | Epic store UI | **COPY** |
| `EpicLoginActivity` | smali_classes16/18 | smali_classes7 | Epic OAuth login | **COPY** |
| `EpicGamesActivity` | smali_classes16/18 | smali_classes7 | Epic games list | **COPY** |
| `EpicGameDetailActivity` | smali_classes16/18 | smali_classes7 | Epic game details | **COPY** |
| `EpicFreeGamesActivity` | smali_classes16/18 | smali_classes7 | Epic free games | **COPY** |
| `EpicApiClient` | smali_classes16/18 | smali_classes7 | Epic API wrapper | **COPY** |
| `EpicAuthClient` | smali_classes16/18 | smali_classes7 | Epic auth handling | **COPY** |
| **Amazon Activities (8 classes)** | | | | |
| `AmazonMainActivity` | smali_classes16/18 | smali_classes8 | Amazon store UI | **COPY** |
| `AmazonLoginActivity` | smali_classes16/18 | smali_classes8 | Amazon PKCE login | **COPY** |
| `AmazonGamesActivity` | smali_classes16/18 | smali_classes8 | Amazon games list | **COPY** |
| `AmazonGameDetailActivity` | smali_classes16/18 | smali_classes8 | Amazon game details | **COPY** |
| `AmazonApiClient` | smali_classes16/18 | smali_classes8 | Amazon API wrapper | **COPY** |
| `AmazonAuthClient` | smali_classes16/18 | smali_classes8 | Amazon auth handling | **COPY** |
| `AmazonLaunchHelper` | smali_classes16/18 | smali_classes8 | Amazon game launch | **COPY** |
| `AmazonManifest` | smali_classes16/18 | smali_classes8 | Amazon manifest helpers | **COPY** |
| **Core BannerHub Classes** | | | | |
| `BhDownloadService` + helpers | smali_classes18 | smali_classes7 | Cross-store download manager | **COPY** |
| `BhGameConfigsActivity` | smali_classes18 | smali_classes7/8 | Per-game config editor | **COPY** |
| `BhSettingsExporter` | smali_classes18 | smali_classes7/8 | Config export/import | **COPY** |
| `BhStoragePath` | smali_classes5 | smali_classes4/5 | SD card routing | **COPY** |
| `BhWineLaunchHelper` | smali_classes18 | smali_classes7/8 | Wine launch wrapper | **COPY** |

---

## 3. Compose Usage Analysis

### 3.1 Scope of Compose Adoption
- **1107 smali files** reference `androidx.compose`
- **New activities** like `PcGameSetupComposeActivity` are Compose-based
- **Main launcher** (`MainActivity`) extends `GamepadInputHostActivity` - needs investigation

### 3.2 Compose Injection Strategy
Since the main launcher may be Compose-based, we have two options:

**Option A: Compose Injection (Recommended if MainActivity is Compose)**
- Learn Compose UI injection patterns
- Use `ComposeView` to inject traditional Android Views (tabs)
- Or inject Compose-based tab buttons directly

**Option B: Find Non-Compose Alternative**
- Check if there's a traditional View-based launcher activity
- Patch that instead (similar to 5.3.5 approach)

**Next Step:** Decompile and analyze `MainActivity.smali` to determine UI approach.

---

## 4. DEX Allocation Strategy (6 DEXs only)

### 4.1 Current 6.0.0 DEX Structure
| DEX | File Count | BannerHub Allocation |
|-----|-----------|---------------------|
| `smali/` | ~10K | Keep as-is (core app) |
| `smali_classes2/` | ~7K | Keep as-is |
| `smali_classes3/` | ~8K | Keep as-is (contains com.winemu.*) |
| `smali_classes4/` | ~14K | **Add BannerHub extensions here** |
| `smali_classes5/` | ~11K | **Add BannerHub extensions here** |
| `smali_classes6/` | ~4K | Keep as-is |

### 4.2 BannerHub Extension DEX Plan
Since 6.0.0 only has 6 DEXs, we need to add new ones:

| New DEX | Contents | Class Count |
|---------|----------|-------------|
| `smali_classes7/` | GOG + Epic activities (13 classes) + core helpers | ~15 |
| `smali_classes8/` | Amazon activities (8 classes) + remaining helpers | ~10 |

**Alternative:** If adding DEXs fails, consolidate into smali_classes4/5 (higher method count risk).

---

## 5. Porting Decision Matrix

For each BannerHub patch, decide:

| Decision | Criteria | Count |
|----------|-----------|-------|
| **COPY** | Extension class, no dependency on GameHub internals | ~30 classes |
| **REWRITE** | Patch to GameHub class that changed significantly (Compose, etc.) | ~78 patches (77 sidebar + 1 launcher) |
| **SKIP** | Feature removed in 6.0.0 or not applicable | TBD (after analysis) |

---

## 6. Action Items for Phase 2 (Infrastructure Setup)

1. **Copy 6.0.0 APK to worktree**
   ```bash
   cp ~/Downloads/GameHub_beta_6.0.0_global.apk /Users/danhimebauch/Developer/BannerHub-6.0-port/base.apk
   ```

2. **Create new DEX directories**
   ```bash
   mkdir -p patches/smali7 patches/smali8
   ```

3. **Test DEX loading**
   - Add a simple test class to smali7
   - Rebuild APK and verify it loads

4. **Update build scripts**
   - Modify `build.gradle` or CI to use 6.0.0 base APK
   - Test full build pipeline

---

## 7. Research Needed

Before proceeding to Phase 3 (Launcher Injection):

- [ ] **Analyze MainActivity thoroughly**
  - Read full `MainActivity.smali` (1700+ lines)
  - Determine if UI is Compose or traditional Views
  - Find injection points for tabs

- [ ] **Map all winemu classes**
  - Catalog every class in `com.winemu.*`
  - Find equivalents for all 77 sidebar patches
  - Document new class names and methods

- [ ] **Learn Compose injection**
  - If MainActivity is Compose: research how to inject UI
  - Consider using `AndroidView` to wrap traditional Views
  - Test with a simple "Hello World" tab injection

---

## Appendix A: Useful Commands

### Find class in 6.0.0
```bash
cd /tmp/apk-compare/gamehub-6.0.0
find . -name "ClassName.smali"
```

### Search for method references
```bash
cd /tmp/apk-compare/gamehub-6.0.0
grep -r "methodName" --include="*.smali"
```

### Count Compose usage
```bash
cd /tmp/apk-compare/gamehub-6.0.0
grep -r "androidx.compose" --include="*.smali" -l | wc -l
```

### Compare DEX file counts
```bash
cd /tmp/apk-compare/gamehub-6.0.0
for d in smali smali_classes*; do echo "$d: $(find $d -name "*.smali" | wc -l)"; done
```

---

**Phase 1 Status: COMPLETE** ✓  
**Deliverable:** This document (CLASS_MAPPING_6.0.md)  
**Next Phase:** Phase 2 - Infrastructure Setup
