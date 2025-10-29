# First Things to Try - Hands-On Guide

This guide shows you **exactly what to do** to use each plugin. Follow along step-by-step!

Leader key is `<Space>` - Press spacebar for most commands.

---

## 🎯 1. COQ Completion (Auto-Completions)

**What it does:** Shows suggestions as you type

**Try it now:**
```bash
nvim test.lua
```

In insert mode (`i`), type:
```lua
vim.
```

**What happens:**
- Popup appears with `vim.api`, `vim.fn`, `vim.lsp`
- Press `<Tab>` to select next item
- Press `<CR>` (Enter) to accept

**Keep typing:** Try these:
```lua
local function hello()
  print("
```
You'll see string completions!

**Keys to remember:**
- `<Tab>` - Next suggestion
- `<Shift-Tab>` - Previous suggestion
- `<CR>` - Accept
- `<C-Space>` - Force show completions

---

## 🚀 2. Luxmotion (Fast Navigation)

**What it does:** Jump to any word instantly

**Try it now:**
1. Open any file with lots of text
2. In normal mode, press `s`
3. Type the first letter of a word you see

**What happens:**
- All matching words get labeled (like 'a', 'b', 'c')
- Type the label to jump there instantly!

**Example:**
```
Press: s
Type: f  (to find words starting with 'f')
See: Labels appear on 'function', 'for', 'from'
Type: a  (to jump to the one labeled 'a')
```

**Keys:**
- `s` - Jump forward
- `S` - Jump backward

**Use it for:**
- Jumping to function names
- Moving cursor across long lines
- Quick navigation without counting

---

## 💻 3. Terminal (Luxterm)

**What it does:** Open terminal inside Neovim

**Try it now:**
1. Press `<Space>` then `lt` (LuxTerm)
2. You'll see a terminal at the bottom!
3. Type commands: `ls`, `git status`, etc.

**What happens:**
- Terminal opens in split
- You can run any shell command
- Press `<Space>lt` again to close it

**More options:**
- `<Space>lv` - Terminal in vertical split (side-by-side)
- `<Space>lh` - Terminal in horizontal split

**Use it for:**
- Running build commands: `npm run build`
- Git operations: `git add .`, `git commit`
- Quick shell commands without leaving editor

---

## 🎈 4. Floating Terminal (Floatty)

**What it does:** Popup terminal window

**Try it now:**
1. Press `<Space>` then `ft` (Floatty)
2. A centered terminal appears!
3. Run: `ls -la`

**Keys:**
- `<Space>ft` - Toggle floating terminal
- `<Space>fn` - New floating terminal
- `<C-\><C-n>` - Exit terminal mode (to move around)

**Difference from Luxterm:**
- **Luxterm:** Persistent split at bottom
- **Floatty:** Floating overlay, quick commands

**Use it for:**
- One-off commands
- Checking file contents quickly
- Running scripts without changing layout

---

## 🐙 5. GitHub Integration (Octo)

**What it does:** Manage GitHub issues/PRs in Neovim

**Try it now:**
1. Navigate to a git repo
2. Press `<Space>` then `go` (GitHub Octo)
3. See the Octo menu!

**Try these:**
- `<Space>goi` - List issues
- `<Space>gop` - List pull requests
- `<Space>gor` - View repo info

**Commands to try:**
```vim
:Octo issue list
:Octo pr list
:Octo pr checkout 123  " Checkout PR #123
```

**Prerequisites:**
- Must run `gh auth login` first
- Must be in a git repository

**Use it for:**
- Reviewing PRs without browser
- Creating issues from code
- Commenting on PRs

---

## 🐛 6. Debugging (DAP)

**What it does:** Full debugging with breakpoints

**Try it now (JavaScript example):**
1. Create `test.js`:
```javascript
function add(a, b) {
  const result = a + b;
  return result;
}
console.log(add(5, 3));
```

