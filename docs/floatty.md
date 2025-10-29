# Floatty - Floating Terminal

Elegant floating terminal windows for quick command execution.

## Keybindings

| Key | Mode | Description |
|-----|------|-------------|
| `<leader>ft` | Normal | Toggle floating terminal |
| `<leader>fn` | Normal | Create new floating terminal |
| `<C-\><C-n>` | Terminal | Exit terminal mode |

## Usage

Press `<leader>ft` to open a centered floating terminal window. The terminal appears as an overlay without disrupting your layout.

## Why Use Floatty?

- **Non-Intrusive**: Floats over your code without changing splits
- **Quick Access**: Pop up terminal, run command, dismiss
- **Multiple Terminals**: Create several floating terminals for different tasks
- **Clean UI**: Rounded borders for modern appearance
- **Persistent**: Terminals remain active when hidden

## Where to Use

- Running one-off commands
- Quick git operations
- File system operations
- Testing CLI commands
- Monitoring processes

## Difference from Luxterm

- **Floatty**: Floating overlay, temporary tasks, quick commands
- **Luxterm**: Persistent split, long-running processes, side-by-side work

## Tips

- Use `<leader>fn` to create multiple terminals for different contexts
- Combine with tmux.nvim for maximum flexibility
- Perfect for git commands while reviewing code
- Use `<C-\><C-n>` to navigate terminal output with Neovim motions
