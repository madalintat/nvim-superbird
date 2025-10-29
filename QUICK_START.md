# Quick Start Guide - Complete Setup

## Fresh Installation Steps

Follow these steps in order to get everything working:

### Step 1: Initial Plugin Installation

1. **Open Neovim for the first time:**
   ```bash
   nvim
   ```

2. **Lazy.nvim will start automatically** and begin installing plugins
   - You'll see a window showing download progress
   - Wait for all plugins to finish installing (this may take 2-5 minutes)
   - Don't close Neovim yet!

3. **Wait for COQ to build:**
   - COQ will automatically run `:COQdeps`
   - You'll see "COQ deps installing..." notification
   - Wait for "COQ deps installed!" message

4. **Close Neovim completely:**
   ```vim
   :qa!
   ```

### Step 2: Install External Tools

Some plugins need external tools installed on your system:

```bash
# GitHub integration (for Octo plugin)
brew install gh
gh auth login  # Follow the prompts to authenticate

# Markdown preview (for Glow plugin)
brew install glow

# JSON querying (for JQX plugin)
brew install jq
```

### Step 3: Install Sniprun Compiler

Sniprun needs to compile its binary:

```bash
# After plugins are installed via Lazy
cd ~/.local/share/nvim/lazy/sniprun
bash install.sh
```

This may take 1-2 minutes. Wait for "Installation successful" message.

### Step 4: Final Restart and Verify

1. **Open Neovim again:**
   ```bash
   nvim
   ```

2. **Check plugin status:**
   ```vim
   :Lazy
   ```
   All plugins should show a green checkmark ✓

3. **Check COQ is running:**
   ```vim
   :COQstatus
   ```
   Should show COQ status (not an error)

   Or simply start typing in insert mode - completions should appear automatically!

4. **Open a test file to verify LSP:**
   ```bash
   # In terminal
   nvim test.lua
   ```

   In Neovim, type some Lua code - you should see completions!

### Step 5: Install Language Servers (Optional but Recommended)

For full LSP support, ensure language servers are installed:

```vim
:Mason
```

In the Mason window:
- Press `i` to install a server
- Recommended servers (should auto-install):
  - `ts_ls` (TypeScript/JavaScript)
  - `lua_ls` (Lua)
  - `pyright` (Python)
  - `html`, `cssls`, `tailwindcss` (Web development)

Press `q` to close Mason.

## Optional Setup

### 1. Configure Debugging (DAP)

For debugging support, install language-specific adapters:

```vim
:Mason
```

Press `i` to install:
- `node-debug2-adapter` (Node.js/JavaScript)
- `debugpy` (Python)
- `delve` (Go)
- `codelldb` (Rust/C/C++)

### 2. Set Up Avante AI

To use AI features, set your Anthropic API key:

```bash
# Add to ~/.zshrc or ~/.bashrc
export ANTHROPIC_API_KEY="your-api-key-here"
```

Then reload your shell:
```bash
source ~/.zshrc
```

### 3. Configure Python Virtual Environments

If you use Python, set up swenv:

```bash
# Create a virtual environment
python -m venv ~/.virtualenvs/myproject

# In Neovim, switch to it
# Press: <leader>ve
```

## Completion Engine: COQ

Your config uses **COQ** (not nvim-cmp) for autocompletion.

### COQ Keybindings

| Key | Description |
|-----|-------------|
| `<C-Space>` | Trigger completion manually |
| `<Tab>` | Next completion item |
| `<S-Tab>` | Previous completion item |
| `<CR>` | Accept completion |

Completions appear **automatically** as you type!

## Quick Reference

### Essential Keybindings

| Category | Key | Action |
|----------|-----|--------|
| **Escape Insert** | `jk` | Exit insert mode |
| **Navigation** | `s` | Jump forward (Luxmotion) |
| **Navigation** | `S` | Jump backward (Luxmotion) |
| **Terminal** | `<leader>lt` | Toggle terminal |
| **Terminal** | `<leader>ft` | Floating terminal |
| **GitHub** | `<leader>go` | Octo menu |
| **Debug** | `<leader>db` | Toggle breakpoint |
| **Debug** | `<leader>dc` | Start/continue debugging |
| **Run Code** | `<leader>rs` | Run code snippet |
| **Jest** | `<leader>jr` | Run nearest test |
| **AI** | `<leader>aa` | Ask AI |
| **Markdown** | `<leader>mp` | Preview markdown |
| **LSP** | `gd` | Go to definition |
| **LSP** | `K` | Show documentation |
| **LSP** | `<leader>ca` | Code actions |

## Verification Checklist

After setup, verify everything works:

### 1. Check Plugins
```vim
:Lazy
```
✅ All should have green checkmarks

### 2. Check LSP
```vim
# Open a file
nvim test.lua

# In Neovim
:LspInfo
```
✅ Should show `lua_ls` attached

### 3. Check COQ Completion
```vim
# In any file, start typing
# Completions should appear automatically
```
✅ You should see completion popup

### 4. Check Mason
```vim
:Mason
```
✅ Should show installed servers (ts_ls, lua_ls, etc.)

### 5. Test a Plugin
```vim
# Press 's' in normal mode
```
✅ Luxmotion labels should appear

## Troubleshooting

### "mason-lspconfig not found" or setup_handlers error

**Solution:**
```vim
:qa!  # Quit Neovim completely
```

Then:
```bash
# Clear cache
rm -rf ~/.local/state/nvim
rm -rf ~/.cache/nvim

# Restart Neovim
nvim
```

Wait for plugins to reinstall, then restart again.

### Completions Not Appearing

**Check COQ status:**
```vim
:COQstatus
```

**If COQ not running, start it manually:**
```vim
:COQnow --shut-up
```

**Or just test by typing:**
- Open any file in insert mode
- Start typing - completions should appear automatically!

### Plugin Not Working

1. **Check installation:** `:Lazy`
2. **Sync plugins:** `:Lazy sync`
3. **Restart Neovim:** `:qa!` then `nvim`
4. **Check errors:** `:messages`

### Language Server Not Working

1. **Check Mason:** `:Mason`
2. **Install missing server:** Press `i` in Mason
3. **Restart LSP:** `<leader>rs`
4. **Check status:** `:LspInfo`

### External Tool Missing

If a plugin fails, you might be missing tools:

```bash
# Check what's installed
which gh    # Should show path
which glow  # Should show path
which jq    # Should show path
```

If missing, install with:
```bash
brew install gh glow jq
```

## Next Steps

1. Read `docs/README.md` for full documentation
2. Browse individual plugin docs in `docs/`
3. Experiment with keybindings
4. Customize configs in `lua/cetusian/plugins/`

Enjoy your supercharged Neovim setup!
