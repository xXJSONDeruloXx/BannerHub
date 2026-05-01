# BannerHub 6.0 Port - Progress Report

**Date:** 2026-05-01  
**Branch:** `feat/forward-port-6.0`  
**Base APK:** `GameHub_beta_6.0.0_global.apk`  

---

## Porting Status (Ralph Loop Iteration 8/30)

### ✅ COMPLETED Phases

#### Phase 1: Reconnaissance ✓
- [x] Item 1.1-1.5 - Full package inventory + class mapping
- **Deliverable:** `CLASS_MAPPING_6.0.md`

#### Phase 2: Infrastructure Setup ✓
- [x] Item 2.1-2.3 - Copy APK, restructure patches, build docs
- **Deliverable:** `BUILD_6.0_UPDATE.md`

#### Phase 5: Extension Classes ✓
- [x] Item 5.1-5.5 - All Java sources copied + manifest registered
- **Extension classes:** GOG (6), Epic (7), Amazon (8), Core BannerHub (10+)
- **Location:** `extension/` directory

---

### ~ IN PROGRESS Phases

#### Phase 3: Main Launcher Injection ~ (BLOCKED)
- [x] Item 3.1-3.2 - Compose research + Toast proof-of-concept ✓
- [~] Item 3.3-3.4 - Tab injection (VerifyError exception conflict)
- **Blocker:** Tab injection fails with VerifyError (exception handling in onCreate)
- **Solution:** BannerHubHelper separate class (documented in `TAB_INJECTION_ISSUES.md`)

#### Phase 4: Sidebar/HUD Retargeting ~ (PARTILY DONE)
- [x] Item 4.1-4.2 - Map sidebar classes + HUD injection ✓ (38+ patches)
- [🚫] Items 4.3-4.6 - RTS/Performance/TaskManager (SidebarSwitchItemView missing in 6.0.0)
- **Progress:** `patches/smali_classes3/com/winemu/ui/` - 38+ patched files
- **Blocker:** `SidebarSwitchItemView` class not found in 6.0.0

---

### PENDING Phases

#### Phase 6: Integration Testing (PENDING)
- [ ] Items 6.1-6.6 - GOG/Epic/Amazon/HUD/RTS testing
- **Blocker:** Need compiled `.smali` files (Java → baksmali workflow)

#### Phase 7: Polish & Release Prep (READy TO START)
- [ ] Item 7.1 - Update documentation ← **CURRENT ITERATION**
- [ ] Item 7.2 - Build all variants
- [ ] Item 7.3 - Test upgrade path
- [ ] Item 7.4 - Create GitHub release

---

## Key Reference Files

| File | Description | Status |
|------|-------------|--------|
| `CLASS_MAPPING_6.0.md` | Phase 1 deliverable - class mapping 5.3.5 → 6.0.0 | ✅ Complete |
| `BUILD_6.0_UPDATE.md` | Phase 2 deliverable - build script updates | ✅ Complete |
| `COMPOSE_INJECTION_RESEARCH.md` | Phase 3 - Compose injection research | ✅ Complete |
| `PROF_OF_CONCEPT_COMPLETE.md` | Phase 3 - Toast injection verified | ✅ Complete |
| `TAB_INJECTION_ISSUES.md` | Phase 3 - Tab injection blockers + solution | ✅ Complete |
| `PHASE4_BLOCKER.md` | Phase 4 - SidebarSwitchItemView issue | ✅ Complete |
| `EXTENSION_BUILD_GUIDE.md` | Phase 5 - Java → smali compilation | ✅ Complete |
| `PHASE5_COMPLETE.md` | Phase 5 - All extension classes done | ✅ Complete |
| `PHASE6_TEST_PLAN.md` | Phase 6 - Integration testing checklist | ✅ Complete |

---

## Blocking Issues Summary

### 1. Phase 3: Tab Injection (VerifyError)
**Issue:** `java.lang.VerifyError` when injecting tabs into MainActivity.onCreate()
**Root cause:** Exception handling in onCreate conflicts with injected register usage
**Solution:** Create separate `BannerHubHelper.smali` class with `addTabsToActivity()` method
**Status:** Solution documented, implementation pending

### 2. Phase 4: SidebarSwitchItemView Missing
**Issue:** `com/xj/winemu/view/SidebarSwitchItemView` referenced in RTS/Performance patches doesn't exist in 6.0.0
**Root cause:** GameHub 6.0.0 refactored UI (now uses `com/winemu/ui/HUDLayer`)
**Status:** Items 4.3-4.6 blocked, Items 4.1-4.2 complete (38+ patches retargeted)

### 3. Phase 6: Java → Smali Compilation
**Issue:** Extension classes are Java sources, need `.smali` for APK patching
**Root cause:** Need baksmali workflow (`.java` → `.class` → `.smali`)
**Status:** Build guide created (`EXTENSION_BUILD_GUIDE.md`), workflow pending

---

## Next Steps

### Immediate (Iteration 8):
1. **Item 7.1** - Update documentation (this file + README updates)
2. **Phase 3** - Try BannerHubHelper.smali approach for tab injection

### Short-term:
1. **BannerHubHelper.smali** - Create separate class for tab injection
2. **baksmali workflow** - Compile Java extensions to smali
3. **Items 4.3-4.6** - Investigate SidebarSwitchItemView replacement

### Long-term:
1. **Phase 6** - Full integration testing (GOG, Epic, Amazon)
2. **Phase 7** - Release prep (build variants, GitHub release)

---

**Ralph Loop Progress:** 8/30 iterations completed  
**Overall Progress:** ~40% (Phases 1, 2, 5 complete; Phases 3, 4 partially done; 6, 7 pending)
