# Neovim Superbird 🚀

A supercharged Neovim configuration with AI, debugging, testing, and productivity tools.

## 🎯 Start Here

### 🚨 NOTHING WORKS? Start with this:
**[START_HERE.md](START_HERE.md)** ← **FIX EVERYTHING IN 5 MINUTES**

### 📚 Then read these in order:

1. **[START_HERE.md](START_HERE.md)** ← **READ THIS FIRST!** Get everything working
2. **[FIRST_THINGS_TO_TRY.md](FIRST_THINGS_TO_TRY.md)** - Learn what each plugin does
3. **[QUICK_START.md](QUICK_START.md)** - Installation guide
4. **[docs/KEYBINDINGS_REFERENCE.md](docs/KEYBINDINGS_REFERENCE.md)** - All shortcuts

## ⚡ Quick Fix (Nothing Works?)

```bash
# Kill all Neovim
pkill nvim

# Clean everything
rm -rf ~/.local/share/nvim/lazy ~/.local/state/nvim ~/.cache/nvim

# Open Neovim (wait for install)
nvim
# When done, close: :qa!

# Restart
nvim
```

**Read [START_HERE.md](START_HERE.md) for detailed steps!**

## 🎮 Essential Keys

Leader key is `<Space>`

| What | Key | Try It |
|------|-----|--------|
| **Jump anywhere** | `s` | Press `s` then first letter of word |
| **Completions** | Auto | Just start typing! |
| **Terminal** | `<Space>lt` | Quick terminal access |
| **Run code** | `<Space>rs` | Execute code instantly |
| **AI help** | `<Space>aa` | Ask AI anything |
| **Go to definition** | `gd` | Jump to code definition |
| **Documentation** | `K` | Show docs for word under cursor |

## 🔧 What's Included

### Core
- **COQ** - Fast auto-completion
- **LSP** - Language servers (TypeScript, Python, Lua, etc.)
- **Treesitter** - Syntax highlighting
- **Mason** - LSP/tool installer

### Navigation
- **Luxmotion** - Jump to any word with `s`
- **Telescope** - Fuzzy finder
- **Smear Cursor** - Smooth cursor animations

### Development
- **DAP** - Full debugging support
- **Sniprun** - Run code instantly
- **Jester** - Jest testing
- **Octo** - GitHub integration

### Terminal
- **Luxterm** - Terminal splits
- **Floatty** - Floating terminals
- **TMUX** - Seamless TMUX navigation

### Utilities
- **Avante** - AI coding assistant (Claude)
- **Glow** - Markdown preview
- **JQX** - JSON query tool
- **Swenv** - Python virtual environments
- **Pathfinder** - Path navigation

### Git
- **LazyGit** - Git UI
- **Gitsigns** - Git decorations
- **Octo** - GitHub in Neovim

## 📚 Documentation

Full docs in the `docs/` folder:
- Plugin-specific guides
- Keybinding references
- Configuration details

## 🆘 Help

**Seeing errors?** → Read [FIX_ERRORS_NOW.md](FIX_ERRORS_NOW.md)

**Want to try everything?** → Read [FIRST_THINGS_TO_TRY.md](FIRST_THINGS_TO_TRY.md)

**Need installation help?** → Read [QUICK_START.md](QUICK_START.md)

## 🎓 Learning Path

1. Read [FIRST_THINGS_TO_TRY.md](FIRST_THINGS_TO_TRY.md)
2. Practice the basics (navigation, completions, terminal)
3. Try advanced features (debugging, AI, testing)
4. Customize in `lua/cetusian/plugins/`

Enjoy your supercharged Neovim! 🚀
