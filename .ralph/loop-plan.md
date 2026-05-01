# BannerHub 6.0 Forward-Port Ralph Loop Plan

**Branch:** `feat/forward-port-6.0`  
**Worktree:** `/Users/danhimebauch/Developer/BannerHub-6.0-port`  
**Base APK:** `GameHub_beta_6.0.0_global.apk` (in `~/Downloads/`)  
**Reference APK:** `GameHub_5.3.5_e5e1b35b774c482a66333afc51eb14b2.apk`  

---

## Overview

Forward-port BannerHub from GameHub 5.3.5 to GameHub 6.0.0 beta. This is a **major architectural rewrite** requiring:

- New package structure mapping (`com.xj.*` → `com.xiaoji.egggame.features.*` + `com.winemu.*`)
- Compose UI injection (replacing XML layout patching)
- DEX reallocation (11 DEXs → 6 DEXs)
- 77+ sidebar patch retargeting

**Estimated effort:** 12-19 days of development work

---

## Loop Phases

### Phase 1: Reconnaissance (Items 1-5)

**Goal:** Map the new 6.0.0 architecture thoroughly

- [ ] **Item 1.1** - Inventory 6.0.0 packages
  - List all packages in `com.xiaoji.egggame.*` and `com.winemu.*`
  - Map equivalent classes from 5.3.5 `com.xj.*`
  
- [ ] **Item 1.2** - Analyze MainActivity (new launcher)
  - Decompile and analyze `com.xiaoji.egggame.MainActivity`
  - Determine if Compose or traditional Views
  - Map to old `LandscapeLauncherMainActivity`
  
- [ ] **Item 1.3** - Map winemu package
  - Catalog all `com.winemu.*` classes
  - Find sidebar/controls equivalents
  - Identify HUD/RTS injection points
  
- [ ] **Item 1.4** - Document Compose usage
  - Search for `androidx.compose` references
  - Identify which screens are Compose vs traditional
  - Research Compose injection patterns
  
- [ ] **Item 1.5** - Create class mapping document
  - For each BannerHub patch, document the 6.0.0 equivalent class
  - Mark patches as: Direct port / Needs rewrite / Skip (feature removed)

**Deliverable:** `CLASS_MAPPING_6.0.md`

---

### Phase 2: Infrastructure Setup (Items 6-8)

**Goal:** Set up build system for 6.0.0 base

- [ ] **Item 2.1** - Copy 6.0.0 APK to worktree
  - Copy `~/Downloads/GameHub_beta_6.0.0_global.apk` to worktree
  - Document APK details (package, version, signatures)
  
- [ ] **Item 2.2** - Restructure patches directory
  - Create new DEX directories: `smali7/`, `smali8/` for BannerHub extensions
  - Mirror 6.0.0 DEX structure (6 DEXs only)
  - Move existing patches to appropriate new locations
  
- [ ] **Item 2.3** - Update build scripts
  - Modify `build.gradle` or CI scripts for new base APK
  - Test that added DEX files (smali7+, smali8+) load correctly
  - Verify apktool rebuild works with new structure

**Deliverable:** Working build system that can produce a signed APK from 6.0.0 base

---

### Phase 3: Main Launcher Injection (Items 9-12)

**Goal:** Add GOG/Epic/Amazon tabs to new MainActivity

- [ ] **Item 3.1** - Research Compose injection approach
  - If MainActivity is Compose: learn Compose UI injection
  - If traditional Views: patch similar to 5.3.5 approach
  - Document chosen approach
  
- [ ] **Item 3.2** - Create tab injection proof-of-concept
  - Add a simple test tab/button to MainActivity
  - Verify it appears in rebuilt APK
  - Test that injection doesn't crash app
  
- [ ] **Item 3.3** - Port LandscapeLauncherMainActivity patch
  - Adapt `patches/smali_classes11/.../LandscapeLauncherMainActivity.smali`
  - Rewrite for new MainActivity structure
  - Add GOG tab button
  
- [ ] **Item 3.4** - Add all store tabs
  - Add Epic Games tab
  - Add Amazon Games tab
  - Verify tab navigation works
  - Test with stub activities first

**Deliverable:** MainActivity with 3 new tabs (GOG, Epic, Amazon) that don't crash

---

### Phase 4: Sidebar/HUD Retargeting (Items 13-17)

**Goal:** Retarget all 77 sidebar patches to new `com.winemu.*` package

- [ ] **Item 4.1** - Map sidebar classes
  - Find equivalent of `SidebarControlsFragment` in 6.0.0
  - Find equivalent of `SidebarPerformanceFragment`
  - Map all 77 patch files to new class names
  
- [ ] **Item 4.2** - Retarget HUD injection (15 patches)
  - `BhHudInjector.smali`
  - `BhHudOpacityListener.smali`
  - `BhHudExtraDetailListener.smali`
  - `BhHudKonkrListener.smali`
  - `BhHudStyleSwitchListener.smali`
  
- [ ] **Item 4.3** - Retarget RTS controls (10 patches)
  - `RtsSwitchClickListener.smali`
  - `RtsGestureConfigDialog*.smali` (8 files)
  
- [ ] **Item 4.4** - Retarget Performance sidebar (20 patches)
  - `BhPerfSetupDelegate.smali`
  - `BhApiSelectorListener.smali`
  - `BhStorageToggleListener.smali`
  - `BhRootGrantHelper*.smali` (3 files)
  
- [ ] **Item 4.5** - Retarget Task Manager (15 patches)
  - `BhTaskManagerFragment*.smali` (8 files)
  - `BhBrowseToRunnable.smali`
  - `BhExeLaunchListener.smali`
  - `BhKillListener.smali`
  
