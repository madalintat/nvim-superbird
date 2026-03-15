# nvim-superbird

A fast, modern Neovim config built for real work. Tokyo Night theme, full LSP, smart completions, git integration, debug adapter, and a handpicked set of plugins that actually get used.

## Install

```bash
git clone https://github.com/your-username/nvim-superbird.git
cd nvim-superbird
./install.sh
```

Works on **macOS** and **Linux**. The script installs Neovim and all dependencies, backs up any existing config, and drops everything in the right place. Open `nvim` afterwards and plugins install automatically.

---

## Plugins

### Editor

| Plugin | What it does |
|--------|-------------|
| [tokyonight.nvim](https://github.com/folke/tokyonight.nvim) | Custom dark colorscheme |
| [lualine.nvim](https://github.com/nvim-lualine/lualine.nvim) | Status line with mode colors and lazy update count |
| [bufferline.nvim](https://github.com/akinsho/bufferline.nvim) | Tab bar for open buffers |
| [nvim-tree.lua](https://github.com/nvim-tree/nvim-tree.lua) | File explorer sidebar |
| [alpha-nvim](https://github.com/goolord/alpha-nvim) | Dashboard on startup |
| [which-key.nvim](https://github.com/folke/which-key.nvim) | Keybinding hints popup |
| [indent-blankline.nvim](https://github.com/lukas-reineke/indent-blankline.nvim) | Indent guides |
| [smear-cursor.nvim](https://github.com/sphamba/smear-cursor.nvim) | Smooth cursor animation |
| [dressing.nvim](https://github.com/stevearc/dressing.nvim) | Better UI for inputs and selects |
| [vim-maximizer](https://github.com/szw/vim-maximizer) | Toggle maximize current split |

### Navigation & Motion

| Plugin | What it does |
|--------|-------------|
| [nvim-luxmotion](https://github.com/LuxVim/nvim-luxmotion) | Flash-style jump to any word with `s` / `S` |
| [pathfinder.nvim](https://github.com/HawkinsT/pathfinder.nvim) | Find and copy file paths |
| [telescope.nvim](https://github.com/nvim-telescope/telescope.nvim) | Fuzzy find files, text, LSP symbols |
| [auto-session](https://github.com/rmagatti/auto-session) | Auto-save and restore sessions per directory |

### LSP & Completions

| Plugin | What it does |
|--------|-------------|
| [nvim-lspconfig](https://github.com/neovim/nvim-lspconfig) | LSP client configs |
| [mason.nvim](https://github.com/williamboman/mason.nvim) | Install LSP servers, formatters, linters |
| [nvim-cmp](https://github.com/hrsh7th/nvim-cmp) | Completion engine |
| [LuaSnip](https://github.com/L3MON4D3/LuaSnip) | Snippet engine with VSCode-style snippets |
| [neodev.nvim](https://github.com/folke/neodev.nvim) | Neovim Lua API completions |
| [trouble.nvim](https://github.com/folke/trouble.nvim) | Pretty diagnostics panel |

**LSP servers installed automatically:** `ts_ls`, `html`, `cssls`, `tailwindcss`, `svelte`, `lua_ls`, `graphql`, `emmet_ls`, `prismals`, `pyright`

### Formatting & Linting

| Plugin | What it does |
|--------|-------------|
| [conform.nvim](https://github.com/stevearc/conform.nvim) | Auto-format on save |
| [nvim-lint](https://github.com/mfussenegger/nvim-lint) | Async linting |

**Formatters/linters installed:** `prettier`, `stylua`, `isort`, `black`, `pylint`, `eslint_d`

### Git

| Plugin | What it does |
|--------|-------------|
| [gitsigns.nvim](https://github.com/lewis6991/gitsigns.nvim) | Inline git blame, hunk staging, diff signs |
| [lazygit.nvim](https://github.com/kdheepak/lazygit.nvim) | Open lazygit in a floating window |
| [octo.nvim](https://github.com/pwntester/octo.nvim) | GitHub PRs and issues inside Neovim |

### Debugging

| Plugin | What it does |
|--------|-------------|
| [nvim-dap](https://github.com/mfussenegger/nvim-dap) | Debug adapter protocol client |
| [nvim-dap-ui](https://github.com/rcarriga/nvim-dap-ui) | UI for nvim-dap |
| [jester](https://github.com/David-Kunz/jester) | Run Jest tests from Neovim |

### Terminal

| Plugin | What it does |
|--------|-------------|
| [nvim-luxterm](https://github.com/LuxVim/nvim-luxterm) | Toggleable terminal splits |
| [floatty.nvim](https://github.com/ingur/floatty.nvim) | Floating terminal windows |
| [vim-tmux-navigator](https://github.com/christoomey/vim-tmux-navigator) | Seamless pane navigation between Neovim and tmux |

### Extras

| Plugin | What it does |
|--------|-------------|
| [nvim-treesitter](https://github.com/nvim-treesitter/nvim-treesitter) | Syntax highlighting and code parsing |
| [nvim-autopairs](https://github.com/windwp/nvim-autopairs) | Auto-close brackets, quotes |
| [nvim-surround](https://github.com/kylechui/nvim-surround) | Add/change/delete surroundings |
| [Comment.nvim](https://github.com/numToStr/Comment.nvim) | Smart line and block commenting |
| [substitute.nvim](https://github.com/gbprod/substitute.nvim) | Motion-based substitution |
| [todo-comments.nvim](https://github.com/folke/todo-comments.nvim) | Highlight and search TODO/FIXME/etc |
| [glow.nvim](https://github.com/ellisonleao/glow.nvim) | Markdown preview in terminal |
| [nvim-jqx](https://github.com/gennaro-tedesco/nvim-jqx) | Browse and query JSON files |
| [sniprun](https://github.com/michaelb/sniprun) | Run code snippets inline |
| [swenv.nvim](https://github.com/AckslD/swenv.nvim) | Switch Python virtual environments |

---

## Keybindings

Leader key: `Space`

### Files & Navigation

| Key | Action |
|-----|--------|
| `<leader>ee` | Toggle file explorer |
| `<leader>ef` | Focus file explorer |
| `<leader>ec` | Collapse file explorer |
| `<leader>ff` | Find files |
| `<leader>fs` | Live grep (search text) |
| `<leader>fc` | Find word under cursor |
| `<leader>fb` | Find open buffers |
| `s` | Jump forward (luxmotion) |
| `S` | Jump backward (luxmotion) |

### LSP

| Key | Action |
|-----|--------|
| `gd` | Go to definition |
| `gD` | Go to declaration |
| `gR` | Show references |
| `gi` | Show implementations |
| `K` | Show hover docs |
| `<leader>ca` | Code actions |
| `<leader>rn` | Rename symbol |
| `<leader>d` | Show line diagnostics |
| `<leader>D` | Show buffer diagnostics |
| `[d` / `]d` | Previous / next diagnostic |
| `<leader>rs` | Restart LSP |

### Completions

| Key | Action |
|-----|--------|
| `<C-j>` | Next suggestion |
| `<C-k>` | Previous suggestion |
| `<C-Space>` | Trigger completions |
| `<CR>` | Confirm selection |
| `<C-e>` | Close completion menu |

### Git

| Key | Action |
|-----|--------|
| `<leader>lg` | Open lazygit |
| `<leader>hs` | Stage hunk |
| `<leader>hr` | Reset hunk |
| `<leader>hp` | Preview hunk |
| `<leader>hb` | Blame line |

### Terminal

| Key | Action |
|-----|--------|
| `<leader>lt` | Toggle Luxterm |
| `<leader>lv` | Toggle vertical split terminal |
| `<leader>lh` | Toggle horizontal split terminal |
| `<leader>ft` | Toggle floating terminal |

### Splits & Tabs

| Key | Action |
|-----|--------|
| `<leader>sv` | Split vertical |
| `<leader>sh` | Split horizontal |
| `<leader>se` | Equalize splits |
| `<leader>sx` | Close split |
| `<leader>sm` | Maximize / restore split |
| `<leader>to` | New tab |
| `<leader>tx` | Close tab |
| `<leader>tn` / `<leader>tp` | Next / prev tab |

### Other

| Key | Action |
|-----|--------|
| `jk` | Exit insert mode |
| `<leader>nh` | Clear search highlights |
| `gcc` | Toggle line comment |
| `gc` (visual) | Toggle block comment |
| `<leader>wr` | Restore session |

---

## Requirements

- Neovim >= 0.9
- Git
- Node.js + npm (for LSP servers)
- Python 3 + pip (for Python tooling)
- [lazygit](https://github.com/jesseduffield/lazygit) (optional, for git UI)
- A [Nerd Font](https://www.nerdfonts.com/) in your terminal (for icons)
