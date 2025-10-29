# Fix All Errors - Do This Now!

You're seeing these errors:
1. ❌ `tsserver is not a valid entry`
2. ❌ `Not an editor command: COQnow`
3. ❌ `Not an editor command: LspInfo`

## The Problem

Neovim is using **cached old data**. The config files are correct, but Neovim cached the old "tsserver" value.

## The Solution - Complete Clean Install

### Method 1: Use the Clean Install Script (Recommended)

```bash
# Close Neovim first!
cd ~/nvim-superbird
./CLEAN_INSTALL.sh
```

This will:
- Remove all caches
- Remove old plugin data
- Give you a fresh start

Then:
```bash
nvim
```

Wait for everything to install (2-5 minutes), then restart.

### Method 2: Manual Clean (If script doesn't work)

```bash
# 1. Close ALL Neovim instances
# Make sure no nvim is running!

# 2. Remove everything
rm -rf ~/.local/share/nvim/lazy
rm -rf ~/.local/state/nvim
rm -rf ~/.cache/nvim
rm -rf ~/.local/share/nvim/mason

# 3. Start Neovim
nvim

# 4. Wait for plugins to install
# You'll see a Lazy window installing everything
# Wait until you see "Done!" or all show green checkmarks

# 5. Close Neovim
:qa!

# 6. Restart Neovim
nvim

# 7. Check everything works
:Lazy        # All should be ✓
:Mason       # Should show ts_ls, lua_ls, pyright
```

## Why This Happens

When you first ran Neovim, it had "tsserver" in the config. Even though we changed it to "ts_ls", Neovim cached the old value in:
- `~/.local/state/nvim/lazy/`
- `~/.local/state/nvim/`
- `~/.cache/nvim/`

Removing these forces a fresh install with the correct values.

## What to Expect After Clean Install

### First Launch (after clean)

```
nvim
```

You'll see:
```
lazy.nvim
Installing plugins...
[====================================] 50/50
✓ nvim-lspconfig
✓ mason.nvim
✓ coq_nvim
...
```

Wait for "Done!" message.

### COQ Auto-Build

COQ will automatically run `:COQdeps` - you'll see:
```
COQ deps installing...
```

Wait for:
```
COQ deps installed!
```

### Close and Restart

```vim
:qa!
```

Then:
```bash
nvim
```

### Verification

Open a Lua file:
```bash
nvim test.lua
```

Type in insert mode:
```lua
vim.
```

You should see:
- ✅ Completion popup appears automatically
- ✅ Shows `vim.api`, `vim.fn`, `vim.lsp`, etc.

## Common Issues After Clean Install

### "Still seeing tsserver error"

**Solution:** You didn't close all Neovim instances before cleaning.

```bash
# Kill all nvim processes
pkill nvim

# Then clean again
rm -rf ~/.local/share/nvim/lazy ~/.local/state/nvim ~/.cache/nvim

# Start fresh
nvim
```

### "COQ not working"

**Solution:** Wait for COQ to finish building.

Look for this notification after plugins install:
```
COQ deps installed!
```

If you don't see it:
```vim
:COQnow --shut-up
```

### "No completions appearing"

**Solutions:**
1. Make sure you're in INSERT mode (`i`)
2. Type at least one character
3. Wait 1 second for popup
4. Check COQ is running: `:COQstatus`

If still not working:
```vim
:COQnow --shut-up
```

### "LspInfo not found"

**Solution:** LSP isn't loaded yet.

1. Open a code file (`.lua`, `.js`, `.py`)
2. Wait 2 seconds
3. Try `:LspInfo` again

Or restart Neovim:
```vim
:qa!
```
Then open nvim again.

## Step-by-Step Checklist

Use this checklist to ensure everything works:

- [ ] 1. Close all Neovim instances
- [ ] 2. Run clean script or manually remove caches
- [ ] 3. Open Neovim: `nvim`
- [ ] 4. Wait for all plugins to install (see "Done!")
- [ ] 5. Wait for "COQ deps installed!" message
- [ ] 6. Close Neovim: `:qa!`
- [ ] 7. Restart Neovim: `nvim`
- [ ] 8. Check plugins: `:Lazy` (all should be ✓)
- [ ] 9. Open test file: `nvim test.lua`
- [ ] 10. Type in insert mode - see completions!

## Quick Commands Reference

**After clean install, these should work:**

```vim
:Lazy           " Shows all plugins (should all be ✓)
:Mason          " Shows language servers
:COQstatus      " Shows COQ status
:LspInfo        " Shows attached LSP servers (in a code file)
:messages       " Shows any error messages
```

## Still Having Issues?

If errors persist after clean install:

1. **Check Neovim version:**
   ```bash
   nvim --version
   ```
   Should be 0.9.0 or newer

2. **Check the config files are correct:**
   ```bash
   grep -r "tsserver" ~/nvim-superbird/lua/
   ```
   Should only show comments, not actual config values

3. **Check for running Neovim processes:**
   ```bash
   ps aux | grep nvim
   ```
   Kill any that are running before cleaning

4. **Try a complete reinstall:**
   ```bash
   # Backup if needed
   mv ~/.config/nvim ~/.config/nvim.backup

   # Copy fresh config
   cp -r ~/nvim-superbird ~/.config/nvim

   # Clean start
   ./CLEAN_INSTALL.sh
   nvim
   ```

## Success Indicators

You'll know it's working when:

1. ✅ No error messages on startup
2. ✅ `:Lazy` shows all plugins with ✓
3. ✅ `:Mason` shows `ts_ls` (not tsserver)
4. ✅ Typing shows completions automatically
5. ✅ `gd` jumps to definitions in code files
6. ✅ `K` shows documentation

**If you see all of these, you're done! 🎉**
