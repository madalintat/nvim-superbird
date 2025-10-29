# Sniprun - Code Runner

Execute code snippets and see results instantly without leaving Neovim.

## Keybindings

| Key | Mode | Description |
|-----|------|-------------|
| `<leader>rs` | Normal | Run code snippet (current line/block) |
| `<leader>rs` | Visual | Run selected code |
| `<leader>rc` | Normal | Close sniprun output |
| `<leader>rr` | Normal | Reset sniprun |
| `<leader>rl` | Normal | Toggle live mode (run on change) |

## Supported Languages

Python, JavaScript, TypeScript, Rust, Go, Lua, Ruby, C, C++, Java, and many more!

## Usage

1. Write code or select lines
2. Press `<leader>rs` to execute
3. See results in virtual text or floating window
4. Use `<leader>rl` for live mode (runs automatically as you type)

## Why Use Sniprun?

- **Instant Feedback**: Test code without saving or running full files
- **Learning Tool**: Experiment with syntax and functions
- **REPL Alternative**: Interactive coding without separate REPL
- **Multi-Language**: One tool for all languages
- **Visual Output**: Results appear inline with your code

## Where to Use

- Learning new language features
- Testing algorithms and logic
- API response validation
- Quick calculations
- Documentation examples validation
- Teaching and demonstrations

## Examples

**Python:**
```python
print("Hello from Sniprun!")
# Select and press <leader>rs
```

**JavaScript:**
```javascript
console.log([1,2,3].map(x => x * 2))
// Run with <leader>rs
```

## Tips

- Use live mode for rapid prototyping
- Visual mode for testing specific code blocks
- Combine with DAP for full development workflow
- Great for Advent of Code and coding challenges
