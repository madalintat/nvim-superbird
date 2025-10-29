# Jester - Jest Testing

Run and debug Jest tests directly from Neovim.

## Keybindings

| Key | Mode | Description |
|-----|------|-------------|
| `<leader>jr` | Normal | Run nearest Jest test |
| `<leader>jf` | Normal | Run all tests in current file |
| `<leader>jl` | Normal | Run last test |
| `<leader>jd` | Normal | Debug nearest test |
| `<leader>jD` | Normal | Debug all tests in file |

## Usage

1. Place cursor in or near a test
2. Press `<leader>jr` to run that specific test
3. Results appear in terminal
4. Use `<leader>jd` to debug with DAP

## Why Use Jester?

- **Cursor-Based**: Automatically finds the test under cursor
- **Fast Feedback**: Run single tests without full test suite
- **Integrated Debugging**: Debug tests with full DAP support
- **Efficient TDD**: Rapid test-driven development cycle
- **File-Scoped**: Run file tests without entire suite overhead

## Where to Use

- JavaScript/TypeScript projects with Jest
- Test-driven development (TDD)
- Debugging failing tests
- Writing new test cases
- Refactoring with test coverage

## Prerequisites

- Jest must be installed in your project
- Node.js project with `package.json`
- For debugging: DAP adapters configured

## Workflow Example

1. Write a test
2. `<leader>jr` to run it
3. If it fails, `<leader>jd` to debug
4. Fix code
5. `<leader>jl` to re-run last test

## Tips

- Use with DAP for breakpoint debugging in tests
- Combine with auto-session to restore test context
- Run single tests during development, full suite in CI
- Use `<leader>jl` for quick feedback loop
