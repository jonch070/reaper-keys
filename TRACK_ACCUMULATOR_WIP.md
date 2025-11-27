# Track Accumulator - Work In Progress

## Goal
Implement vim-style register-based track selection accumulator to build multi-track selections that persist across navigation.

## Desired Workflow
```
1. Navigate to track A, press xa → adds to register 'a'
2. Navigate to track B with j/k (track A stays selected)
3. Press xa → adds track B (both A and B selected)
4. Navigate to track C, press xb → adds to register 'b'
5. Press Xa → recall only tracks from register 'a'
6. Press Xb → recall only tracks from register 'b'
7. Press gXa → clear register 'a'
```

## What We Implemented
- ✅ Register-based storage using REAPER project extended state
- ✅ `toggleAccumulatorRegister(register)` - add/remove track from register
- ✅ `recallAccumulatorRegister(register)` - select only tracks from register
- ✅ `clearAccumulatorRegister(register)` - clear specific register
- ✅ `restoreAllAccumulators()` - restore all accumulated tracks after navigation
- ✅ Persistence across script reloads via GetProjExtState/SetProjExtState

## Core Issue Discovered
**REAPER's native track navigation (actions 40285/40286) clears all selections.**

Even with deferred restore, the selection gets cleared by something in the action chain.

## Solutions Attempted

### Attempt 1: Defer restoreAllAccumulators
- Added `reaper.defer()` to run restore after navigation
- **Failed**: Still cleared by subsequent actions

### Attempt 2: Custom track navigation functions
- Created `nextTrackPreservingAccumulators()` and `prevTrackPreservingAccumulators()`
- Manually select next/prev track, then restore accumulators
- **Partial success**: Accumulator persistence worked
- **New issues**:
  - Navigation gets stuck at track 2 (can't navigate further)
  - Breaks Shift+V (visual track mode)
  - Track selection becomes unreliable

## Root Cause Analysis
The fundamental conflict:
- **reaper-keys' track navigation**: Expects REAPER's native actions (40285/40286)
- **Track accumulators**: Need to preserve multi-track selections during navigation
- **REAPER's behavior**: Native navigation always clears to single track

These are incompatible without major refactoring of reaper-keys' navigation system.

## Alternative Approaches to Consider

### Option A: Don't restore during navigation
- Navigation clears selection (normal behavior)
- Accumulated tracks are "remembered" but not visible
- `Xa` recalls them when needed
- **Pro**: Doesn't break navigation
- **Con**: Less intuitive, can't see accumulated tracks while navigating

### Option B: Visual mode for multi-track selection
- Use existing `V` (visual track mode) for multi-track selection
- Build selection with Shift+J/K in visual mode
- Mark entire selection with `ma`
- Recall with `'a`
- **Pro**: Uses existing functionality
- **Con**: Doesn't solve the "build across navigation" problem

### Option C: Different navigation keys
- Keep j/k as normal (clears selection)
- Add new keys (e.g., `J`/`K` or `<M-j>`/`<M-k>`) that preserve selection
- **Pro**: User chooses when to preserve vs clear
- **Con**: Two navigation modes to remember

### Option D: Accept limitations, use marks
- Use existing marks system (`ma` to mark, `'a` to recall)
- Build selections manually in visual mode
- **Pro**: No new code, stable
- **Con**: Multi-step workflow

## Files Modified
- `internal/movements.lua` - accumulator functions, custom navigation
- `internal/definitions/actions.lua` - register-based actions, navigation replacement
- `internal/definitions/bindings.lua` - x/X/gX bindings

## Recommendation
**Table this feature for now.** The integration with reaper-keys' navigation is more complex than anticipated. Needs deeper understanding of:
- reaper-keys' mode system
- Track selection state management
- How other features interact with navigation

## Lessons Learned
1. Register-based storage with project extended state works well
2. Persistence mechanism is solid
3. The issue is integration with existing navigation, not the accumulator logic itself
4. Core functionality should not be broken by new features

## Status
**PAUSED** - Reverting to stable state, will revisit after more research.
