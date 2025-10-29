# nvim-jqx - JSON/YAML Query

Explore and query JSON/YAML files with jq-like syntax.

## Keybindings

| Key | Mode | Description |
|-----|------|-------------|
| `<leader>jq` | Normal | Open JQX query list |
| `<leader>jx` | Normal | Execute JQX query |

## Usage

1. Open a JSON or YAML file
2. Press `<leader>jq` to see query options
3. Select a query or press `<leader>jx` to write custom query
4. Results appear in a new buffer

## Why Use JQX?

- **Interactive Queries**: Explore JSON structure visually
- **jq Integration**: Use familiar jq syntax
- **Large Files**: Handle big JSON files efficiently
- **YAML Support**: Works with both JSON and YAML
- **No Terminal Needed**: Query within Neovim

## Where to Use

- API response analysis
- Configuration file exploration
- Log file parsing (JSON logs)
- Data transformation
- Learning jq syntax
- Debugging API payloads

## Example Queries

- `.` - Show entire structure
- `.data` - Get data field
- `.[] | .name` - Get all names from array
- `.[].tags[]` - Flatten nested arrays
- `.[] | select(.status == "active")` - Filter items

## Prerequisites

- `jq` must be installed on your system
- Install: `brew install jq` (macOS) or `apt install jq` (Linux)

## Tips

- Use on API response files
- Combine with Telescope for file finding
- Great for exploring unfamiliar JSON structures
- Save common queries for reuse
- Use in code reviews of JSON configs
