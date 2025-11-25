# Merge Context - 2025-01-25

## Objective
Merge upstream changes from gwatcha/reaper-keys while preserving local modifications.

## Current State

### Branch Information
- **Current Branch**: jon-bindings
- **Your Fork**: https://github.com/jonch070/reaper-keys.git
- **Existing Upstream**: https://github.com/rewgs/reaper-keys.git
- **Target Upstream**: https://github.com/gwatcha/reaper-keys (original repo)

### Safety Checkpoint
- **Backup Branch Created**: backup-before-merge-20251125
- **Last Commit Before Merge**: a5fc84a (update 2025-01-21)

### Your Custom Changes (commits ahead of upstream/master)
1. a5fc84a - update 2025-01-21
2. d6ae051 - add option for snap marker
3. ed2c7bb - add hide tracks no items options
4. 913aed5 - change SplitItemsAtEditCursor to default reaper
5. 8ba826d - change state.lua to perken
6. e1952a8 - insert marker
7. 61402ef - update bindings
8. aa5afb0 - add video window binding

### Uncommitted Changes
- internal/definitions/bindings.lua: Added Shift+Left/Right for region navigation

## Recovery Instructions
If anything goes wrong, you can return to this exact state with:
```bash
git checkout backup-before-merge-20251125
# or if you want to reset jon-bindings to this state:
git reset --hard backup-before-merge-20251125
```

## Next Steps
1. Commit uncommitted changes
2. Add gwatcha/reaper-keys as the proper upstream remote
3. Fetch latest changes from gwatcha/reaper-keys
4. Merge or rebase upstream changes onto your branch
5. Resolve any conflicts if they arise
6. Test the merged code
