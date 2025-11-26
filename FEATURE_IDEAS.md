# Reaper Keys - Feature Ideas & Bug Tracker

## Features & Improvements

### ✅ Already Implemented

#### MIDI Note Movement
- ~~Move notes is broken~~ - **FIXED**: Removed conflicting global bindings
- ~~Move note right and move note left do not work~~ - **FIXED**: Option+H/L now works

#### Region Navigation
- ~~All next region commands don't work~~ - **FIXED**: Nested bracket syntax + cursor-only mode
  - Normal mode: Cursor movement only (no time selection)
  - Visual mode: Cursor + time selection

#### Track Selection
- ~~Non-contiguous track selection with 'x' key~~ - **IMPLEMENTED**
  - Custom Lua function toggles track in/out of selection
  - Vim-style workflow (like Linear/taskwarrior-tui)
  - `x` = toggle track selection, `gm` = go to mouse position

### 📋 TODO - Valid Feature Requests

#### Grid & Snap Workflow
- **Number keys (12345) for quick grid size selection**
  - Description: Map number keys to specific grid sizes for instant switching
  - Alternative: Shortcuts to move up/down grid sizes relatively (like next/prev)
  - Current: Must type grid size or use multiply by 2x/0.5x
  - Wanted: One-key press to switch to common grid sizes (1/4, 1/8, 1/16, etc.)

- **Adaptive numbered grid (zoom-aware)**
  - Description: Number keys correspond to different grid sizes based on zoom level
  - Example: At bar-level zoom, "1" = whole note; at beat zoom, "1" = 1/4 note
  - Adaptive to context/zoom for more intelligent workflow
  - May be complex - keep as idea for future exploration

#### MIDI Note Length
- **Decrease/Increase note length left and right by grid division**
  - Status: REAPER actions exist but not in reaper-keys
  - Actions needed: "Edit: Lengthen notes one grid unit" & "Edit: Shorten notes one grid unit"
  - TODO: Find action IDs and add to actions.lua

- **Note length left or right to cursor**
  - ✅ PARTIALLY EXISTS:
    - `TrimSelectedNoteLeftEdgeToEditCursor` (40790)
    - `TrimSelectedNoteRightEdgeToEditCursor` (40791)
  - TODO: Add bindings for these actions

