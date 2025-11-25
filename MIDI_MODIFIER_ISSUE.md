# MIDI Movement & Mac Modifier Key Issue

## Issue Summary
MIDI note movement commands (MoveNote*) are not working. Investigation revealed a potential Mac modifier key mapping issue.

## Current Situation

### The Problem
- All MIDI note movement is broken (Command+HJKL should move notes)
- When testing Control+L, it's actually triggered by Command+L (not Control+L)
- This suggests modifiers are swapped or misinterpreted

### Key Bindings Conflicts Found

**In bindings.lua:**
```lua
global.timeline_motion:
  ["<M-h>"] = "Left10Pix"     (Line 14)
  ["<M-l>"] = "Right10Pix"    (Line 15)
  ["<M-H>"] = "Left40Pix"     (Line 16)
  ["<M-L>"] = "Right40Pix"    (Line 17)

main.command:
  ["<M-j>"] = "NextEnvelope"  (Line 530)
  ["<M-k>"] = "PrevEnvelope"  (Line 531)

midi.command:
  ["<M-k>"] = "MoveNoteUpSemitone"    (Line 607)
  ["<M-j>"] = "MoveNoteDownSemitone"  (Line 608)
  ["<M-K>"] = "MoveNoteUpOctave"      (Line 609)
  ["<M-J>"] = "MoveNoteDownOctave"    (Line 610)
  ["<M-l>"] = "MoveNoteRight"         (Line 611)
  ["<M-h>"] = "MoveNoteLeft"          (Line 612)
```

**Conflict:** `global` bindings for `<M-hjkl>` should be overridden by context-specific `midi.command` bindings, but they're not working.

**This bug exists in gwatcha/master** - not introduced by our merge.

## Mac Modifier Key Mapping

On macOS, the modifier key situation:

**What we expect:**
- `<C-...>` = Control key
- `<M-...>` = Command key (Meta)
- `<S-...>` = Shift key
- `<A-...>` = Option/Alt key → but parser converts this to `<M-...>` (same as Command!)

**How REAPER sends keys:**
- Command key → REAPER sends `A` flag → reaper-keys converts to `M`
- Control key → REAPER sends `C` flag → stays as `C`
- Option key → REAPER sends `A` flag → converts to `M` (same as Command!)

**The anomaly discovered:**
- Binding: `["<C-l>"] = "Next4Beats"`
- Expected: Control+L triggers it
- Actual: **Command+L triggers it!**

This suggests either:
1. REAPER has a preference that swaps Control/Command (likely)
2. reaper-keys is misinterpreting the modifier flags
3. There's platform-specific behavior we're missing

## Hypothesis: REAPER Preference Swap

**Check:** REAPER > Preferences > General > Keyboard/Multitouch

There may be an option like:
- "Use Control key for primary modifier"
- "Swap Cmd and Ctrl keys"
- Some Mac-specific keyboard mapping preference

If this is enabled:
- Command+L → REAPER sends as Control (`C`) → binds as `<C-L>`
- Control+L → REAPER sends as Alt (`A`) → binds as `<M-L>`

This would explain why `<C-...>` bindings respond to Command key!

## Proposed Solutions

### Solution 1: Fix REAPER Preference
If there's a swap preference enabled, disable it so modifiers match expectations.

### Solution 2: Remove Conflicting Global Bindings
Remove `<M-hjkl>` and `<M-HL>` from `global.timeline_motion`:
- Less useful than MIDI note movement or envelope navigation
- Already have `h`/`l` for grid division
- Already have `<C-h>`/`<C-l>` for beat movement
- This lets context-specific bindings work without conflict

### Solution 3: Remap MIDI Movement to Different Keys
Use different key combinations for MIDI note movement that don't conflict.

## Testing Needed

1. **Check REAPER Preferences**
   - Look for Control/Command swap setting
   - Document what's found

2. **Test Control vs Command**
   - Press actual Control+L → what happens?
   - Press actual Command+L → what happens?
   - This will confirm which physical key triggers which binding

3. **Test in MIDI Editor**
   - Open MIDI editor
   - Select a note
   - Try Command+H/J/K/L → should move notes but doesn't
   - Check if any error appears in feedback window

## Mac Modifier Reference

**Unused modifier:** Option/Alt
- Gets converted to `<M-...>` (same as Command)
- Cannot be used separately from Command
- This is due to line 78 in rk.lua: `local alt = mod:match "A" and "M" or nil`

**Available modifiers for unique bindings:**
- Control (`<C-...>`)
- Command (`<M-...>`)
- Shift (`<S-...>`)
- Combinations (e.g., `<CM-...>`, `<CS-...>`, etc.)

## Files Involved
- `internal/definitions/bindings.lua` - Binding definitions
- `internal/definitions/actions.lua` - Action definitions
- `internal/rk.lua` - Key parser (lines 74-96)
- `internal/utils/definitions.lua` - Binding merger (lines 60-66)

## Next Steps
1. Check REAPER preferences for modifier key swap setting
2. Based on findings, decide which solution to implement
3. Test MIDI note movement after fix
4. Consider contributing fix back to gwatcha/master
