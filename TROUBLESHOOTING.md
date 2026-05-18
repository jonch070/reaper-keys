# Reaper-Keys Troubleshooting

## Performance Issues

### Severe Lag with hjkl Navigation (200-400x Slower)

**Symptoms:**
- Severe lag when pressing any keys in reaper-keys
- Navigation with hjkl is extremely slow (300-400ms delay per keystroke)
- Lag doesn't occur with native REAPER commands
- Happens with large REAPER configurations

**Root Cause:**
The `macro_recording` flag gets stuck as `true` in the reaper-keys state file. When this happens, reaper-keys continuously appends every command to a macro table in the background. This table grows to ~10kb+, and serializing it with `serpent.dump()` takes 340ms+ per keystroke.

**The Fix:**

1. **Close REAPER completely** (critical - otherwise changes will be overwritten)

2. **Locate the file:**
   ```
   /Users/jonathankawchuk/Library/Application Support/REAPER/reaper-extstate.ini
   ```

3. **Find the `[reaper_keys]` section** (around line 832)

4. **Make two changes:**
   - Delete the line starting with `macros=do` (this is the huge accumulated macro table)
   - In the line starting with `state=do`, change `macro_recording=true` to `macro_recording=false`

5. **Save the file**

6. **Open REAPER** - lag should be completely gone

**Why This Happens:**
- Macro recording accidentally gets enabled and stuck ON
- Every keystroke gets recorded into a growing macro table
- The table becomes massive, causing severe serialization lag
- This is not intentional - you're not actually trying to record a macro

**After the Fix:**
- Macro recording will work normally when you intentionally use it
- It just won't be stuck ON in the background
- Normal performance restored

**Reference:**
- GitHub Issue: https://github.com/gwatcha/reaper-keys/issues/92
- Developer fix by @myrrc

**Example Fix (using sed):**
```bash
# Backup first
cp reaper-extstate.ini reaper-extstate.ini.backup

# Delete macros line
sed -i '' '/^macros=/d' reaper-extstate.ini

# Fix macro_recording flag
sed -i '' 's/macro_recording=true/macro_recording=false/g' reaper-extstate.ini
```

---

## Other Known Issues

### Redo Function Broken

**Symptoms:**
- `u` (undo) works, but `<C-r>` (redo) does nothing or behaves incorrectly

**Root Cause:**
- Needs investigation — likely related to how redo state is tracked/managed

**Reference:**
- Actions involved: `Redo` (40030), `MoveRedo` (`_SWS_EDITCURREDO`)
- Files: `internal/definitions/actions.lua:516`, `internal/definitions/bindings.lua:84`

### Window Focus / Search Field Not Focused on Open

**Symptoms:**
- Opening certain windows via reaper-keys (e.g. `ShowMixer`, `ShowProjectBay`, `ShowTrackManager`) shows the window but it's not focused / the search/input field doesn't have cursor focus
- User must click in the window before typing

**Previously Fixed Windows (use these as reference):**
- **Action List** (`ShowAndFocusActionList`) — `internal/movements.lua:531`: Opens native window, then inside `reaper.defer()` finds the "Action" hwnd via `JS_Window_Find`, sets foreground + focus, and looks for a "Filter" child window to land cursor directly in the search field
- **Media Explorer** (`ShowAndFocusMediaExplorer`) — `internal/movements.lua:527`: Uses `ShowAndFocusWindow` helper with action ID 50124 and title "Media Explorer"
- **Preferences** (`ShowAndFocusPreferences`) — `internal/movements.lua:547`: Uses `ShowAndFocusWindow` helper with action ID 40016 and title "Preference"
- **Binding List** — `internal/gui/binding_list/controller.lua:184`: Sets `view.window.state.focusedElm = view.elements.query` before opening, then inside `reaper.defer()` finds the gfx window and calls `JS_Window_SetForeground` + `JS_Window_SetFocus`
- **MIDI Editor** (`OpenInMidiEditorAndFocus`) — `internal/definitions/actions.lua:867`: Chains `OpenInMidiEditor` (40153) + `FocusMidiEditor` (`_SN_FOCUS_MIDI_EDITOR`)

**Fix Pattern (two variants):**

*Native REAPER windows* — `internal/movements.lua:516` — `ShowAndFocusWindow`:
```lua
function actions.ShowAndFocusWindow(action_id, window_title)
    reaper.Main_OnCommand(action_id, 0)
    reaper.defer(function()
        local hwnd = reaper.JS_Window_Find(window_title, false)
        if hwnd then
            reaper.JS_Window_SetForeground(hwnd)
            reaper.JS_Window_SetFocus(hwnd)
        end
    end)
end
```
Key detail: `JS_Window_Find` must be **inside** the `reaper.defer()` so the window has time to be created.

*REAPER windows with a search/filter child field* (like Action List):
```lua
reaper.Main_OnCommand(action_id, 0)
reaper.defer(function()
    local hwnd = reaper.JS_Window_Find("Window Title", false)
    if hwnd then
        reaper.JS_Window_SetForeground(hwnd)
        local filter = reaper.JS_Window_FindChild(hwnd, "Filter", false)
        if filter then
            reaper.JS_Window_SetFocus(filter)  -- cursor in search field
        else
            reaper.JS_Window_SetFocus(hwnd)     -- fallback to window
        end
    end
end)
```

*Custom gfx windows* (like Binding List):
```lua
view.window.state.focusedElm = view.elements.query  -- set focus element
reaper.defer(function()
    local hwnd = reaper.JS_Window_Find("Window Title", false)
    if hwnd then
        reaper.JS_Window_SetForeground(hwnd)
        reaper.JS_Window_SetFocus(hwnd)
    end
end)
```

**Known Affected (not yet fixed):**
- `ShowMixer` (40078) — bound at `internal/definitions/bindings.lua:211`, defined at `internal/definitions/actions.lua:868`
- `ShowProjectBay` (41157) — bound at `internal/definitions/bindings.lua:197`, defined at `internal/definitions/actions.lua:873`
- `ShowTrackManager` (40906) — bound at `internal/definitions/bindings.lua:218`, defined at `internal/definitions/actions.lua:882`