- **Shift+H/L to grow note edges (like Alex Ruger/rewgs' setup)**
  - Description: Extend/shrink note boundaries like item edge editing
  - Shift+H: Grow/shrink left edge of note
  - Shift+L: Grow/shrink right edge of note
  - Similar to item edge trimming but for MIDI notes
  - Related to note length adjustment above

#### MIDI Note Selection
- **Select note under cursor (vertical and horizontal)**
  - ✅ EXISTS: `SelectNearestNote` (40425) and `SelectNoteClosestToEditCursor` (40426)
  - TODO: Add bindings

- **Select all notes at cursor vertical**
  - ✅ EXISTS: `SelectAllNotesAtPitch` (41746)
  - TODO: Add bindings

- **Add note to selection under vertical and horizontal cursor**
  - ✅ EXISTS: `AddNextNoteToSelection` (40422), `AddPrevNoteToSelection` (40421)
  - 🔄 NEEDS CLARIFICATION: Do you want to add note at cursor position specifically?

- **Move note to edit cursor**
  - 🔄 NEEDS CLARIFICATION: Move selected note's start to cursor? Or both edges?

#### Item Playback Rate (Pitch)
- **Better workflow for item rate (playback speed/pitch) adjustment**
  - Actions needed:
    - Decrease/increase rate by semitone (preserve pitch OFF)
    - Decrease/increase rate by octave (preserve pitch OFF)
    - Clear preserve pitch setting
  - Currently used frequently but workflow is clunky
  - Need dedicated key bindings for quick pitch/speed adjustment
  - Note: This is for ITEMS, not MIDI notes

#### MIDI Editing Workflow
- **General MIDI workflow improvements (ongoing)**
  - Includes adding better capabilities like:
    - Jesse (MIDI tool - needs research)
    - Chord gun integration
    - MIDI transformer workflows
  - Long-term exploration of MIDI tooling ecosystem
  - Keep as placeholder for future MIDI enhancements

- **Cut selected notes cuts all notes in the same vertical column**
  - **BUG**: Cuts entire chord instead of just selected note
  - Should only cut the specific selected note, not all notes at same pitch

#### Item Selection & Editing
- **Non-contiguous selection - items and midi notes under cursor with "add to selection"**
  - Description: Like Superhuman/Linear's 'x' key - add/remove from selection toggle
  - Similar to Command+Click but keyboard-driven

- **Select items and split - change to just select items under cursor**
  - Current: `SelectItemsAndSplit` does both selection + splitting
  - Wanted: Just select items at cursor without splitting
  - ✅ EXISTS: `SelectItemsUnderEditCursor` already exists, just needs different binding

- **Make sure that I can hold shift or something to inclusively select items up and down**
  - Description: Range selection with Shift modifier (like Shift+Click in GUI)
  - Select from current item to target item

- **Select inner item don't break overlapping items - change to custom instead**
  - **BUG**: Current `SelectInnerItem` behavior breaks crossfades on overlapping items
  - TODO: Create custom action that preserves overlapping item integrity

#### Track Management
- **Toggle record disable (arm) for selected tracks**
  - Description: Toggle record arming on/off for selected tracks
  - ✅ EXISTS: `ArmSelectedTracks` (_XENAKIOS_SELTRAX_RECARMED)
  - TODO: Add binding and verify it toggles (not just enables)

- **Toggle track enable/disable for selected tracks**
  - Description: Enable/disable selected tracks (prevent playback)
  - TODO: Find REAPER action ID for track enable/disable toggle
  - Note: Different from mute - disabled tracks don't process at all

- ~~**Non-contiguous track selection with 'x' key (add/remove toggle)**~~ - **IMPLEMENTED**
  - Description: Like Superhuman/Linear's 'x' - add current track to selection or remove if already selected
  - Similar to Command+Click but keyboard-driven
  - Allows building selection of non-adjacent tracks
  - ✅ Custom Lua function: `toggleCurrentTrackSelection` in movements.lua
  - ✅ Bound to `x` in main.command context
  - ✅ Moved MousePosition from `x` to `gm` (go to mouse)

- **Hide muted tracks and children**
  - Description: Visibility command to hide muted tracks and their folder children
  - Related action might exist, needs action ID

- **Show all tracks**
  - 🔄 CHECK: Might already exist as unhide all tracks action

- **Shift jk for folder selection should ignore hidden tracks**
  - **BUG**: Currently navigates to hidden tracks within folders
  - Should skip over hidden tracks when using Shift+J/K

#### Solo & Routing
- **Toggle exclusive solo**
  - Description: Solo track and unsolo all others (standard exclusive solo)
  - Check if REAPER action exists

- **Toggle track routing**
  - **BUG**: Opens and instantly closes track routing window
  - Needs investigation - timing issue?

#### FX & Browser
- **Toggle show fx browser**
  - Description: Show/hide FX browser window
  - Check if action exists

- **Show and hide fx browser**
  - Same as above or different behavior?

- **Insert virtual instrument track does not focus fx search bar**
  - **BUG**: After inserting VI track, FX browser doesn't auto-focus for typing
  - Should focus search field automatically

#### UI & Workflow
- **Disable "Your mother loves you" startup message**
  - Description: The welcome popup that appears when reaper-keys initializes
  - Shows: "Hello from inside Reaper Keys!" message with instructions
  - Location: Set option in `internal/definitions/config.lua`
  - TODO: Find config option to disable or make it show only once

- **I don't want esc to stop playback**
  - Current: ESC bound to Reset which stops playback
  - Wanted: ESC should only exit modes, not stop transport
  - TODO: Separate Reset from Stop action

- **Add open console**
  - Description: Binding to open REAPER console
  - ✅ Action exists: `OpenConsole = "_SWSCONSOLE"` but might not be bound

- **Media explorer unfocused when brought up**
  - **BUG**: Media explorer opens but doesn't have focus
  - No good way to exit when it does have focus
  - Needs focus management fix

#### Item Grouping
- **Toggle item grouping**
  - Description: Quick toggle for grouping selected items
  - Check if REAPER action exists

#### Navigation
- **"``" to return to prev position**
  - Description: Backtick backtick (double backtick) to jump to previous cursor position
  - Like Vim's `` motion
  - Might need to track cursor position history

#### Razor Editing
- **Razor editing and hover editing support**
  - Description: Support for REAPER's razor edit mode
  - Hover editing (mouse-free razor edit workflow)
  - Large feature - needs research on REAPER's razor edit actions

---

## 🐛 Bug Reports

### High Priority

#### ❌ FIXED
- ~~Move note right/left don't work~~ - Fixed by removing conflicting bindings
- ~~Next region commands don't work~~ - Fixed with nested bracket syntax
- ~~Lag for hjkl~~ - Likely fixed with binding optimizations

#### Selection & Splitting
- **SelectItemsAndSplit behavior**
  - Current: Selects items crossing time/track selection AND splits them
  - Issue: Too aggressive, should have separate select-only option

- **Select inner all track items takes twice to work**
  - **BUG**: Action requires two executions to work properly
  - Should work on first execution

#### Crossfade Issues
- **Handling of crossfades during select and split commands broken**
  - **BUG**: Selection and split operations break item crossfades
  - Crossfades should be preserved or recreated after operations

- **Breaking of crossfades sometimes when selecting inner item**
  - Related to above - `SelectInnerItem` breaks crossfades on overlapping items

#### Track Operations
- **Copy/paste tracks does not preserve sends**
  - **BUG**: When copying tracks, send routing is not copied
  - Should preserve all routing including sends

- **Copy track does not copy sends**
  - Same as above

#### MIDI Editing
- **Insert or extend not working**
  - **BUG**: `InsertOrExtendMidiItem` action not functioning
  - Needs investigation

- **MIDI delete selected actually deletes all midi items above and below**
  - **BUG**: Deletes more than selected MIDI items
  - Should only delete selected items

- **Cut selected notes cuts all notes in same vertical column**
  - **BUG**: Cuts entire chord instead of individual note
  - Should respect individual note selection

#### Playback & Solo
- **All "play from x and solo track" do not work**
  - **BUG**: Actions like `PlayFromMouseAndSoloTrack` instantly toggle on/off
  - Solo doesn't stick, goes off immediately

#### Item Deletion
- **Delete selected items ignores items if they are too short**
  - **BUG**: Very short items don't get deleted when selected
  - Possible length threshold issue

#### Navigation Edge Cases
- **Problem selection or acting on prev item with 'b' when edit cursor up against left edge of next item**
  - **BUG**: Edge case with cursor positioning affecting item selection
  - 'b' motion behaves incorrectly at item boundaries

#### Time Selection
- **Deleting not working for TimeSelectionShiftedRight/Left**
  - Commands listed but marked as not working:
    - `["<CS-right>"] = "TimeSelectionShiftedRight"`
    - `["<CS-left>"] = "TimeSelectionShiftedLeft"`
  - Need to test if these are bound correctly with nested brackets

#### Project Initialization
- **When project opens defaults to "rename selected track"**
  - **BUG**: New projects immediately enter rename mode
  - Should start in normal mode

#### UI Window Issues
- **Toggle track routing opens and instantly closes**
  - **BUG**: Track routing window flashes open and closes
  - Timing or focus issue

- **Media explorer unfocused when brought up**
  - Already listed above in features

---

## ✅ Clarifications Received

All items clarified - see updated descriptions above:
1. **Number keys for grid** - Quick grid size switching with 1-5 keys
2. **Adaptive numbered grid** - Zoom-aware grid size mapping (future idea)
3. **rewgs/Alex Ruger** - Collaborator's MIDI note edge growing workflow
4. **Item rate adjustment** - Playback speed/pitch by semitone/octave
5. **Startup popup** - "Your mother loves you" welcome message
6. **MIDI workflow** - Long-term improvements (Jesse, Chord gun, etc.)

---

## Notes

### Mac Modifier Reference (Confirmed)
- `<C-...>` = Command key (not Control!)
- `<M-...>` = Option key (Meta/Alt)
- `<S-...>` = Shift key

### Testing Checklist
When adding new features, test:
- [ ] Main window context
- [ ] MIDI editor context
- [ ] Different modes (normal, visual, operator)
- [ ] Conflicts with existing global bindings
- [ ] Mac vs Windows modifier key behavior
