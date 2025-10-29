# COQ - Fast Completion Engine

Fast, feature-rich completion engine - **NOW ACTIVE** (nvim-cmp is disabled).

## Status: ENABLED

COQ is now your primary completion engine! It provides fast, intelligent autocompletion with LSP integration.

## Keybindings (when enabled)

| Key | Mode | Description |
|-----|------|-------------|
| `<C-Space>` | Insert | Manual completion trigger |
| `<Tab>` | Insert | Next completion |
| `<S-Tab>` | Insert | Previous completion |

## Why Use COQ?

- **Fast**: Written in Python, highly optimized
- **Auto-start**: Completions appear automatically
- **Extensive Sources**: LSP, buffers, paths, snippets
- **Fuzzy Matching**: Intelligent completion ranking
- **Third-party Integrations**: Supports many completion sources

## Why COQ?

- **Speed**: Generally faster than nvim-cmp
- **Auto-start**: Completions appear automatically (no trigger needed)
- **LSP Integration**: Seamless integration with all language servers
- **Fuzzy Matching**: Intelligent completion ranking
- **Third-party Sources**: Extensive completion sources

## Switching Back to nvim-cmp

If you want to switch back:

1. Edit `lua/cetusian/plugins/coq.lua` - change `enabled = true` to `enabled = false`
2. Edit `lua/cetusian/plugins/nvim-cmp.lua` - change `enabled = false` to `enabled = true`
3. Edit `lua/cetusian/plugins/lsp/lspconfig.lua` - replace COQ with cmp-nvim-lsp
4. Restart Neovim

## Features

- Automatic completions (no trigger needed)
- LSP integration
- Buffer word completion
- Path completion
- Snippet support (with coq.artifacts)
- Third-party source support

## Installation Note

Requires `:COQdeps` to run after first install (automatic in config).

## Tips

- Try both and see which you prefer
- Both are excellent completion engines
- Cannot run both simultaneously
- Easy to switch between them
- Your choice depends on workflow preference
