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
- **Non-contiguous track selection with register-based accumulators** - **PAUSED**
  - See `TRACK_ACCUMULATOR_WIP.md` for detailed progress
  - Issue: Conflicts with core track navigation (j/k breaks, visual mode breaks)
  - Storage/persistence mechanism works perfectly
  - Needs deeper integration with reaper-keys' mode system
  - Will revisit after understanding navigation architecture better

#### Screensets (Window Layouts)
- **Load and save screensets for different workspace layouts** - **✅ IMPLEMENTED**
  - Description: Save and recall window configurations (editing, mixing, MIDI layouts)
  - ✅ Screensets differ from snapshots: screensets save window layouts, snapshots save mix settings
  - ✅ Load screensets: `'1` through `'5` (single quote + number)
  - ✅ Save screensets: `'!` through `'%` (single quote + Shift+number)
  - Default REAPER bindings: F3-F5 load, Shift+F3-F5 save
  - Screensets 1-5 added (can expand to 10 if needed)

### 📋 TODO - Valid Feature Requests

#### 🔴 HIGH PRIORITY - Need Investigation/Implementation

**MIDI Editor Issues:**
1. **MIDI hjkl navigation broken?** - **🐛 INVESTIGATE**
   - User reports hjkl not working in MIDI editor
   - Should be: h/l = grid division, j/k = pitch up/down
   - Current bindings look correct (timeline_motion and command contexts)
   - TODO: Test and debug why not working

2. **Trim note edges to cursor** - See MIDI Note Length section below
   - Actions: 40790 (left), 40791 (right)
   - Suggested: `[` / `]` or `<M-[>` / `<M-]>`
   - User reports these don't work - need testing

3. **Select note at/near cursor** - See MIDI Note Selection section below
   - Actions: 40425 (nearest), 40426 (closest to cursor)
   - Suggested: `gn` / `gc` or `,` / `.`
   - Need to verify these actions work in MIDI editor

**All MIDI commands may need testing/debugging before adding bindings**

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

- **Trim note edges to edit cursor** - **🔴 PRIORITY: Rebind**
  - Description: Trim note edges to edit cursor position (like item edge editing)
  - ✅ Actions exist in actions.lua:
    - `TrimSelectedNoteLeftEdgeToEditCursor` (40790)
    - `TrimSelectedNoteRightEdgeToEditCursor` (40791)
  - ❌ Previous bindings (Shift+H/L) conflicted with measure navigation
  - **TODO: Choose and bind new keys**
  - Suggested options:
    - `[` / `]` (trim left/right edge to cursor)
    - `g<` / `g>` (go trim left/right)
    - `z[` / `z]` (in z prefix context)
    - `<M-[>` / `<M-]>` (Option+bracket)

#### MIDI Note Selection
- **Select note at/near cursor** - **🔴 PRIORITY: Rebind**
  - Description: Select notes near the cursor position
  - ✅ Actions exist in actions.lua:
    - `SelectNearestNote` (40425)
    - `SelectNoteClosestToEditCursor` (40426)
  - ❌ Previous bindings (vn/vc) conflicted with visual timeline mode (v key)
  - **TODO: Choose and bind new keys**
  - Suggested options:
    - `gn` / `gc` (go to nearest/closest note)
    - `<leader>sn` / `<leader>sc` (select nearest/closest)
    - `zn` / `zc` (in z prefix context)
    - Single keys like `,` / `.` if available

- **Select all notes at cursor vertical** - **✅ IMPLEMENTED**
  - Description: Select all notes at the same pitch
  - ✅ Action exists: `SelectAllNotesAtPitch` (41746)
  - ✅ Binding: `V` (shift+v in MIDI editor)

- **Add note to selection under vertical and horizontal cursor** - **✅ ALREADY BOUND**
  - ✅ Action exists: `AddNextNoteToSelection` (40422)
  - ✅ Action exists: `AddPrevNoteToSelection` (40421)
  - ✅ Binding: `n` (add next note to selection)
  - ✅ Binding: `N` (add previous note to selection)

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

