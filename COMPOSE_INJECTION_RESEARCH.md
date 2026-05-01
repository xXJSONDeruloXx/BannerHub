# Compose Injection Research - BannerHub 6.0

**Date:** 2026-05-01  
**Task:** Item 3.1 - Research Compose injection approach

---

## MainActivity UI Analysis

### Confirmed: MainActivity Uses Jetpack Compose

From analyzing `smali_classes3/com/xiaoji/egggame/MainActivity.smali`:

1. **No `setContentView` call found** - Confirms Compose-based UI
2. **Key Compose setup calls in `onCreate`:**
   - `Lbao;->E(Landroidx/activity/ComponentActivity;)V` - likely `setContent` wrapper
   - `Las5;->a(Lmr6;)V` - sets Compose content lambda
   - `Le03;->a(Landroidx/activity/ComponentActivity;Ld23;)V` - additional Compose setup

3. **Lifecycle/Compose integration:**
   - Method `f(Landroid/content/Intent;)V` uses `Landroidx/lifecycle/Lifecycle` and `Lnt3;->s0(Lii3;Lzh3;Lmr6;I)Lm1k;` (likely Compose navigation)

### Compose UI Injection Options

#### Option A: Patch Existing Compose Content (DIFFICULT)
- Find the lambda passed to `setContent`
- Patch it to add tab composables
- **Problem:** Compose compiler changes method signatures across versions
  - Composables get extra `Composer` + flag parameters
  - Example: `@Composable fun Hello(name: String)` becomes `(Ljava/lang/String;Landroidx/compose/runtime/Composer;I)V`
- **Risk:** Very difficult to hand-write in smali

#### Option B: Inject Traditional Views via AndroidView (RECOMMENDED)
- Use `AndroidView` composable to wrap traditional Android Views
- Inject a `LinearLayout` or `TabLayout` with GOG/Epic/Amazon tabs
- **Advantage:** Can reuse BannerHub's existing View-based tab code from 5.3.5
- **Approach:** Patch the content lambda to include an `AndroidView` that inflates a traditional layout

#### Option C: Add New ComposeView to Window (SIMPLEST)
- Get the `Window` decor view
- Add a traditional `View` (like a `TabLayout`) on top of the Compose UI
- **Approach:** Similar to 5.3.5 approach but applied to Compose activity
- **Code:** In `onCreate` after Compose setup, get `Window.getDecorView()` and add tabs as overlay

---

## Recommended Approach: Option C (View Overlay)

### Why?
1. **Simplest to implement in smali** - no need to understand Compose compiler internals
2. **Reuses existing BannerHub tab code** - the `LandscapeLauncherMainActivity` patches from 5.3.5
3. **Non-invasive** - doesn't modify the Compose content directly

### Implementation Plan

1. **In `MainActivity.onCreate` after Compose setup:**
   - Get `Window.getDecorView()`
   - Create a horizontal `LinearLayout` for tabs
   - Add three `Button` views (GOG, Epic, Amazon)
   - Set onClick listeners to launch respective activities

2. **Position the tab bar:**
   - Use `FrameLayout.LayoutParams` to position at top of screen
   - Match parent width, wrap content height
   - Set elevation/GONE state as needed

3. **Style the tabs:**
   - Reuse colors/styles from BannerHub 5.3.5 tab implementation
   - Or keep simple and iterate

---

## Proof-of-Concept Plan (Item 3.2)

### Step 1: Decompile 6.0.0 Base APK
```bash
apktool d base.apk -o /tmp/bh6_test
```

### Step 2: Patch MainActivity.smali
After the Compose setup in `onCreate`, inject:
```smali
# Get Window decor view
invoke-virtual {p0}, Landroid/app/Activity;->getWindow()Landroid/view/Window;
move-result-object v0
invoke-virtual {v0}, Landroid/view/Window;->getDecorView()Landroid/view/View;
move-result-object v0

# Create LinearLayout
new-instance v1, Landroid/widget/LinearLayout;
invoke-direct {v1, p0}, Landroid/widget/LinearLayout;-><init>(Landroid/content/Context;)V

# Add to decor view
check-cast v0, Landroid/view/ViewGroup;
invoke-virtual {v0, v1}, Landroid/view/ViewGroup;->addView(Landroid/view/View;)V
```

### Step 3: Rebuild and Test
```bash
apktool b /tmp/bh6_test -o /tmp/bh6_test.apk
# Sign and install
```

### Step 4: Verify Tab Bar Appears
- Launch app
- Check if tab bar visible at top of MainActivity
- If working, add click listeners and style

---

## References

1. **ComponentActivity.setContent** - https://developer.android.com/reference/kotlin/androidx/activity/compose/package-summary
2. **Compose Tabs** - https://developer.android.com/develop/ui/compose/components/tabs
3. **AndroidView composable** - wraps traditional Views in Compose
4. **Compose compiler plugin** - changes method signatures: https://foso.github.io/Jetpack-Compose-Playground/general/compiler_plugin/

---

## Next Steps

- [ ] Item 3.1 COMPLETE - Research documented
- [ ] Item 3.2 IN PROGRESS - Create proof-of-concept
  - [ ] Decompile 6.0.0 base APK
  - [ ] Patch MainActivity to add View overlay
  - [ ] Rebuild and test
  - [ ] Verify tabs appear

---

**Status:** Item 3.1 complete. Proceeding to Item 3.2 proof-of-concept.
