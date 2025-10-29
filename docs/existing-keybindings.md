# Existing Core Keybindings

Leader key: `<Space>`

## General Navigation

| Key | Mode | Description |
|-----|------|-------------|
| `jk` | Insert | Exit insert mode |
| `<leader>nh` | Normal | Clear search highlights |

## Number Operations

| Key | Mode | Description |
|-----|------|-------------|
| `<leader>+` | Normal | Increment number under cursor |
| `<leader>-` | Normal | Decrement number under cursor |

## Window Management

### Splits

| Key | Mode | Description |
|-----|------|-------------|
| `<leader>sv` | Normal | Split window vertically |
| `<leader>sh` | Normal | Split window horizontally |
| `<leader>se` | Normal | Make splits equal size |
| `<leader>sx` | Normal | Close current split |

### Tabs

| Key | Mode | Description |
|-----|------|-------------|
| `<leader>to` | Normal | Open new tab |
| `<leader>tx` | Normal | Close current tab |
| `<leader>tn` | Normal | Go to next tab |
| `<leader>tp` | Normal | Go to previous tab |
| `<leader>tf` | Normal | Open current buffer in new tab |

## Why These Keybindings?

- **jk for ESC**: Faster than reaching for ESC key, keeps hands on home row
- **Space as leader**: Easily accessible with either thumb
- **Logical prefixes**:
  - `s` = split/window operations
  - `t` = tab operations
  - `n` = navigation/UI operations