2. Open it: `nvim test.js`
3. Put cursor on line 2 (`const result = a + b;`)
4. Press `<Space>db` - Breakpoint set! (you'll see a red dot)
5. Press `<Space>dc` - Start debugging

**Debug keys:**
- `<Space>db` - Toggle breakpoint (red dot)
- `<Space>dc` - Continue/Start
- `<Space>di` - Step into function
- `<Space>do` - Step over line
- `<Space>du` - Toggle debug UI (see variables)

**What you'll see:**
- Variables panel on the left
- Call stack
- Breakpoints list
- REPL console

**Use it for:**
- Finding bugs
- Understanding code flow
- Inspecting variable values

---

## ⚡ 7. Sniprun (Run Code Instantly)

**What it does:** Execute code without saving file

**Try it now:**
1. Create any file: `nvim test.py`
2. Type in insert mode:
```python
print("Hello from Sniprun!")
print(2 + 2)
```

3. Press `<Esc>` to normal mode
4. Put cursor on line 1
5. Press `<Space>rs` (Run Snippet)

**What happens:**
- Code executes instantly!
- Result appears in floating window or virtual text
- You see: `Hello from Sniprun!` and `4`

**Try visual mode:**
1. Select multiple lines (press `V`, move down)
2. Press `<Space>rs`
3. All selected code runs!

**Keys:**
- `<Space>rs` - Run current line/selection
- `<Space>rl` - Live mode (runs as you type!)
- `<Space>rc` - Close output
- `<Space>rr` - Reset Sniprun

**Try live mode:**
```vim
# Press <Space>rl to enable live mode
# Now type Python code - it runs automatically!
print("This runs as I type!")
```

**Works with:** Python, JavaScript, Lua, Ruby, Go, Rust, Java, C++, and more!

---

## 🧪 8. Jest Testing (Jester)

**What it does:** Run JavaScript/TypeScript tests

**Try it now:**
1. Create `example.test.js`:
```javascript
describe('Math', () => {
  it('should add numbers', () => {
    expect(1 + 1).toBe(2);
  });

  it('should multiply numbers', () => {
    expect(2 * 3).toBe(6);
  });
});
```

2. Open it: `nvim example.test.js`
3. Put cursor inside first test
4. Press `<Space>jr` (Jest Run)

**What happens:**
- Only that specific test runs!
- Results appear in terminal
- See pass/fail status

**Keys:**
- `<Space>jr` - Run test under cursor
- `<Space>jf` - Run all tests in file
- `<Space>jl` - Run last test again
- `<Space>jd` - Debug test under cursor

**Use it for:**
- TDD (Test-Driven Development)
- Running single tests quickly
- Debugging failing tests

---

## 📝 9. Markdown Preview (Glow)

**What it does:** Beautiful markdown rendering

**Try it now:**
1. Create `README.md`:
```markdown
# My Project

This is **bold** and this is *italic*.

## Features
- Fast
- Simple
- Beautiful

```python
def hello():
    print("Code blocks work!")
```
```

2. Open it: `nvim README.md`
3. Press `<Space>mp` (Markdown Preview)

**What happens:**
- Floating window appears
- Markdown rendered beautifully
- Syntax highlighting in code blocks
- Proper formatting for headers, lists, etc.

**Keys:**
- `<Space>mp` - Toggle preview
- `q` - Close preview window

**Use it for:**
- Writing READMEs
- Documentation
- Note-taking
- Blog posts

---

## 🤖 10. AI Assistant (Avante)

**What it does:** AI coding help with Claude

**Prerequisites:** Set API key first:
```bash
export ANTHROPIC_API_KEY="sk-ant-xxxxx"
```

**Try it now:**

**1. Ask a question:**
1. Open any file
2. Press `<Space>aa` (Ask AI)
3. Type: "How do I read a file in Python?"
4. Press Enter

**What happens:**
- AI sidebar appears
- Claude answers your question
- Shows code examples!

**2. Edit code with AI:**
1. Write some messy code:
```python
def f(x,y,z):
    r=x+y+z
    return r
```

2. Select it (press `V`, move down)
3. Press `<Space>ae` (AI Edit)
4. Type: "Make this more readable with better names"
5. Press Enter

**What happens:**
- AI refactors your code
- Shows suggestions
- You can accept or reject

**Keys:**
- `<Space>aa` - Ask AI anything
- `<Space>ae` - Edit selection with AI
- `<Space>at` - Toggle AI sidebar
- `<Space>ar` - Refresh response

**Try asking:**
- "Explain this function"
- "Write a function to parse JSON"
- "Add error handling to this code"
- "Write tests for this function"

---

## 🐍 11. Python Virtual Environments (Swenv)

**What it does:** Switch Python environments

**Setup first:**
```bash
python -m venv ~/.virtualenvs/myproject
```

**Try it now:**
1. Open a Python file: `nvim test.py`
2. Press `<Space>ve` (Venv picker)
3. Select your environment

**What happens:**
- LSP restarts with new environment
- Completions use correct packages
- Imports work correctly

**Keys:**
- `<Space>ve` - Pick environment
- `<Space>vc` - Show current environment

**Use it for:**
- Switching between projects
- Testing different Python versions
- Project-specific dependencies

---

## 🔍 12. JSON Query (JQX)

**What it does:** Query and explore JSON files

**Try it now:**
1. Create `data.json`:
```json
{
  "users": [
    {"name": "Alice", "age": 30, "active": true},
    {"name": "Bob", "age": 25, "active": false},
    {"name": "Charlie", "age": 35, "active": true}
  ],
  "total": 3
}
```

2. Open it: `nvim data.json`
3. Press `<Space>jq` (JQX Query)
4. Type: `.users[] | select(.active == true)`

**What happens:**
- Shows only active users!
- Results in new buffer
- Formatted nicely

**Try these queries:**
- `.users[0]` - First user
- `.users[] | .name` - All names
- `.users | length` - Count users
- `.users[] | select(.age > 30)` - Filter by age

**Keys:**
- `<Space>jq` - Open query list
- `<Space>jx` - Execute custom query

**Use it for:**
- API responses
- Large JSON files
- Data exploration
- Configuration files

---

## 🗺️ 13. Path Navigation (Pathfinder)

**What it does:** Find and copy file paths

**Try it now:**
1. Open any file in your project
2. Press `<Space>pf` (Pathfinder Find)

**What happens:**
- Shows full path to current file
- Easy to see where you are!

**Try these:**
- `<Space>pf` - Show current file path
- `<Space>pc` - Copy path to clipboard
- `<Space>pd` - Navigate to directory

**Use it for:**
- Sharing file locations
- Build scripts
- Documentation
- Finding where files are

---

## 📡 14. TMUX Integration

**What it does:** Navigate between Neovim and TMUX panes

**Prerequisites:** Must be inside a TMUX session

**Try it now:**
1. Start TMUX: `tmux`
2. Split pane: `Ctrl-b %` (vertical split)
3. Open Neovim in one pane
4. Press `<C-h>`, `<C-j>`, `<C-k>`, `<C-l>` to move between panes!

**Keys:**
- `<C-h>` - Move left
- `<C-j>` - Move down
- `<C-k>` - Move up
- `<C-l>` - Move right

**What happens:**
- Same keys work in Neovim AND TMUX
- Seamless navigation!

**Use it for:**
- Multi-pane development
- Running servers in TMUX
- Terminal + editor workflow

---

## 🎨 15. Smear Cursor

**What it does:** Smooth cursor animation

**Try it now:**
1. Open any file
2. Press `j` or `k` to move cursor up/down
3. Watch the cursor smoothly glide!

**Try more:**
- Press `s` and jump with Luxmotion
- Use `gg` to jump to top
- Use `G` to jump to bottom

**What happens:**
- Cursor leaves a "smear" trail
- Easy to track cursor movement
- Looks cool!

**No keys needed - it just works!**

---

## 🎯 Quick LSP Features (Built-in)

These work automatically with language servers:

**Try these:**
1. Open a code file: `nvim test.lua`
2. Type some code:
```lua
local function hello(name)
  print("Hello, " .. name)
end
```

3. Try these keys:

**Navigation:**
- Put cursor on `hello`, press `gd` - Go to Definition
- Press `gD` - Go to Declaration
- Press `gr` - Show References

**Information:**
- Put cursor on `print`, press `K` - Show Documentation
- Press `<Space>d` - Show line diagnostics (errors)

**Actions:**
- Press `<Space>ca` - Code Actions (fixes)
- Press `<Space>rn` - Rename symbol

**Diagnostics:**
- Press `]d` - Next error
- Press `[d` - Previous error
- Press `<Space>D` - List all errors

---

## 📚 Core Neovim Shortcuts

**Basic movement:**
- `h` `j` `k` `l` - Left, Down, Up, Right
- `w` - Next word
- `b` - Previous word
- `0` - Start of line
- `$` - End of line
- `gg` - Top of file
- `G` - Bottom of file

**Editing:**
- `i` - Insert mode (start typing)
- `a` - Append (insert after cursor)
- `o` - New line below
- `O` - New line above
- `<Esc>` or `jk` - Exit insert mode
- `u` - Undo
- `<C-r>` - Redo

**Visual mode:**
- `v` - Visual mode (select characters)
- `V` - Visual line mode (select lines)
- `y` - Yank (copy)
- `d` - Delete
- `p` - Paste

**Files:**
- `<Space>sv` - Split vertical
- `<Space>sh` - Split horizontal
- `<Space>sx` - Close split
- `<Space>to` - New tab
- `<Space>tx` - Close tab

---

## 🎯 Practice Workflow

Here's a complete workflow to practice everything:

**1. Start a new project:**
```bash
mkdir myproject
cd myproject
nvim main.py
```

**2. Write code with completions:**
```python
def calculate_total(items):
    total = 0
    for item in items:
        total += item['price']
    return total
```
(Watch COQ suggest completions as you type!)

**3. Navigate with Luxmotion:**
- Press `s` + `c` to jump to `calculate`
- Press `s` + `r` to jump to `return`

**4. Run the code:**
- Select all lines (`ggVG`)
- Press `<Space>rs` (Sniprun)

**5. Open terminal:**
- Press `<Space>lt`
- Type: `git init`

**6. Ask AI for help:**
- Select the function
- Press `<Space>ae`
- Type: "Add error handling"

**7. Preview documentation:**
- Create `README.md`
- Write some markdown
- Press `<Space>mp`

---

## 🎓 Learning Path

**Day 1 - Basics:**
1. Use COQ completions while coding
2. Try Luxmotion (`s`) for navigation
3. Open terminal with `<Space>lt`
4. Use `gd` to jump to definitions

**Day 2 - Testing:**
1. Run code with Sniprun (`<Space>rs`)
2. Try Jest for tests (`<Space>jr`)
3. Set a breakpoint (`<Space>db`)
4. Start debugging (`<Space>dc`)

**Day 3 - Productivity:**
1. Ask AI questions (`<Space>aa`)
2. Preview markdown (`<Space>mp`)
3. Query JSON files (`<Space>jq`)
4. Use floating terminal (`<Space>ft`)

**Week 2 - Advanced:**
1. GitHub integration (`<Space>go`)
2. Python environments (`<Space>ve`)
3. TMUX navigation (`<C-hjkl>`)
4. Master all LSP features

---

## 💡 Pro Tips

**1. Most used combos:**
- `s` + letter = Fast jump to anywhere
- `<Space>lt` = Quick terminal
- `<Space>rs` = Run code instantly
- `gd` = Jump to definition
- `K` = Show docs

**2. Muscle memory builders:**
- Practice `s` for navigation daily
- Use `<Space>lt` instead of Alt+Tab to terminal
- Use `<Space>rs` to test code snippets
- Use `gd` and `K` constantly

**3. Efficiency tricks:**
- Visual select + `<Space>rs` = Run selection
- `<Space>ae` on messy code = AI cleanup
- `<Space>jq` on JSON = Explore structure
- `<Space>db` + `<Space>dc` = Debug anything

---

## ✅ Checklist - Try Everything!

Go through this list and check off what you've tried:

- [ ] See completions appear (COQ)
- [ ] Jump with `s` (Luxmotion)
- [ ] Open terminal `<Space>lt`
- [ ] Open floating terminal `<Space>ft`
- [ ] Run code `<Space>rs`
- [ ] Set breakpoint `<Space>db`
- [ ] Ask AI `<Space>aa`
- [ ] Preview markdown `<Space>mp`
- [ ] Query JSON `<Space>jq`
- [ ] Use `gd` to jump
- [ ] Use `K` for docs
- [ ] Run a test `<Space>jr`
- [ ] GitHub issues `<Space>goi`
- [ ] Copy path `<Space>pc`
- [ ] Switch Python env `<Space>ve`

**Once you've checked them all, you're a Neovim Superbird master! 🚀**
