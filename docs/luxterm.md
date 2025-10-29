# Luxterm - Terminal Management

A simple, elegant terminal manager for Neovim.

## Keybindings

| Key | Mode | Description |
|-----|------|-------------|
| `<leader>lt` | Normal | Toggle terminal (bottom) |
| `<leader>lv` | Normal | Toggle terminal (vertical split) |
| `<leader>lh` | Normal | Toggle terminal (horizontal split) |

## Usage

Press `<leader>lt` to open/close a terminal at the bottom of your window. The terminal persists across toggles, maintaining your shell session.

## Why Use Luxterm?

- **Persistent Sessions**: Terminal state is preserved when toggled
- **Quick Access**: One keybinding to show/hide terminal
- **Layout Options**: Choose horizontal or vertical splits
- **Integrated Workflow**: Stay in Neovim for terminal tasks

## Where to Use

- Running build commands
- Git operations
- Testing scripts
- Quick shell commands without leaving editor
- Monitoring logs

## Tips

- Use `<leader>lv` for side-by-side code and terminal
- Use `<leader>lt` for quick command execution
- Combine with tmux.nvim for maximum terminal power