- [ ] **Item 4.6** - Retarget misc sidebar (17 patches)
  - `BhTabListener.smali`
  - `BhFolderListener.smali`
  - Remaining patches

**Deliverable:** All 77 sidebar patches working in 6.0.0

---

### Phase 5: Extension Classes (Items 18-22)

**Goal:** Add BannerHub-specific activities and services

- [ ] **Item 5.1** - Copy GOG activities (6 classes)
  - `GogMainActivity`, `GogLoginActivity`, `GogGamesActivity`
  - `GogGameDetailActivity`, `GogDownloadManager`, `GogLaunchHelper`
  - Place in appropriate DEX (smali7 or smali8)
  
- [ ] **Item 5.2** - Copy Epic activities (7 classes)
  - `EpicMainActivity`, `EpicLoginActivity`, `EpicGamesActivity`
  - `EpicGameDetailActivity`, `EpicFreeGamesActivity`
  - `EpicApiClient`, `EpicAuthClient`
  
- [ ] **Item 5.3** - Copy Amazon activities (8 classes)
  - `AmazonMainActivity`, `AmazonLoginActivity`, `AmazonGamesActivity`
  - `AmazonGameDetailActivity`, `AmazonApiClient`, `AmazonAuthClient`
  - `AmazonLaunchHelper`, `AmazonManifest`
  
- [ ] **Item 5.4** - Copy core BannerHub classes
  - `BhDownloadService` + helpers
  - `BhGameConfigsActivity`
  - `BhSettingsExporter`
  - `BhStoragePath`
  - `BhWineLaunchHelper`
  
- [ ] **Item 5.5** - Register in AndroidManifest.xml
  - Add all activities with correct intent filters
  - Add BhDownloadService declaration
  - Verify component registration

**Deliverable:** All BannerHub extension classes compiled and registered

---

### Phase 6: Integration Testing (Items 23-28)

**Goal:** End-to-end testing of all BannerHub features

- [ ] **Item 6.1** - Test GOG integration
  - GOG login (OAuth flow)
  - Library sync
  - Game download
  - Game launch
  
- [ ] **Item 6.2** - Test Epic integration
  - Epic login (OAuth flow)
  - Library sync
  - Game download
  - Game launch
  
- [ ] **Item 6.3** - Test Amazon integration
  - Amazon login (PKCE flow)
  - Library sync
  - Game download
  - Game launch
  
- [ ] **Item 6.4** - Test HUD overlay
  - Normal HUD
  - Extra Detailed HUD
  - Konkr Style HUD
  - Position, opacity, orientation
  
- [ ] **Item 6.5** - Test RTS controls
  - Enable/disable
  - Gesture mapping
  - Configuration dialog
  
- [ ] **Item 6.6** - Test remaining features
  - Config export/import
  - Storage routing (SD card)
  - Component Manager
  - Performance toggles (root)

**Deliverable:** All features working, bugs documented and fixed

---

### Phase 7: Polish & Release Prep (Items 29-30)

**Goal:** Prepare for stable release

- [ ] **Item 7.1** - Update documentation
  - Update README for 6.0.0 base
  - Document new features/changes
  - Update screenshots if needed
  
- [ ] **Item 7.2** - Build all variants
  - Normal (`banner.hub`)
  - Normal.GHL (`gamehub.lite`)
  - PuBG (`com.tencent.ig`)
  - All other variants
  
- [ ] **Item 7.3** - Test upgrade path
  - Install 5.3.5 BannerHub
  - Upgrade to 6.0.0 build
  - Verify data migration
  
- [ ] **Item 7.4** - Create GitHub release
  - Tag and release
  - Upload all APK variants
  - Write release notes

**Deliverable:** v4.0.0 (or v3.6.0) stable release on GitHub

---

## Loop Configuration

```yaml
name: "fwd-port-6.0"
maxIterations: 30
itemsPerIteration: 1-2
reflectEvery: 5

# Progress tracking
checklist:
  - phase1_recon_done: false
  - phase2_infra_done: false
  - phase3_launcher_done: false
  - phase4_sidebar_done: false
  - phase5_extensions_done: false
  - phase6_testing_done: false
  - phase7_release_done: false
```

---

## Notes

- Each item should result in a git commit with clear message
- Use `FWD_PORT_6.0_ASSESSMENT.md` as reference
- When stuck, use `web_search` for Compose injection patterns
- Test early and often - don't batch too many changes
- Keep main branch clean - all work in `feat/forward-port-6.0`

---

## Quick Reference

**Key files:**
- Assessment: `FWD_PORT_6.0_ASSESSMENT.md`
- Class mapping: `CLASS_MAPPING_6.0.md` (create in Phase 1)
- Patches directory: `patches/`
- Build scripts: TBD (Phase 2)

**APK locations:**
- 6.0.0 base: `~/Downloads/GameHub_beta_6.0.0_global.apk`
- 5.3.5 reference: `~/Downloads/GameHub_5.3.5_e5e1b35b774c482a66333afc51eb14b2.apk`
- Decompiled: `/tmp/apk-compare/gamehub-6.0.0/` and `/tmp/apk-compare/gamehub-5.3.5/`

**DEX allocation (6.0.0):**
- `smali/` - ~10K files (keep as-is)
- `smali_classes2/` - ~7K files (keep as-is)
- `smali_classes3/` - ~8K files (keep as-is)
- `smali_classes4/` - ~14K files (BannerHub extensions go here)
- `smali_classes5/` - ~11K files (BannerHub extensions go here)
- `smali_classes6/` - ~4K files (keep as-is)
- `smali_classes7/` - CREATE (BannerHub extensions)
- `smali_classes8/` - CREATE (BannerHub extensions)
