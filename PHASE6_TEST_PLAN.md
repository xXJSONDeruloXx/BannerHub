# Phase 6: Integration Testing Plan - BannerHub 6.0

**Date:** 2026-05-01  
**Task:** Phase 6 - Items 6.1-6.6 Integration Testing Plan`

---

## Overview

Once BannerHub extension classes are compiled (`.smali` files ready), this is the testing checklist.

**Prerequisites:**
- [ ] Phase 5 COMPLETE (extension classes compiled + in `smali_classes7/`, `smali_classes8/`)
- [ ] Phase 4 COMPLETE (sidebar/HUD patches applied)
- [ ] Build script updated (`BUILD_6.0_UPDATE.md`)
- [ ] APK built, signed, and installed on test device

---

## Test Checklist

### Item 6.1 - Test GOG Integration

**Prerequisites:**
- [ ] `GogMainActivity`, `GogLoginActivity`, `GogGamesActivity`, `GogGameDetailActivity` compiled + in `smali_classes7/`
- [ ] `GogDownloadManager`, `GogLaunchHelper` in `smali_classes7/`
- [ ] OAuth redirect configured (manifest intent-filter)

**Test Steps:**
1. **Launch GOG tab/activity**
   - [ ] App doesn't crash on GOG MainActivity launch
   - [ ] UI loads (games list or login prompt)

2. **OAuth Login**
   - [ ] Tap "Login" → WebView opens GOG OAuth page
   - [ ] Login with test account
   - [ ] OAuth redirect captured → tokens stored in `bh_gog_prefs`
   - [ ] Activity returns to GOG games list

3. **Library Sync**
   - [ ] Library syncs (Gen 1 + Gen 2 games)
   - [ ] Games display with cover art, title, developer
   - [ ] Install state shown correctly (Not Installed / Installed)

4. **Download Pipeline**
   - [ ] Tap "Install" on a game
   - [ ] Confirmation dialog shows (size + storage)
   - [ ] Download starts (notification appears)
   - [ ] Progress updates in real-time (filename, %, MB/s)
   - [ ] Download completes → files in `filesDir/gog_games/{title}/`

5. **Launch Game**
   - [ ] Tap "Play" on installed game
   - [ ] Game launches via Wine
   - [ ] HUD overlay appears (if enabled)

**Known Issues:**
- GOG Gen 1 vs Gen 2 download logic (see `GOG_IMPLEMENTATION.md`)
- Token refresh (auto-refresh before expiry)

---

### Item 6.2 - Test Epic Integration

**Prerequisites:**
- [ ] `EpicMainActivity`, `EpicLoginActivity`, `EpicGamesActivity`, `EpicGameDetailActivity` compiled + in `smali_classes7/`
- [ ] `EpicApiClient`, `EpicAuthClient` in `smali_classes7/`

**Test Steps:**
1. **Launch Epic tab/activity**
   - [ ] App doesn't crash on Epic MainActivity launch

2. **OAuth Login**
   - [ ] Tap "Login" → WebView opens Epic OAuth
   - [ ] Login with test account
   - [ ] Tokens stored in `bh_epic_prefs`

3. **Library + Free Games**
   - [ ] Library syncs
   - [ ] Free Games section shows (if implemented)
   - [ ] Games display correctly

4. **Download + Launch**
   - [ ] Install a free game
   - [ ] Launch game via Wine

---

### Item 6.3 - Test Amazon Integration

**Prerequisites:**
- [ ] `AmazonMainActivity`, `AmazonLoginActivity`, `AmazonGamesActivity`, `AmazonGameDetailActivity` compiled + in `smali_classes8/`
- [ ] `AmazonApiClient`, `AmazonAuthClient` in `smali_classes8/`
- [ ] PKCE flow implemented (Amazon requires PKCE, not standard OAuth)

**Test Steps:**
1. **Launch Amazon tab/activity**
   - [ ] App doesn't crash

2. **PKCE Login**
   - [ ] Tap "Login" → Amazon OAuth with PKCE
   - [ ] Login successful → tokens stored in `bh_amazon_prefs`

3. **Library Sync + Download**
   - [ ] Games list loads
   - [ ] Install a test game
   - [ ] Launch game

---

### Item 6.4 - Test HUD Overlay

**Prerequisites:**
- [ ] `BhHudInjector.smali` applied to `com/winemu/ui/HUDLayer`
- [ ] `BhFrameRating`, `BhDetailedHud`, `BhKonkrHud` in `smali_classes7/`
- [ ] `hud_prefs` SharedPreferences configured

**Test Steps:**
1. **Normal HUD**
   - [ ] Enable "Winlator HUD" in settings
   - [ ] Start a game
   - [ ] HUD appears (FPS, CPU/GPU usage, etc.)
   - [ ] HUD positioned correctly (draggable?)
   - [ ] Opacity slider works

2. **Extra Detailed HUD**
   - [ ] Enable "HUD Extra Detail" in settings
   - [ ] HUD shows additional metrics (per-core CPU, RAM, SWAP, temp)
   - [ ] Konkr Style HUD**
   - [ ] Enable "HUD Konkr Style" in settings
   - [ ] HUD switches to Konkr layout

4. **HUD Settings**
   - [ ] Change HUD position (left/right/top/bottom)
   - [ ] Change opacity (slider works)
   - [ ] Switch between Normal/Extra/Konkr styles

---

### Item 6.5 - Test RTS Controls

**Prerequisites:**
- [ ] `RtsSwitchClickListener.smali` + `RtsGestureConfigDialog*.smali` applied**
- [ ] **BLOCKER:** `SidebarSwitchItemView` class missing in 6.0.0!**

**Test Steps (if unblocked):**
1. **Enable RTS Controls**
   - [ ] Toggle RTS mode in sidebar
   - [ ] RTS overlay appears

2. **Gesture Configuration**
   - [ ] Open RTS gesture config dialog
   - [ ] Map gestures (tap, double-tap, long-press, swipe)
   - [ ] Test gestures in-game

---

### Item 6.6 - Test Remaining Features

**Performance Sidebar Toggles (Item 4.4):**
- [ ] API selector (Vulkan/OpenGL/Direct3D)
- [ ] Storage toggle (Internal/SD Card) - requires root or SAF
- [ ] Root grant helper (if device rooted)

**Task Manager (Item 4.5):**
- [ ] Open Task Manager from sidebar
- [ ] Browse running Wine processes
- [ ] Kill a process
- [ ] Launch new executable

**Misc Sidebar (Item 4.6):**
- [ ] Folder browser
- [ ] Tab switching (GOG/Epic/Amazon tabs)

**Core BannerHub Features:**
- [ ] `BhDownloadService` - foreground service + notification
- [ ] `BhGameConfigsActivity` - per-game config editor
- [ ] `BhSettingsExporter` - export/import configs
- [ ] External storage (SD card) routing

---

## Testing Environment

**Test Device:**
- Model: ___________
- Android version: ___________
- Rooted: ___________
- GameHub 6.0.0 base installed: ___________

**Test Accounts:**
- GOG: ___________
- Epic: ___________
- Amazon: ___________

**Logging:**
```bash
# Watch BannerHub logs
adb logcat | grep -E "BannerHub|Bh|Gog|Epic|Amazon"

# Watch for crashes
adb logcat | grep AndroidRuntime
```

---

## Test Tracking

| Item | Status | Notes |
|------|--------|-------|
| 6.1 GOG | PENDING | Blocked on compilation |
| 6.2 Epic | PENDING | Blocked on compilation |
| 6.3 Amazon | PENDING | Blocked on compilation |
| 6.4 HUD | PENDING | Depends on Phase 4 |
| 6.5 RTS | 🚫 BLOCKED | SidebarSwitchItemView missing |
| 6.6 Misc | PENDING | Depends on Phase 4 |

---

**Next:** Complete Java → smali compilation, then execute this test plan!
