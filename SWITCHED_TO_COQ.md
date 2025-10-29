# Switched to COQ Completion Engine!

Your Neovim config now uses **COQ** instead of nvim-cmp for autocompletion.

## What Changed

### Files Modified

1. **`lua/cetusian/plugins/nvim-cmp.lua`**
   - Added `enabled = false` - nvim-cmp is now disabled

2. **`lua/cetusian/plugins/coq.lua`**
   - Changed `enabled = true` - COQ is now active
   - Added proper priority for loading order

3. **`lua/cetusian/plugins/lsp/lspconfig.lua`**
   - Replaced `cmp_nvim_lsp` with COQ
   - All LSP servers now use `coq.lsp_ensure_capabilities()`
   - Updated dependencies to include COQ

## COQ Keybindings

| Key | Mode | Description |
|-----|------|-------------|
| `<C-Space>` | Insert | Manual completion trigger |
| `<Tab>` | Insert | Next completion item |
| `<S-Tab>` | Insert | Previous completion item |
| `<CR>` | Insert | Accept completion |

## Features

- **Auto-start**: Completions appear automatically as you type
- **Fast**: Highly optimized performance
- **LSP Integration**: Works with all your language servers (ts_ls, lua_ls, pyright, etc.)
- **Fuzzy Matching**: Smart completion suggestions
- **Snippets**: Built-in snippet support via coq.artifacts
- **Third-party Sources**: Extensive plugin support

## Next Steps

1. **Restart Neovim completely**: `:qa!`

2. **Restart Neovim and let COQ install**:
   ```bash
   nvim
   ```

3. **Wait for COQ to build** (first time only):
   - COQ will automatically run `:COQdeps`
   - This installs required dependencies
   - You'll see a notification when complete

4. **Test completion**:
   - Open any file (`.lua`, `.js`, `.py`, etc.)
   - Start typing - completions appear automatically!
   - Use `<Tab>` to navigate completions
   - Press `<CR>` to accept

## How It Works

COQ automatically integrates with your LSP servers. When you type:

1. COQ queries the language server
2. Shows completions in a popup menu
3. Ranks suggestions intelligently
4. Provides context from LSP, buffers, and paths

## Differences from nvim-cmp

| Feature | COQ | nvim-cmp |
|---------|-----|----------|
| **Speed** | ⚡ Faster | Fast |
| **Auto-start** | ✅ Yes (default) | Optional |
| **Setup** | Simpler | More config |
| **Keybindings** | Tab-based | Customizable |
| **Community** | Growing | Larger |

## Troubleshooting

**No completions appearing?**
1. Check COQ loaded: `:COQstatus` or just start typing
2. Check LSP attached: `:LspInfo`
3. Restart LSP: `<leader>rs`
4. Restart COQ: `:COQnow --shut-up`

**COQ not found error?**
1. Run `:Lazy sync`
2. Restart Neovim
3. Wait for `:COQdeps` to complete

**Want more sources?**
- COQ supports third-party sources
- Check `coq.thirdparty` for extensions

## Configuration

COQ settings are in `lua/cetusian/plugins/coq.lua`:

```lua
vim.g.coq_settings = {
  auto_start = "shut-up", -- Auto-start without prompt
  keymap = {
    recommended = false,
    manual_complete = "<C-Space>",
  },
}
```

Customize these settings to your preference!

## Switching Back

If you prefer nvim-cmp, see the instructions in `docs/coq.md`.

---

Enjoy faster, smarter completions with COQ! 🚀
