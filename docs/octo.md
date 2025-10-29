# Octo - GitHub Integration

Manage GitHub issues, pull requests, and repositories directly from Neovim.

## Keybindings

| Key | Mode | Description |
|-----|------|-------------|
| `<leader>go` | Normal | Open Octo menu |
| `<leader>goi` | Normal | List GitHub issues |
| `<leader>gop` | Normal | List GitHub pull requests |
| `<leader>gor` | Normal | View repository details |

## Commands

- `:Octo issue list` - List issues
- `:Octo issue create` - Create new issue
- `:Octo pr list` - List PRs
- `:Octo pr create` - Create new PR
- `:Octo pr checkout <number>` - Checkout PR branch
- `:Octo review start` - Start PR review
- `:Octo review submit` - Submit PR review

## Why Use Octo?

- **Native Workflow**: GitHub operations without leaving Neovim
- **Keyboard-Driven**: Faster than web interface
- **Code Context**: Review PRs alongside your code
- **Integrated**: Works with Telescope and other plugins
- **Efficient Reviews**: Comment, approve, request changes inline

## Where to Use

- PR reviews and code comments
- Issue triage and management
- Creating PRs from feature branches
- Repository exploration
- Quick issue creation from code

## Prerequisites

- GitHub CLI (`gh`) must be installed
- Run `gh auth login` to authenticate

## Tips

- Use `:Octo actions` to see all available commands
- Review PRs split-screen with `<leader>sv`
- Combine with gitsigns for comprehensive Git workflow