- **Smart insert note with time selection support** - **TODO**
  - Current: `a` inserts default-size note at cursor
  - Wanted: When time selection exists, insert note spanning that selection
  - Challenge: FitNotes action doesn't reliably fit the just-inserted note
  - May need custom Lua implementation that directly sets note boundaries
  - Tabled for future investigation

- **Cut selected notes cuts all notes in the same vertical column**
  - **BUG**: Cuts entire chord instead of just selected note
  - Should only cut the specific selected note, not all notes at same pitch

#### Item Editing & Markers
- **Add/edit take marker at play position or edit cursor** - **✅ IMPLEMENTED**
  - Description: Quick take marker creation
  - ✅ Action exists: 42385
  - ✅ Binding: `<leader>ik` (Space+i+k)

- **Open item properties** - **✅ IMPLEMENTED**
  - Description: Quick access to item properties window
  - ✅ Action exists: 40009 (F2 default)
  - ✅ Binding: `<leader>oP` (Space+o+Shift+P)

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

- **Select inner item splits overlapping items - need alternative** - **🔴 HIGH PRIORITY BUG**
  - **BUG**: Current `iw` (select inner item) behavior splits/cuts overlapping items
  - Example: Two overlapping items → after `iw` on one → three items (split at overlap boundary)
  - Root cause: `innerItem` action creates time selection, then some subsequent action splits items
  - **Wanted**: Just select the item under cursor without splitting or creating time selection
  - **Possible solutions**:
    1. Use `SelectItemsUnderEditCursor` (_XENAKIOS_SELITEMSUNDEDCURSELTX) instead
    2. Create custom Lua function that only selects item without time selection
    3. Investigate what's triggering the split and prevent it
  - TODO: Test if SelectItemsUnderEditCursor works as replacement, or implement custom solution

#### Track Management
- **Toggle record disable (arm) for selected tracks**
  - Description: Toggle record arming on/off for selected tracks
  - ✅ EXISTS: `ArmSelectedTracks` (_XENAKIOS_SELTRAX_RECARMED)
  - TODO: Add binding and verify it toggles (not just enables)

- **Toggle track enable/disable for selected tracks**
  - Description: Enable/disable selected tracks (prevent playback)
  - TODO: Find REAPER action ID for track enable/disable toggle
  - Note: Different from mute - disabled tracks don't process at all

- **Non-contiguous track selection with 'x' key (add/remove toggle)** - **PAUSED**
  - Register-based implementation conflicts with core navigation
  - See TRACK_ACCUMULATOR_WIP.md for details
  - Will revisit with better approach
  - ✅ MousePosition moved from `x` to `gm` (go to mouse) - kept this improvement

- **Hide muted tracks and children**
  - Description: Visibility command to hide muted tracks and their folder children
  - Related action might exist, needs action ID

- **Show all tracks / Unhide all tracks**
  - Description: Unhide all hidden tracks in project
  - TODO: Find REAPER action for unhiding all tracks
  - Suggested binding: somewhere in `<leader>v` (view context)

- **Relative line numbers for tracks (like vim)**
  - Description: Show track numbers relative to current track (vim-style)
  - Similar to vim's `:set relativenumber`
  - Would help with count-based navigation (e.g., `5j` to jump 5 tracks down)
  - TODO: Research if possible with REAPER API or if needs custom extension

- **Shift jk for folder selection should ignore hidden tracks**
  - **BUG**: Currently navigates to hidden tracks within folders
  - Should skip over hidden tracks when using Shift+J/K

- **Move selected tracks up/down in track order** - **✅ SOLVED**
  - Description: Reorder selected tracks by moving them up or down in the track list
  - ✅ User implemented via normal REAPER action bindings
  - Can also be mapped to encoders using ReaLearn for hardware control
  - Note: Shift+J/K already used for folder navigation

#### Solo & Routing
- **Toggle exclusive solo for selected tracks** - **✅ IMPLEMENTED**
  - Description: Solo selected tracks and unsolo all others
  - ✅ Action exists: `_RS7e9734a021c2c867f4abb43fad29e2b59e3d6731` (me2beats script)
  - ✅ Binding: `<leader>te` (Space+t+e)

