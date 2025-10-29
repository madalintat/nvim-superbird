# Complete Keybindings Reference

Leader key: `<Space>`

## Core Neovim

| Key | Mode | Description |
|-----|------|-------------|
| `jk` | Insert | Exit insert mode |
| `<leader>nh` | Normal | Clear search highlights |
| `<leader>+` | Normal | Increment number |
| `<leader>-` | Normal | Decrement number |

## Window & Tab Management

| Key | Mode | Description |
|-----|------|-------------|
| `<leader>sv` | Normal | Split window vertically |
| `<leader>sh` | Normal | Split window horizontally |
| `<leader>se` | Normal | Make splits equal size |
| `<leader>sx` | Normal | Close current split |
| `<leader>to` | Normal | Open new tab |
| `<leader>tx` | Normal | Close current tab |
| `<leader>tn` | Normal | Go to next tab |
| `<leader>tp` | Normal | Go to previous tab |
| `<leader>tf` | Normal | Open current buffer in new tab |

## Navigation (Luxmotion)

| Key | Mode | Description |
|-----|------|-------------|
| `s` | Normal/Visual/Operator | Jump forward to location |
| `S` | Normal/Visual/Operator | Jump backward to location |

## Terminal (Luxterm)

| Key | Mode | Description |
|-----|------|-------------|
| `<leader>lt` | Normal | Toggle terminal (bottom) |
| `<leader>lv` | Normal | Toggle terminal (vertical) |
| `<leader>lh` | Normal | Toggle terminal (horizontal) |

## Floating Terminal (Floatty)

| Key | Mode | Description |
|-----|------|-------------|
| `<leader>ft` | Normal | Toggle floating terminal |
| `<leader>fn` | Normal | Create new floating terminal |
| `<C-\><C-n>` | Terminal | Exit terminal mode |

## TMUX Integration

| Key | Mode | Description |
|-----|------|-------------|
| `<C-h>` | Normal | Navigate left |
| `<C-j>` | Normal | Navigate down |
| `<C-k>` | Normal | Navigate up |
| `<C-l>` | Normal | Navigate right |
| `<leader>tr` | Normal | Resize TMUX pane |

## Path Management (Pathfinder)

| Key | Mode | Description |
|-----|------|-------------|
| `<leader>pf` | Normal | Find path to current file |
| `<leader>pd` | Normal | Find directories |
| `<leader>pc` | Normal | Copy current path |

## GitHub (Octo)

| Key | Mode | Description |
|-----|------|-------------|
| `<leader>go` | Normal | Open Octo menu |
| `<leader>goi` | Normal | List GitHub issues |
| `<leader>gop` | Normal | List GitHub PRs |
| `<leader>gor` | Normal | View repository |

## Debugging (DAP)

| Key | Mode | Description |
|-----|------|-------------|
| `<leader>db` | Normal | Toggle breakpoint |
| `<leader>dc` | Normal | Continue/Start debugging |
| `<leader>di` | Normal | Step into |
| `<leader>do` | Normal | Step over |
| `<leader>dO` | Normal | Step out |
| `<leader>dr` | Normal | Toggle REPL |
| `<leader>dl` | Normal | Run last config |
| `<leader>du` | Normal | Toggle DAP UI |

## Code Execution (Sniprun)

| Key | Mode | Description |
|-----|------|-------------|
| `<leader>rs` | Normal | Run code snippet |
| `<leader>rs` | Visual | Run selected code |
| `<leader>rc` | Normal | Close sniprun |
| `<leader>rr` | Normal | Reset sniprun |
| `<leader>rl` | Normal | Toggle live mode |

## Jest Testing (Jester)

| Key | Mode | Description |
|-----|------|-------------|
| `<leader>jr` | Normal | Run nearest test |
| `<leader>jf` | Normal | Run file tests |
| `<leader>jl` | Normal | Run last test |
| `<leader>jd` | Normal | Debug nearest test |
| `<leader>jD` | Normal | Debug file tests |

## Python Environment (Swenv)

| Key | Mode | Description |
|-----|------|-------------|
| `<leader>ve` | Normal | Pick virtual environment |
| `<leader>vc` | Normal | Show current environment |

## JSON/YAML (JQX)

| Key | Mode | Description |
|-----|------|-------------|
| `<leader>jq` | Normal | Open JQX query list |
| `<leader>jx` | Normal | Execute JQX query |

## Markdown (Glow)

| Key | Mode | Description |
|-----|------|-------------|
| `<leader>mp` | Normal | Preview markdown |

## AI Assistant (Avante)

| Key | Mode | Description |
|-----|------|-------------|
| `<leader>aa` | Normal | Ask AI |
| `<leader>ae` | Visual | Edit with AI |
| `<leader>ar` | Normal | Refresh AI response |
| `<leader>at` | Normal | Toggle Avante sidebar |

## Keybinding Groups by Prefix

- **`<leader>s*`** - Split/window operations
- **`<leader>t*`** - Tab operations
- **`<leader>l*`** - Luxterm terminal
- **`<leader>f*`** - Floatty floating terminal
- **`<leader>p*`** - Pathfinder
- **`<leader>go*`** - GitHub Octo
- **`<leader>d*`** - Debugging (DAP)
- **`<leader>r*`** - Run code (Sniprun)
- **`<leader>j*`** - Jest testing & JQX
- **`<leader>v*`** - Virtual environments
- **`<leader>m*`** - Markdown
- **`<leader>a*`** - AI (Avante)

## Tips

- Use `jk` instead of ESC for faster mode switching
- `s` for quick navigation with Luxmotion
- `<leader>lt` for quick terminal access
- `<leader>aa` for AI assistance
- `<leader>db` to set breakpoints when debugging
