# Phase 4 Progress & Blockers - Sidebar Retargeting

**Date:** 2026-05-01  
**Task:** Items 4.1-4.6 - Sidebar/HUD Retargeting`

---

## Progress Summary

### ✅ COMPLETED (Items 4.1-4.2)
- **Item 4.1** - Map sidebar classes to `com.winemu.*` ✓
  - Mapped `com/xj/winemu/sidebar/` → `com/winemu/ui/` for 38+ patches
  - Copied ALL HUD/RTS/Performance/TaskManager/Misc patches to `patches/smali_classes3/com/winemu/ui/`
  
- **Item 4.2** - Retarget HUD injection (15 patches) ✓
  - Updated `BhHudInjector.smali`, `BhHudOpacityListener.smali`, etc.
  - Copied `HUDLayer.smali` from 6.0.0 decompile as base

---

## 🚫 BLOCKED (Items 4.3-4.6)

### Blocker: `SidebarSwitchItemView` Not Found in 6.0.0

**Affected Patches:**
- `RtsSwitchClickListener.smali` (Item 4.3 - RTS controls)
- `BhHudStyleSwitchListener.smali` (Item 4.2 - HUD, partially done)
- `BhPerfSetupDelegate.smali` (Item 4.4 - Performance sidebar)

**Issue:**
```
# Old 5.3.5 reference:
Lcom/xj/winemu/view/SidebarSwitchItemView;

# Updated to 6.0.0:
Lcom/winemu/ui/SidebarSwitchItemView;  ← CLASS DOESN'T EXIST!
```

**Investigation:**
- Searched `/tmp/apk-compare/gamehub-6.0.0/` - no `SidebarSwitchItemView` found
- The class was likely removed/refactored in 6.0.0
- 6.0.0 uses `com/winemu/ui/HUDLayer` and `UnifiedHUDView` instead

---

## Recommendation

### Option A: Skip RTS + Performance Patches
- The `SidebarSwitchItemView` functionality might be handled differently in 6.0.0
- Skip Items 4.3-4.6 for now
- Document as "Needs investigation"

### Option B: Find Alternative Implementation
- Decompile BannerHub 5.3.5 fully
- See what `SidebarSwitchItemView` actually does
- Reimplement similar functionality for 6.0.0's UI

### Option C: Pivot to Phase 5.5 (AndroidManifest Registration)
- Java sources are copied (Items 5.1-5.4 ✓)
- Register them in AndroidManifest.xml
- This is a prerequisite for testing

---

## Current State

### Files in `patches/smali_classes3/com/winemu/ui/`:
- ✅ HUD patches (BhHud*.smali) - 5 files
- ✅ RTS patches (Rts*.smali) - 10 files (BUT BLOCKED)
- ✅ Performance patches (BhPerf*.smali) - BLOCKED
- ✅ Task Manager patches (BhTask*.smali) - 8 files
- ✅ Misc patches (Bh*.smali) - 15+ files

### Next Steps
1. **Commit current progress** (even though blocked)
2. **Document blocker** in task file
3. **Pivot to Phase 5.5** - Register extension classes in AndroidManifest.xml
4. **Or pivot to Phase 6** - Integration testing (if compilation works)

---

**Status:** Phase 4 IN PROGRESS - blocked on `SidebarSwitchItemView` missing class  
**Next:** Pivot to Phase 5.5 (AndroidManifest) or Phase 6 (Integration Testing)