- **Auto solo tracks of selected items** - **✅ IMPLEMENTED**
  - Description: Automatically solo the tracks that contain selected items
  - ✅ Action exists: `_RS81ea80e7852f40fc296587c1620a8d8dbdfae9f1` (HeDa script)
  - ✅ Binding: `<leader>tE` (Space+t+Shift+E)

- **Toggle track routing**
  - **BUG**: Opens and instantly closes track routing window
  - Needs investigation - timing issue?

#### FX & Browser
- **Toggle show track FX chain** - **✅ IMPLEMENTED**
  - Description: Open/close track FX chain window
  - ✅ Action exists: `ToggleShowFxChain` (_S&M_TOGLFXCHAIN)
  - ✅ Binding: `<leader>fc` (Space+f+c)

- **Toggle show fx browser**
  - Description: Show/hide FX browser window
  - Check if action exists

- **Show and hide fx browser**
  - Same as above or different behavior?

- **Insert virtual instrument track does not focus fx search bar**
  - **BUG**: After inserting VI track, FX browser doesn't auto-focus for typing
  - Should focus search field automatically

#### Project & File Management
- **Open project from recent projects list (popup menu)** - **✅ IMPLEMENTED**
  - Description: Quick access to recent projects without paths cluttering view
  - ✅ Action exists: `_RS4b8f74ce98f11799503f300cfe1d4f0bd8582c9f` (Yannick script)
  - ✅ Binding: `<leader>pO` (Space+p+Shift+O)

- **Open selected item source media in explorer/finder** - **✅ IMPLEMENTED**
  - Description: Jump to item's source file location in file browser
  - ✅ Action exists: 42411
  - ✅ Binding: `<leader>oi` (Space+o+i)

- **Open project folder in explorer/finder** - **✅ IMPLEMENTED**
  - Description: Open current project's folder in file browser
  - ✅ Action exists: `_RSa031ec0ee4c818007d71473b8b5a2bb28497ec22` (X-Raym script)
  - ✅ Binding: `<leader>op` (Space+o+p)

#### UI & Workflow
- ~~**Disable "Your mother loves you" startup message**~~ - **IMPLEMENTED**
  - Set `show_start_up_message = false` in config.lua

- **I don't want esc to stop playback**
  - Current: ESC bound to Reset which stops playback
  - Wanted: ESC should only exit modes, not stop transport
  - TODO: Separate Reset from Stop action

- **Add open console** - **✅ IMPLEMENTED**
  - Description: Binding to open REAPER console
  - ✅ Action exists: `OpenConsole` (_SWSCONSOLE)
  - ✅ Binding: `<leader>vC` (Space+v+Shift+C)

- **Media explorer unfocused when brought up**
  - **BUG**: Media explorer opens but doesn't have focus
  - No good way to exit when it does have focus
  - Needs focus management fix

- **Window focus and management issues** - **TODO**
  - **BUG**: Many windows don't receive focus when opened by reaper-keys
  - Command+W doesn't close windows (expected macOS behavior)
  - Command+Tilde doesn't cycle through windows (expected macOS behavior)
  - General window management needs improvement
  - May require changes to how windows are opened/focused

- **MIDI note velocity controls** - **TODO**
  - Description: Keyboard shortcuts for adjusting note velocities
  - Actions likely exist for increase/decrease velocity
  - TODO: Find action IDs and add bindings
  - Possibly bind to +/- or similar in MIDI editor

- **Explore Antoine's time selection edit workflow** - **TODO**
  - Description: Research Antoine's approach to time selection editing
  - May have useful patterns for selection-based workflows
  - TODO: Document findings and potential integration

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
  - Related to above and to "Select inner item splits overlapping items" (Item Selection section)
  - `iw` (inner item) splits items at overlap boundaries, breaking crossfades
  - See Item Selection & Editing section for detailed analysis and solutions

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
