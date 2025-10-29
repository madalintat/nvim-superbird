# Avante - AI Coding Assistant

AI-powered code generation, explanation, and editing with Claude.

## Keybindings

| Key | Mode | Description |
|-----|------|-------------|
| `<leader>aa` | Normal | Ask AI a question |
| `<leader>ae` | Visual | Edit code with AI |
| `<leader>ar` | Normal | Refresh AI response |
| `<leader>at` | Normal | Toggle Avante sidebar |

## Usage

### Ask Questions
1. Press `<leader>aa`
2. Type your question
3. AI response appears in sidebar

### Edit Code
1. Select code in visual mode
2. Press `<leader>ae`
3. Describe the changes you want
4. Review and apply AI suggestions

### Code Generation
1. Press `<leader>aa`
2. Describe what code you need
3. AI generates code
4. Insert into your file

## Why Use Avante?

- **Context-Aware**: Understands your codebase
- **Fast Iterations**: Quick code modifications
- **Learning Tool**: Explains complex code
- **Refactoring**: Suggests improvements
- **Documentation**: Generates comments and docs
- **Powered by Claude**: Uses Anthropic's Claude 3.5 Sonnet

## Where to Use

- Learning new languages/frameworks
- Refactoring legacy code
- Writing tests
- Code explanations
- Bug fixing suggestions
- Documentation generation
- Algorithm implementation
- API integration code

## Example Workflows

**Generate Function:**
```
<leader>aa
"Write a function to parse JWT tokens"
```

**Refactor Code:**
1. Select messy code
2. `<leader>ae`
3. "Refactor this to be more readable"

**Explain Code:**
```
<leader>aa
"Explain what this regex does: /^[\w-\.]+@([\w-]+\.)+[\w-]{2,4}$/"
```

## Configuration

Uses Claude 3.5 Sonnet by default. To use your own API key:

1. Set environment variable: `export ANTHROPIC_API_KEY="your-key"`
2. Restart Neovim

## Tips

- Be specific in prompts for better results
- Use visual selection for targeted edits
- Review AI suggestions before applying
- Great for boilerplate code
- Ask for explanations of error messages
- Generate test cases
- Combine with Sniprun to test AI-generated code
