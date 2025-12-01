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

(Add additional troubleshooting sections here as they arise)
