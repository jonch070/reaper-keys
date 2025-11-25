# Debug Context - 2025-01-25

## Current Issue: Undefined Key Sequences

### Problem
After merging gwatcha/reaper-keys (2.0.0-a15), certain key bindings are showing "undefined key sequence" in REAPER.

**Specific failing bindings:**
- `["<S-right>"] = "NextRegion"` - Shows "undefined key sequence"
- `["<S-left>"] = "PrevRegion"` - Shows "undefined key sequence"
- Possibly other Shift+Arrow combinations

### Location of Bindings
File: `internal/definitions/bindings.lua`

**Added in these locations:**
1. Line ~29: `timeline_command` section
   ```lua
   ["<S-right>"] = "NextRegion",
   ["<S-left>"] = "PrevRegion",
   ```

2. Line ~58: `visual_timeline_command` section
   ```lua
   ["<S-right>"] = "NextRegion",
   ["<S-left>"] = "PrevRegion",
   ```

### Actions Definitions
File: `internal/definitions/actions.lua`

The actions ARE defined (lines 323-331, 426-431):
```lua
NextRegion = {
    "SetLoopRegionToNextRegion",
    "LoopStart",
    "SetTimeSelectionToLoopSelection",
    prefixRepetitionCount = true
},
PrevRegion = {
    "SetLoopRegionToPrevRegion",
    "LoopStart",
    "SetTimeSelectionToLoopSelection",
    prefixRepetitionCount = true
},
```

### What Changed in Merge
- Merged from gwatcha/reaper-keys main (2.0.0-a15)
- Major refactoring: `custom_actions` → `movements` module
- `bindings.lua` was auto-merged (no conflicts)
- These bindings were in our branch before merge and survived the merge

### ROOT CAUSE IDENTIFIED ✅
**Duplicate key bindings** - The same keys were bound in 4 different sections:
- `timeline_command` (line 29-30) - ❌ REMOVED
- `timeline_selector` (line 40-41) - ✅ KEPT
- `visual_timeline_command` (line 58-59) - ❌ REMOVED
- `command` (line 80-81) - ✅ KEPT

Having the same key bound in multiple overlapping contexts caused the "undefined key sequence" error.

### Fix Applied
Removed duplicate bindings from `timeline_command` and `visual_timeline_command` sections.
Now matches gwatcha's binding structure with only 2 instances in appropriate contexts.

### Testing Needed
1. Check if other Shift combinations work (e.g., `<S-a>`, `<S-b>`)
2. Check if plain arrow keys work
3. Check if the NextRegion/PrevRegion actions exist and work when called directly
4. Look at gwatcha's documentation for proper key notation syntax
5. Check if there are examples of Shift+Arrow keys in gwatcha's default bindings

### Files to Investigate
- `internal/definitions/bindings.lua` - Our binding definitions
- `internal/definitions/actions.lua` - Action definitions (NextRegion/PrevRegion)
- `internal/movements.lua` - The new movements module
- Any key parsing/binding registration code that might have changed

### Recovery
If needed, can revert to: `backup-before-merge-20251125` branch

## Next Steps
1. Check gwatcha's documentation for proper Shift+Arrow key syntax
2. Look at how other special keys are bound in the default bindings
3. Test if the actions work when bound to different keys
4. Check REAPER console/logs for more detailed error messages
