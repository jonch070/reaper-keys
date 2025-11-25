# Potential Features for reaper-keys

## Region Navigation Behavior
**Current:** NextRegion/PrevRegion create time selection in ALL modes (normal, visual, selector)
**Proposed:** Different behavior based on mode:
- **Normal mode**: Move cursor only, no time selection
- **Visual mode**: Move cursor AND create time selection (current behavior)
- **Selector mode**: Create time selection (current behavior)

**Implementation approach:**
1. Create `NextRegionCursorOnly` and `PrevRegionCursorOnly` actions:
   ```lua
   NextRegionCursorOnly = {
       "SetLoopRegionToNextRegion",
       "LoopStart",
       -- Omit SetTimeSelectionToLoopSelection
       prefixRepetitionCount = true
   },
   ```

2. Update bindings to use different actions based on context:
   - `command` context: Use `NextRegionCursorOnly`
   - `visual_timeline_command`: Use `NextRegion` (with selection)
   - `timeline_selector`: Use `NextRegion` (with selection)

**Benefits:**
- More Vim-like behavior: motions in normal mode don't create selections
- Cleaner navigation when you just want to move around
- Still get selection behavior when you need it (visual mode)

**Considerations:**
- Changes expected behavior from current implementation
- Need to decide if this should apply to other region-related motions
- May want user preference/config option

---

## Future Ideas
(Add more potential features here as they come up)
