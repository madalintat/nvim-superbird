# Complete Installation Guide

This is the **definitive guide** to get your Neovim setup fully working from scratch.

## Prerequisites

- Neovim 0.9.0 or later
- Git
- A terminal
- Homebrew (macOS) or equivalent package manager

## Installation Steps

### Step 1: First Launch (Auto-Install Plugins)

```bash
cd ~/nvim-superbird
nvim
```

**What happens:**
1. Lazy.nvim bootstraps automatically
2. All plugins start downloading
3. You'll see a progress window
4. **Wait for everything to finish** (2-5 minutes)

**What you'll see:**
```
lazy.nvim
[====================================] 50/50
✓ nvim-treesitter
✓ telescope.nvim
✓ nvim-lspconfig
✓ coq_nvim
... (and all other plugins)
```

**Important:**
- Don't close Neovim until you see "Done!"
- COQ will automatically build (you'll see ":COQdeps" running)
- Wait for "COQ deps installed!" notification

### Step 2: First Restart

After all plugins install:

```vim
:qa!
```

Then immediately restart:

```bash
nvim
```

This ensures all plugins load correctly.

### Step 3: Install System Dependencies

Open a terminal and run:

```bash
# Essential tools
brew install gh glow jq

# Authenticate GitHub CLI
gh auth login
# Follow prompts: GitHub.com -> HTTPS -> Login with browser
```

**What each tool does:**
- `gh` - GitHub CLI (for Octo.nvim)
- `glow` - Markdown renderer (for Glow.nvim)
- `jq` - JSON processor (for nvim-jqx)

### Step 4: Build Sniprun

Sniprun needs a compiled binary:

```bash
cd ~/.local/share/nvim/lazy/sniprun
bash install.sh
```

**Expected output:**
```
Compiling sniprun...
Installation successful!
```

This takes 1-2 minutes. If it fails, you may need Rust:
```bash
curl --proto '=https' --tlsv1.2 -sSf https://sh.rustup.rs | sh
```

### Step 5: Verify Installation

Open Neovim:

```bash
nvim
```

Run these checks:

#### Check 1: Plugins Installed
```vim
:Lazy
```
**Expected:** All plugins show ✓ (green checkmark)

#### Check 2: COQ Running
```vim
:COQstatus
```
**Expected:** Shows COQ status

**Alternative:** Just start typing in insert mode - completions should appear!

#### Check 3: Mason & Language Servers
```vim
:Mason
```
**Expected:** Shows list of servers
**Should see installed:**
- ✓ ts_ls
- ✓ lua_ls
- ✓ pyright
- ✓ html
- ✓ cssls

If any are missing, press `i` to install them.

#### Check 4: Test Completion

Create a test file:
```vim
:e test.lua
```

Type in insert mode:
```lua
vim.
```

**Expected:** Completion popup appears automatically showing `vim.api`, `vim.fn`, etc.

#### Check 5: Test LSP

In the test.lua file:
```vim
:LspInfo
```

**Expected:** Shows "Client: lua_ls (id: 1) attached"

### Step 6: Test Key Features

Try these to verify everything works:

**1. Luxmotion (Navigation):**
```vim
# Press 's' in normal mode
# Labels should appear on words
```

**2. Terminal:**
```vim
# Press Space, then 'lt'
# Terminal should open at bottom
```

**3. Floating Terminal:**
```vim
# Press Space, then 'ft'
# Floating terminal appears
```

**4. Code Completion:**
```vim
# Open any file and start typing
# Completions appear automatically
```

**5. GitHub (if authenticated):**
```vim
# Press Space, then 'go'
# Octo menu appears
```

## Post-Installation: Optional Setup

### Install Debug Adapters

For debugging support:

```vim
:Mason
```

Install these:
- `debugpy` (Python debugging)
- `node-debug2-adapter` (JavaScript/TypeScript debugging)
- `codelldb` (Rust/C/C++ debugging)

### Set Up AI (Avante)

Add to `~/.zshrc` or `~/.bashrc`:

```bash
export ANTHROPIC_API_KEY="sk-ant-xxxxx"
```

Reload:
```bash
source ~/.zshrc
nvim
```

Test:
```vim
# Press Space, then 'aa'
# AI chat should appear
```

### Configure Python Environments

If using Python:

```bash
# Create virtual environments
python -m venv ~/.virtualenvs/project1
python -m venv ~/.virtualenvs/project2
```

In Neovim:
```vim
# Press Space, then 've'
# Select environment from picker
```

## Complete Verification

Run this complete test:

```vim
" 1. Check plugins
:Lazy

" 2. Check LSP servers
:Mason

" 3. Check COQ
:COQnow

" 4. Check for errors
:messages

" 5. Check LSP info
:LspInfo
```

All should work without errors!

## Common Issues & Solutions

### Issue: "mason-lspconfig not found"

**Solution:**
```bash
# Close Neovim
# Clear caches
rm -rf ~/.local/state/nvim
rm -rf ~/.cache/nvim

# Restart Neovim
nvim

# Let everything reinstall
# Wait for completion
# Restart again
```

### Issue: No Completions

**Solution:**
```vim
:COQnow --shut-up
```

If still not working:
```vim
:Lazy sync
:qa!
```
Then restart Neovim.

### Issue: LSP Not Attaching

**Solution:**
```vim
:LspRestart
```

Or:
```vim
:Mason
# Press 'i' on missing servers
# Wait for installation
:LspRestart
```

### Issue: Plugin Shows 'X' in Lazy

**Solution:**
```vim
:Lazy sync
```

Wait for completion, then:
```vim
:qa!
```
Restart Neovim.

### Issue: Sniprun Not Working

**Solution:**
```bash
cd ~/.local/share/nvim/lazy/sniprun
bash install.sh
```

If Rust is missing:
```bash
curl --proto '=https' --tlsv1.2 -sSf https://sh.rustup.rs | sh
source ~/.cargo/env
cd ~/.local/share/nvim/lazy/sniprun
bash install.sh
```

## Success Indicators

You'll know everything is working when:

1. ✅ All plugins show ✓ in `:Lazy`
2. ✅ Completions appear as you type
3. ✅ `gd` jumps to definitions
4. ✅ `K` shows documentation
5. ✅ `<leader>lt` opens terminal
6. ✅ `s` shows navigation labels
7. ✅ No errors in `:messages`
8. ✅ `:LspInfo` shows attached servers

## Getting Help

If something doesn't work:

1. Check `:messages` for errors
2. Check `:Lazy` - all should be ✓
3. Check `:Mason` - servers installed
4. Check `:LspInfo` - servers attached
5. Read `QUICK_START.md` for troubleshooting
6. Read `docs/README.md` for plugin details

## Next Steps

Once everything is working:

1. Read `docs/KEYBINDINGS_REFERENCE.md` for all shortcuts
2. Read `SWITCHED_TO_COQ.md` to understand COQ
3. Browse `docs/` folder for individual plugin guides
4. Customize configs in `lua/cetusian/plugins/`

**Enjoy your supercharged Neovim setup!** 🚀
