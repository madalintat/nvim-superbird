# Swenv - Python Virtual Environment Switcher

Quickly switch between Python virtual environments.

## Keybindings

| Key | Mode | Description |
|-----|------|-------------|
| `<leader>ve` | Normal | Pick virtual environment |
| `<leader>vc` | Normal | Show current environment |

## Usage

1. Press `<leader>ve` to open environment picker
2. Select your target virtual environment
3. LSP automatically restarts with new environment
4. Check current env with `<leader>vc`

## Why Use Swenv?

- **Project Switching**: Different Python versions per project
- **Dependency Management**: Isolated package environments
- **LSP Integration**: Automatically updates language server
- **Quick Switching**: No terminal commands needed
- **Visual Picker**: See all available environments

## Where to Use

- Multi-project Python development
- Testing across Python versions
- Projects with different dependency sets
- Virtual environment debugging
- Package development and testing

## Configuration

Default search path: `~/.virtualenvs/`

To add custom paths, edit the swenv.lua config file.

## Prerequisites

- Python virtual environments created
- Environments in `~/.virtualenvs/` or configured path

## Creating Environments

```bash
python -m venv ~/.virtualenvs/myproject
```

## Tips

- Create one virtualenv per project
- Name environments clearly (e.g., `project-py311`)
- Use with Pyright/Pylance LSP for best results
- Combine with DAP for debugging in specific environments
- Automatically restarts LSP on switch
