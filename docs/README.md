# Neovim Superbird Configuration

Welcome to your enhanced Neovim configuration! This setup includes powerful plugins for navigation, development, debugging, and AI assistance.

## Documentation Index

### Core Keybindings
- [Existing Keybindings](./existing-keybindings.md) - Core Neovim and window management bindings

### Navigation & Motion
- [Luxmotion](./luxmotion.md) - Fast cursor navigation
- [Smear Cursor](./smear-cursor.md) - Smooth cursor animations
- [Pathfinder](./pathfinder.md) - Path navigation and copying

### Terminal & TMUX
- [Luxterm](./luxterm.md) - Terminal management
- [Floatty](./floatty.md) - Floating terminal windows
- [TMUX Integration](./tmux.md) - Seamless TMUX navigation

### Development Tools
- [Debugging (DAP)](./dap.md) - Full debugging support
- [Sniprun](./sniprun.md) - Run code snippets instantly
- [Jester](./jester.md) - Jest testing for JavaScript/TypeScript

### GitHub Integration
- [Octo](./octo.md) - GitHub issues and PRs in Neovim

### Python Development
- [Swenv](./swenv.md) - Virtual environment switcher

### File Viewers
- [JQX](./jqx.md) - JSON/YAML query and exploration
- [Glow](./glow.md) - Markdown preview

### AI & Completion
- [Avante](./avante.md) - AI-powered coding assistant
- [COQ](./coq.md) - Alternative completion engine (disabled by default)

## Quick Start

All plugins are automatically loaded by lazy.nvim. Leader key is `<Space>`.

To sync plugins: `:Lazy sync`

To check plugin status: `:Lazy`

## Plugin Management

This configuration uses [lazy.nvim](https://github.com/folke/lazy.nvim) for plugin management. Plugins are organized in `lua/cetusian/plugins/` with each plugin having its own configuration file.
