# BannerHub 6.0 Forward-Port Loop

**Branch:** `feat/forward-port-6.0`  
**Reflection (Iteration 6):** Phase 4 blocked on missing class

---

## Reflection Summary

### What's Been Accomplished
- **Phase 1 ✓** - Reconnaissance complete (CLASS_MAPPING_6.0.md)
- **Phase 2 ✓** - Infrastructure complete (BUILD_6.0_UPDATE.md)
- **Phase 3 ~** - Tab injection BLOCKED (VerifyError - needs BannerHubHelper)
- **Phase 4 ~** - Sidebar retargeting IN PROGRESS
  - Items 4.1-4.2 ✓ (HUD injection - 15 patches done)
  - Items 4.3-4.6 🚫 (BLOCKED: `SidebarSwitchItemView` missing in 6.0.0)
- **Phase 5 ~** - Extension classes IN PROGRESS
  - Items 5.1-5.4 ✓ (Java sources copied to extension/)
  - Item 5.5 (AndroidManifest) - PENDING compilation

### What's Working Well
- HUD/sidebar patch retargeting (Python/sed automation)
- Documentation (comprehensive reference files)
- Toast proof-of-concept verified

### Blocking Issues
1. **Tab injection** - VerifyError (exception handling in onCreate)
2. **SidebarSwitchItemView** - Class doesn't exist in 6.0.0
3. **Java → smali** - Need baksmali workflow for extension classes

### Approach Adjustment
- **Skip Phase 3** for now (tab injection) - use BannerHubHelper approach later
- **Skip Phase 4.3-4.6** - investigate `SidebarSwitchItemView` replacement
- **Pivot to Phase 5.5** - Register extension classes in AndroidManifest.xml
- **Then Phase 6** - Integration testing (if compilation works)

---

## Phase Checklist (Updated)

### Phase4: Sidebar/HUD Retargeting - BLOCKED
- [x] **Item 4.1** - Map sidebar classes ✓
- [x] **Item 4.2** - Retarget HUD injection ✓
- [🚫] **Item 4.3** - Retarget RTS controls (BLOCKED)
- [🚫] **Item 4.4** - Retarget Performance sidebar (BLOCKED)
- [ ] **Item 4.5** - Retarget Task Manager (partially done)
- [ ] **Item 4.6** - Retarget misc sidebar (partially done)

**Blocker:** `SidebarSwitchItemView` class not found in 6.0.0
**See:** `PHASE4_BLOCKER.md` for details

### Phase5: Extension Classes - IN PROGRESS
- [x] **Item 5.1** - Copy GOG activities (Java sources) ✓
- [x] **Item 5.2** - Copy Epic activities (Java sources) ✓
- [x] **Item 5.3** - Copy Amazon activities (Java sources) ✓
- [x] **Item 5.4** - Copy core BannerHub classes (Java sources) ✓
- [ ] **Item 5.5** - Register in AndroidManifest.xml ← **NEXT**

---

## Current Item
**Pivot to Phase 5.5** - Register extension classes in AndroidManifest.xml
(**Reasoning:** Java sources are copied, need to register them for testing)
