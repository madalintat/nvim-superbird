# DAP - Debug Adapter Protocol

Full-featured debugging support for multiple languages.

## Keybindings

| Key | Mode | Description |
|-----|------|-------------|
| `<leader>db` | Normal | Toggle breakpoint |
| `<leader>dc` | Normal | Continue/Start debugging |
| `<leader>di` | Normal | Step into function |
| `<leader>do` | Normal | Step over line |
| `<leader>dO` | Normal | Step out of function |
| `<leader>dr` | Normal | Toggle REPL |
| `<leader>dl` | Normal | Run last debug configuration |
| `<leader>du` | Normal | Toggle debug UI |

## Features

- **DAP UI**: Automatic UI with variables, stack traces, breakpoints
- **Virtual Text**: See variable values inline in your code
- **REPL**: Interactive debugging console
- **Multi-Language**: Support for Node, Python, Go, and more

## Usage

1. Set breakpoints with `<leader>db`
2. Start debugging with `<leader>dc`
3. Use step commands to navigate through code
4. View variables in the DAP UI sidebar
5. Use REPL for interactive debugging

## Why Use DAP?

- **Professional Debugging**: IDE-level debugging in Neovim
- **Visual Feedback**: See execution path and variable state
- **Efficient Workflow**: No context switching to external debugger
- **Language Agnostic**: One interface for all languages
- **Integrated**: Works seamlessly with LSP and other plugins

## Where to Use

- Complex bug investigation
- Understanding code flow
- Testing edge cases
- Learning new codebases
- Performance analysis

## Configuration Required

Each language needs a DAP adapter. Common ones:
- **Node.js**: Requires `node-debug2-adapter`
- **Python**: Requires `debugpy`
- **Go**: Requires `delve`

Install adapters with Mason: `:Mason`

## Tips

- Use conditional breakpoints for specific scenarios
- Combine with Jester for Jest test debugging
- Watch variables in REPL during execution
- Use `<leader>du` to hide UI when not debugging
