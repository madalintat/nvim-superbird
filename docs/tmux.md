# TMUX Integration

Seamless navigation between Neovim splits and TMUX panes.

## Keybindings

| Key | Mode | Description |
|-----|------|-------------|
| `<C-h>` | Normal | Navigate left (Neovim/TMUX) |
| `<C-j>` | Normal | Navigate down (Neovim/TMUX) |
| `<C-k>` | Normal | Navigate up (Neovim/TMUX) |
| `<C-l>` | Normal | Navigate right (Neovim/TMUX) |
| `<leader>tr` | Normal | Resize TMUX pane |

## Features

- **Unified Navigation**: Same keys work in Neovim splits and TMUX panes
- **Copy Sync**: Clipboard synchronization between Neovim and TMUX
- **Resize Integration**: Coordinated pane/split resizing
- **Cycle Navigation**: Move through panes cyclically

## Why Use TMUX Integration?

- **Seamless Workflow**: No mental context switch between TMUX and Neovim
- **Consistent Keybindings**: Same navigation everywhere
- **Clipboard Sharing**: Copy in Neovim, paste in TMUX panes
- **Enhanced Productivity**: Treat TMUX panes as Neovim splits

## Where to Use

- Multi-pane development environments
- When running servers/watchers in TMUX panes
- Terminal-heavy workflows
- Remote development sessions

## Prerequisites

- TMUX must be installed and running
- Works best with vim-tmux-navigator in TMUX config

## Tips

- Use with Luxterm for the ultimate terminal setup
- Combine with auto-session to restore TMUX layouts
