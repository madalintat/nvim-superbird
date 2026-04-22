# nvim-superbird

A fast, modern Neovim config built for real work. Tokyo Night theme, full LSP, smart completions, git integration, debug adapter, unified test runner, and a handpicked set of plugins that actually get used.

## Install

```bash
git clone https://github.com/madalintat/nvim-superbird.git
cd nvim-superbird
./install.sh
```

Works on **macOS** and **Linux**. The script installs Neovim and dependencies, backs up any existing config, and drops everything in the right place. On first `nvim` launch, `Lazy` will install all plugins; LSP servers arrive via Mason shortly after.

---

## Requirements

- **Neovim ≥ 0.10** (uses `vim.uv`, `lazydev.nvim`). 0.11+ recommended for the new `vim.diagnostic.config` signs API.
- Git, Node.js + npm (LSP servers), Python 3 + pip (Python tooling)
- [lazygit](https://github.com/jesseduffield/lazygit) — optional, for git UI
- A [Nerd Font](https://www.nerdfonts.com/) in your terminal (for icons)

### Terminal notes (macOS)

If you use **Kitty**, make sure `ctrl+h/j/k/l` aren't bound to `neighboring_window` in your `kitty.conf` — they need to pass through to Neovim for split navigation. If you want Kitty window nav, put it on `kitty_mod+h/j/k/l` instead.

---

## Plugins

### UI

| Plugin | What it does |
|--------|-------------|
| [tokyonight.nvim](https://github.com/folke/tokyonight.nvim) | Custom dark colorscheme |
| [lualine.nvim](https://github.com/nvim-lualine/lualine.nvim) | Status line with mode colors |
| [bufferline.nvim](https://github.com/akinsho/bufferline.nvim) | Buffer tab bar |
| [alpha-nvim](https://github.com/goolord/alpha-nvim) | Startup dashboard |
| [noice.nvim](https://github.com/folke/noice.nvim) | Modern cmdline / messages / search popup |
| [nvim-notify](https://github.com/rcarriga/nvim-notify) | Notification manager (used by noice) |
| [fidget.nvim](https://github.com/j-hui/fidget.nvim) | LSP progress notifications |
| [which-key.nvim](https://github.com/folke/which-key.nvim) | Keybinding hints popup with groups |
| [dressing.nvim](https://github.com/stevearc/dressing.nvim) | Better UI for inputs/selects |
| [indent-blankline.nvim](https://github.com/lukas-reineke/indent-blankline.nvim) | Indent guides |
| [rainbow-delimiters.nvim](https://github.com/HiPhish/rainbow-delimiters.nvim) | Colored matching brackets |
| [nvim-colorizer.lua](https://github.com/NvChad/nvim-colorizer.lua) | Live hex/CSS color preview |
| [smear-cursor.nvim](https://github.com/sphamba/smear-cursor.nvim) | Smooth cursor animation |
| [vim-maximizer](https://github.com/szw/vim-maximizer) | Toggle maximize current split |

### Navigation

| Plugin | What it does |
|--------|-------------|
| [nvim-tree.lua](https://github.com/nvim-tree/nvim-tree.lua) | File explorer sidebar |
| [oil.nvim](https://github.com/stevearc/oil.nvim) | Edit the filesystem as a buffer |
| [harpoon](https://github.com/ThePrimeagen/harpoon) (v2) | Pin 1–4 files for instant switching |
| [telescope.nvim](https://github.com/nvim-telescope/telescope.nvim) | Fuzzy find files, text, symbols |
| [whisk.nvim](https://github.com/LuxVim/whisk.nvim) | Flash-style jump to any word (`s` / `S`) |
| [pathfinder.nvim](https://github.com/HawkinsT/pathfinder.nvim) | Find and copy file paths |
| [auto-session](https://github.com/rmagatti/auto-session) | Auto-save/restore sessions per directory |

### Editing

| Plugin | What it does |
|--------|-------------|
| [nvim-autopairs](https://github.com/windwp/nvim-autopairs) | Auto-close brackets, quotes |
| [nvim-surround](https://github.com/kylechui/nvim-surround) | Add/change/delete surroundings |
| [Comment.nvim](https://github.com/numToStr/Comment.nvim) | Smart line/block commenting |
| [substitute.nvim](https://github.com/gbprod/substitute.nvim) | Motion-based substitution (`gs` / `gS`) |
| [todo-comments.nvim](https://github.com/folke/todo-comments.nvim) | Highlight & search TODO/FIXME |
| [mini.ai](https://github.com/echasnovski/mini.ai) | Smarter text objects |
| [mini.move](https://github.com/echasnovski/mini.move) | Move lines/selections with alt+arrows |
| [mini.bufremove](https://github.com/echasnovski/mini.bufremove) | Close buffer without killing window |
| [nvim-ufo](https://github.com/kevinhwang91/nvim-ufo) | Modern code folding (treesitter + indent) |

### LSP / Completion

| Plugin | What it does |
|--------|-------------|
| [nvim-lspconfig](https://github.com/neovim/nvim-lspconfig) | LSP client configs |
| [mason.nvim](https://github.com/williamboman/mason.nvim) | Install LSP servers, formatters, linters |
| [mason-lspconfig.nvim](https://github.com/williamboman/mason-lspconfig.nvim) | Bridge Mason ↔ lspconfig (v2 API) |
| [nvim-cmp](https://github.com/hrsh7th/nvim-cmp) | Completion engine |
| [LuaSnip](https://github.com/L3MON4D3/LuaSnip) | Snippet engine |
| [lazydev.nvim](https://github.com/folke/lazydev.nvim) | Neovim Lua API completions |
| [trouble.nvim](https://github.com/folke/trouble.nvim) | Pretty diagnostics panel |

**LSP servers installed automatically via Mason:** `ts_ls`, `html`, `cssls`, `tailwindcss`, `svelte`, `lua_ls`, `graphql`, `emmet_ls`, `prismals`, `pyright`

### Formatting / Linting

| Plugin | What it does |
|--------|-------------|
| [conform.nvim](https://github.com/stevearc/conform.nvim) | Async format on save |
| [nvim-lint](https://github.com/mfussenegger/nvim-lint) | Async linting |

**Tools installed:** `prettier`, `stylua`, `isort`, `black`, `pylint`, `eslint_d`

### Git

| Plugin | What it does |
|--------|-------------|
| [gitsigns.nvim](https://github.com/lewis6991/gitsigns.nvim) | Inline blame, hunk staging, diff signs |
| [lazygit.nvim](https://github.com/kdheepak/lazygit.nvim) | lazygit in a floating window |
| [octo.nvim](https://github.com/pwntester/octo.nvim) | GitHub PRs and issues inside Neovim |

### Testing / Debugging

| Plugin | What it does |
|--------|-------------|
| [neotest](https://github.com/nvim-neotest/neotest) | Unified test runner (Jest, pytest) |
| [nvim-dap](https://github.com/mfussenegger/nvim-dap) | Debug adapter protocol client |
| [nvim-dap-ui](https://github.com/rcarriga/nvim-dap-ui) | UI for nvim-dap |
| [sniprun](https://github.com/michaelb/sniprun) | Run code snippets inline |

### Terminal / Multiplex

| Plugin | What it does |
|--------|-------------|
| [toggleterm.nvim](https://github.com/akinsho/toggleterm.nvim) | Floating / horizontal / vertical terminals |
| [tmux.nvim](https://github.com/aserowy/tmux.nvim) | Tmux clipboard sync + pane resize |

### Languages / Utilities

| Plugin | What it does |
|--------|-------------|
| [nvim-treesitter](https://github.com/nvim-treesitter/nvim-treesitter) | Syntax highlighting and parsing |
| [render-markdown.nvim](https://github.com/MeanderingProgrammer/render-markdown.nvim) | Prettified markdown rendering in buffer |
| [glow.nvim](https://github.com/ellisonleao/glow.nvim) | Markdown preview (glow CLI) |
| [nvim-jqx](https://github.com/gennaro-tedesco/nvim-jqx) | Browse and query JSON files |
| [swenv.nvim](https://github.com/AckslD/swenv.nvim) | Switch Python virtual environments |

---

## Keybindings

Leader key: `Space`

### Splits & navigation

| Key | Action |
|-----|--------|
| `<C-h>` / `<C-j>` / `<C-k>` / `<C-l>` | Move between splits |
| `<leader>sv` / `<leader>sh` | Split vertical / horizontal |
| `<leader>se` | Equalize splits |
| `<leader>sx` | Close split |
| `<leader>sm` | Maximize / restore split |

### Files & search

| Key | Action |
|-----|--------|
| `<leader>ee` | Toggle file explorer (nvim-tree) |
| `<leader>ef` | Focus file explorer on current file |
| `<leader>ec` | Collapse file explorer |
| `-` | Open parent dir as buffer (oil) |
| `<leader>ff` | Find files |
| `<leader>fr` | Recent files |
| `<leader>fs` | Live grep |
| `<leader>fc` | Grep word under cursor |

### Harpoon

| Key | Action |
|-----|--------|
| `<leader>Ha` | Add current file |
| `<leader>Hm` | Open harpoon menu |
| `<leader>H1`…`<leader>H4` | Jump to slot 1–4 |
| `<leader>Hn` / `<leader>Hp` | Next / previous |

### Motion

| Key | Action |
|-----|--------|
| `s` / `S` | Jump forward / backward (whisk) |
| `gs{motion}` | Substitute with motion |
| `gss` | Substitute line |
| `gS` | Substitute to end of line |
| `<A-Up>` / `<A-Down>` | Move line up/down (mini.move) |

### LSP

| Key | Action |
|-----|--------|
| `gd` | Go to definition |
| `gD` | Go to declaration |
| `gR` | Show references |
| `gi` | Show implementations |
| `gt` | Show type definitions |
| `K` | Show hover docs |
| `<leader>ca` | Code actions |
| `<leader>rn` | Rename symbol |
| `<leader>d` | Line diagnostics |
| `<leader>D` | Buffer diagnostics |
| `[d` / `]d` | Previous / next diagnostic |
| `<leader>rs` | Restart LSP |

### Completion (insert mode)

| Key | Action |
|-----|--------|
| `<C-j>` / `<C-k>` | Next / previous suggestion |
| `<C-Space>` | Trigger completion |
| `<CR>` | Confirm |
| `<C-e>` | Close menu |

### Git

| Key | Action |
|-----|--------|
| `<leader>lg` | Open lazygit |
| `<leader>hs` / `<leader>hr` | Stage / reset hunk |
| `<leader>hS` / `<leader>hR` | Stage / reset buffer |
| `<leader>hp` | Preview hunk |
| `<leader>hb` / `<leader>hB` | Blame line / toggle line-blame |
| `<leader>hd` / `<leader>hD` | Diff this / diff against |

### Testing

| Key | Action |
|-----|--------|
| `<leader>nr` | Run nearest test |
| `<leader>nf` | Run file |
| `<leader>nl` | Run last |
| `<leader>ns` | Toggle summary |
| `<leader>no` | Output popup |
| `<leader>nO` | Output panel |
| `<leader>nd` | Debug nearest (via nvim-dap) |
| `<leader>nS` | Stop |

### Debug (nvim-dap)

| Key | Action |
|-----|--------|
| `<leader>db` | Toggle breakpoint |
| `<leader>dc` | Continue |
| `<leader>di` / `<leader>do` / `<leader>dO` | Step into / over / out |
| `<leader>dr` | Toggle REPL |
| `<leader>dl` | Run last |
| `<leader>du` | Toggle DAP UI |

### Folding (ufo)

| Key | Action |
|-----|--------|
| `zR` | Open all folds |
| `zM` | Close all folds |

### Terminal

| Key | Action |
|-----|--------|
| `<C-\>` | Toggle terminal (float) |
| `<leader>Tf` / `<leader>Th` / `<leader>Tv` | Terminal: float / horizontal / vertical |

### Buffers / tabs

| Key | Action |
|-----|--------|
| `<leader>bd` | Delete buffer (keep window) |
| `<leader>bD` | Delete buffer (force) |
| `<leader>to` / `<leader>tx` | New / close tab |
| `<leader>tn` / `<leader>tp` | Next / previous tab |

### Other

| Key | Action |
|-----|--------|
| `jk` | Exit insert mode |
| `<leader>nh` | Clear search highlights |
| `gcc` / `gc` (visual) | Toggle line / block comment |
| `<leader>wr` / `<leader>ws` | Restore / save session |
| `<leader>mp` | Format file/range |
| `<leader>mg` | Preview markdown (Glow) |
| `<leader>mr` | Toggle render-markdown |

---

## Post-install

After the script finishes:

```bash
nvim
```

On first launch:
1. `Lazy` auto-installs plugins (a minute or two)
2. `Mason` installs LSP servers in the background
3. `:TSUpdate` if treesitter parsers need refreshing
4. Press `<leader>` and wait to see `which-key` groups
