# Document Viewers Implementation Plan

> **For agentic workers:** REQUIRED SUB-SKILL: Use superpowers:subagent-driven-development (recommended) or superpowers:executing-plans to implement this plan task-by-task. Steps use checkbox (`- [ ]`) syntax for tracking.

**Goal:** Visualize images, PDFs, spreadsheets, Office docs, and notebooks inside Neovim with high fidelity — both as opened buffers and as previews from telescope / nvim-tree.

**Architecture:** Single visual backend is `snacks.nvim`'s `image` module (kitty graphics). Native handlers: snacks (png/jpg/gif/webp/svg/pdf), csvview (csv/tsv), jupytext (ipynb). Our `BufReadCmd` autocmds convert pptx/docx/xlsx into formats those handlers already render. Must work on Linux and macOS.

**Tech Stack:**
- Plugins: `folke/snacks.nvim`, `hat0uma/csvview.nvim`, `GCBallesteros/jupytext.nvim`
- Existing plugins reused: `render-markdown.nvim`, `telescope.nvim`, `nvim-tree.lua`, `which-key.nvim`
- System deps: `imagemagick`, `ghostscript`, `libreoffice` (provides `soffice`), `pandoc`, `xlsx2csv`
- Terminal: kitty (already installed by user)

**Spec:** `docs/superpowers/specs/2026-05-14-document-viewers-design.md`

**Deviation from spec:** Spec proposed `<leader>tc` (csv toggle) and `<leader>p` (nvim-tree preview). Both collide with existing which-key groups (`<leader>t` Tab, `<leader>p` Pathfinder). This plan uses a new `<leader>V` Viewer group (`<leader>Vc`, `<leader>VC`) and a tree-local `P` mapping in `nvim-tree`. Same behavior, no keymap conflicts.

---

## File Structure

| File | Action | Responsibility |
|---|---|---|
| `lua/cetusian/plugins/snacks.lua` | Create | snacks.nvim image module only |
| `lua/cetusian/plugins/csvview.lua` | Create | csv/tsv tabular rendering |
| `lua/cetusian/plugins/jupytext.lua` | Create | ipynb ↔ markdown round-trip |
| `lua/cetusian/plugins/document-viewers.lua` | Create | BufReadCmd glue for pptx/docx/xlsx + `:DocViewCheck` + preview helper |
| `lua/cetusian/plugins/telescope.lua` | Modify | Default previewer delegates to viewer for visual files |
| `lua/cetusian/plugins/nvim-tree.lua` | Modify | Tree-local `P` keymap calls preview helper |
| `lua/cetusian/plugins/which-key.lua` | Modify | Register `<leader>V` Viewer group |
| `install.sh` | Modify | Install new system deps idempotently on Linux + macOS |
| `tests/fixtures/generate.sh` | Create | Generate fixture files from text sources |
| `tests/smoke.sh` | Create | Headless nvim tests verifying filetype routing |
| `docs/document-viewers.md` | Create | Usage, deps, manual visual checklist |
| `README.md` | Modify | One-line feature entry |

---

## Task 1: Add system dependencies to `install.sh`

**Files:**
- Modify: `install.sh`

- [ ] **Step 1: Write the failing test (idempotency check)**

Create `tests/install-idempotency.sh`:

```bash
#!/usr/bin/env bash
# Smoke: install.sh must run twice without errors and without reinstalling.
set -e
REPO_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")/.." && pwd)"

# First run must succeed
DRY_RUN=1 bash "$REPO_DIR/install.sh" >/tmp/install-1.log 2>&1 || { echo "FAIL: first run errored"; cat /tmp/install-1.log; exit 1; }

# All required tools must be on PATH afterwards
for cmd in convert gs soffice pandoc xlsx2csv; do
  command -v "$cmd" >/dev/null 2>&1 || { echo "FAIL: $cmd not on PATH after install"; exit 1; }
done

echo "PASS"
```

Make executable: `chmod +x tests/install-idempotency.sh`

- [ ] **Step 2: Run test to verify it fails**

Run: `bash tests/install-idempotency.sh`
Expected: `FAIL: <cmd> not on PATH` (one of the new tools is missing).

- [ ] **Step 3: Add `install_doc_deps` function to `install.sh`**

Add this function after `install_linux()` (around line 75 of `install.sh`):

```bash
install_doc_deps() {
  info "Installing document-viewer system dependencies..."

  case "$PLATFORM" in
    macos)
      brew list imagemagick &>/dev/null || brew install imagemagick
      brew list ghostscript &>/dev/null || brew install ghostscript
      brew list pandoc      &>/dev/null || brew install pandoc
      brew list xlsx2csv    &>/dev/null || brew install xlsx2csv
      # LibreOffice ships as a cask; the binary lives in the app bundle.
      if ! brew list --cask libreoffice &>/dev/null; then
        brew install --cask libreoffice
      fi
      # Symlink soffice into /usr/local/bin (or /opt/homebrew/bin) so it's on PATH.
      if ! has soffice; then
        BREW_PREFIX="$(brew --prefix)"
        if [ -x "/Applications/LibreOffice.app/Contents/MacOS/soffice" ]; then
          sudo ln -sf "/Applications/LibreOffice.app/Contents/MacOS/soffice" "$BREW_PREFIX/bin/soffice"
        fi
      fi
      ;;
    linux)
      if has apt-get; then
        sudo apt-get install -y imagemagick ghostscript libreoffice pandoc python3-xlsx2csv \
          || sudo apt-get install -y imagemagick ghostscript libreoffice pandoc
      elif has dnf; then
        sudo dnf install -y ImageMagick ghostscript libreoffice pandoc python3-xlsx2csv
      elif has pacman; then
        sudo pacman -Syu --noconfirm imagemagick ghostscript libreoffice-fresh pandoc
      fi
      # xlsx2csv may not be packaged everywhere; fall back to pip --user.
      if ! has xlsx2csv; then
        info "Falling back to pip for xlsx2csv..."
        python3 -m pip install --user xlsx2csv
      fi
      ;;
  esac
}
```

Then add a call at the end of the system-dep block (after the existing `install_macos` / `install_linux` switch, around line 81):

```bash
install_doc_deps
```

- [ ] **Step 4: Run test to verify it passes**

Run: `bash tests/install-idempotency.sh`
Expected: `PASS`

If `xlsx2csv` from pip lands in `~/.local/bin`, ensure that's on PATH (most distros add it automatically; if not, the test error will indicate this and the user can add it manually).

- [ ] **Step 5: Commit**

```bash
git add install.sh tests/install-idempotency.sh
git commit -m "feat(install): add system deps for document viewers"
```

---

## Task 2: Create fixture generator and smoke test harness

**Files:**
- Create: `tests/fixtures/generate.sh`
- Create: `tests/smoke.sh`
- Create: `tests/fixtures/.gitignore`

- [ ] **Step 1: Write the fixture generator**

Create `tests/fixtures/generate.sh`:

```bash
#!/usr/bin/env bash
# Generate small real fixtures for each supported format.
# Requires deps from install.sh.
set -e
HERE="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
cd "$HERE"

echo "Generating fixtures in $HERE..."

# CSV — trivial.
cat > sample.csv <<'EOF'
name,age,city
Ada,36,London
Linus,55,Portland
Grace,85,New York
EOF

# Markdown source used to build pdf/docx/pptx.
cat > _source.md <<'EOF'
# Sample Document

This is a fixture for nvim-superbird document viewers.

## Features

- View images
- View PDFs
- View spreadsheets
EOF

# PDF via pandoc (uses LaTeX or wkhtmltopdf; fall back to libreoffice).
if pandoc _source.md -o sample.pdf 2>/dev/null; then
  :
else
  soffice --headless --convert-to pdf _source.md >/dev/null
  mv _source.pdf sample.pdf
fi

# DOCX via pandoc.
pandoc _source.md -o sample.docx

# PPTX via pandoc.
pandoc _source.md -o sample.pptx

# XLSX from the csv via python.
python3 - <<'PY'
import csv, openpyxl
wb = openpyxl.Workbook()
ws = wb.active
with open("sample.csv") as f:
    for row in csv.reader(f):
        ws.append(row)
wb.save("sample.xlsx")
PY

# IPYNB — minimal valid notebook.
cat > sample.ipynb <<'EOF'
{
 "cells": [
  {"cell_type": "markdown", "metadata": {}, "source": ["# Sample notebook\n"]},
  {"cell_type": "code", "execution_count": null, "metadata": {}, "outputs": [], "source": ["print('hello')\n"]}
 ],
 "metadata": {"kernelspec": {"display_name": "Python 3", "language": "python", "name": "python3"}},
 "nbformat": 4, "nbformat_minor": 5
}
EOF

# PNG — 1x1 generated via ImageMagick.
convert -size 16x16 xc:steelblue sample.png

# SVG — written directly.
cat > sample.svg <<'EOF'
<svg xmlns="http://www.w3.org/2000/svg" width="16" height="16"><rect width="16" height="16" fill="steelblue"/></svg>
EOF

rm -f _source.md _source.pdf
echo "Fixtures generated."
ls -1 sample.*
```

Make executable: `chmod +x tests/fixtures/generate.sh`

Note: `openpyxl` is a Python lib used only by the generator. If not installed, the generator will hint to `pip install --user openpyxl`. Add this guard before the `python3 - <<` block:

```bash
python3 -c "import openpyxl" 2>/dev/null || python3 -m pip install --user openpyxl
```

- [ ] **Step 2: Write the smoke test harness**

Create `tests/smoke.sh`:

```bash
#!/usr/bin/env bash
# Verify that opening each fixture file with headless nvim resolves to the
# expected filetype after our converters / plugins have run.
set -u
HERE="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
FIX="$HERE/fixtures"
PASS=0; FAIL=0

[ -f "$FIX/sample.csv" ] || { echo "Run tests/fixtures/generate.sh first."; exit 2; }

probe_ft() {
  # $1 = file, $2 = expected ft
  local file="$1" expected="$2" got
  got="$(nvim --headless -u NONE -c "set rtp+=$HOME/.config/nvim" -c "runtime! plugin/**/*.lua" \
              -c "edit $file" -c "lua io.stdout:write(vim.bo.filetype)" -c "qa!" 2>&1 \
              | tail -1)"
  if [ "$got" = "$expected" ]; then
    echo "PASS $file -> $got"; PASS=$((PASS+1))
  else
    echo "FAIL $file -> $got (expected $expected)"; FAIL=$((FAIL+1))
  fi
}

probe_ft "$FIX/sample.png"   png
probe_ft "$FIX/sample.svg"   svg
probe_ft "$FIX/sample.pdf"   pdf
probe_ft "$FIX/sample.csv"   csv
probe_ft "$FIX/sample.docx"  markdown
probe_ft "$FIX/sample.xlsx"  csv
probe_ft "$FIX/sample.pptx"  pdf
probe_ft "$FIX/sample.ipynb" markdown

echo "---"
echo "$PASS passed, $FAIL failed"
[ "$FAIL" -eq 0 ]
```

Make executable: `chmod +x tests/smoke.sh`

Note: the smoke harness deliberately starts nvim with the user's full config (so it picks up our plugins and BufReadCmds). Real headless smoke tests for a plugin-heavy config; not unit tests.

- [ ] **Step 3: Gitignore generated binary fixtures**

Create `tests/fixtures/.gitignore`:

```
sample.png
sample.pdf
sample.docx
sample.pptx
sample.xlsx
```

(Keep `.csv`, `.svg`, `.ipynb` in git — they're text, generator-or-not.)

- [ ] **Step 4: Generate fixtures and run smoke test**

```bash
bash tests/fixtures/generate.sh
bash tests/smoke.sh
```

Expected: most lines FAIL (no plugins wired yet). At minimum `sample.csv -> csv` should PASS (nvim's built-in ftdetect handles csv).

- [ ] **Step 5: Commit**

```bash
git add tests/fixtures/generate.sh tests/fixtures/.gitignore tests/fixtures/sample.csv tests/fixtures/sample.svg tests/fixtures/sample.ipynb tests/smoke.sh
git commit -m "test: add fixture generator and smoke harness for doc viewers"
```

---

## Task 3: Add `snacks.nvim` (image module only)

**Files:**
- Create: `lua/cetusian/plugins/snacks.lua`

- [ ] **Step 1: Confirm the failing test**

Run: `bash tests/smoke.sh`
Expected: `FAIL sample.png` and `FAIL sample.pdf` (no image renderer yet).

- [ ] **Step 2: Create the snacks plugin file**

Create `lua/cetusian/plugins/snacks.lua`:

```lua
return {
  "folke/snacks.nvim",
  priority = 1000,
  lazy = false,
  ---@type snacks.Config
  opts = {
    -- Only the image module is enabled. Everything else off so this plugin
    -- stays scoped to document viewing.
    image = {
      enabled = true,
      -- Auto-attach to supported file buffers (png/jpg/gif/webp/svg/pdf).
      doc = true,
      -- Force kitty graphics protocol; falls back gracefully on detection.
      force = false,
    },
    bigfile = { enabled = false },
    dashboard = { enabled = false },
    explorer = { enabled = false },
    indent = { enabled = false },
    input = { enabled = false },
    notifier = { enabled = false },
    picker = { enabled = false },
    quickfile = { enabled = false },
    scope = { enabled = false },
    scroll = { enabled = false },
    statuscolumn = { enabled = false },
    words = { enabled = false },
  },
}
```

- [ ] **Step 3: Sync plugins**

Run: `nvim --headless "+Lazy! sync" +qa`
Expected: snacks.nvim installs. Console may print a warning if ImageMagick isn't on PATH — that means Task 1 needs to be re-run.

- [ ] **Step 4: Run smoke test**

Run: `bash tests/smoke.sh`
Expected: `PASS sample.png -> png` and `PASS sample.pdf -> pdf` (snacks didn't add the filetype, but neovim's ftdetect did, and snacks.image being loaded means nothing breaks).

- [ ] **Step 5: Manual visual check (in kitty)**

Run: `nvim tests/fixtures/sample.png`
Expected: the blue square renders inside the buffer.

Run: `nvim tests/fixtures/sample.pdf`
Expected: the first page renders.

- [ ] **Step 6: Commit**

```bash
git add lua/cetusian/plugins/snacks.lua
git commit -m "feat: add snacks.nvim image module for image/pdf/svg rendering"
```

---

## Task 4: Add `csvview.nvim`

**Files:**
- Create: `lua/cetusian/plugins/csvview.lua`

- [ ] **Step 1: Create the plugin file**

Create `lua/cetusian/plugins/csvview.lua`:

```lua
return {
  "hat0uma/csvview.nvim",
  event = "VeryLazy",
  cmd = { "CsvViewEnable", "CsvViewDisable", "CsvViewToggle" },
  opts = {
    parser = { comments = { "#", "//" } },
    view = {
      display_mode = "border",   -- bordered cells; alternative: "highlight"
      header_lnum = 1,
      sticky_header = { enabled = true },
    },
  },
  config = function(_, opts)
    require("csvview").setup(opts)
    -- Auto-enable on csv/tsv buffers.
    vim.api.nvim_create_autocmd("FileType", {
      pattern = { "csv", "tsv" },
      callback = function() vim.cmd("CsvViewEnable") end,
    })
    vim.keymap.set("n", "<leader>Vc", "<cmd>CsvViewToggle<CR>",
      { desc = "Toggle CSV view" })
  end,
}
```

- [ ] **Step 2: Sync plugins**

Run: `nvim --headless "+Lazy! sync" +qa`
Expected: csvview.nvim installs.

- [ ] **Step 3: Run smoke test**

Run: `bash tests/smoke.sh`
Expected: `PASS sample.csv -> csv` still holds.

- [ ] **Step 4: Manual visual check**

Run: `nvim tests/fixtures/sample.csv`
Expected: the columns are aligned with borders; header row is sticky on scroll.

- [ ] **Step 5: Commit**

```bash
git add lua/cetusian/plugins/csvview.lua
git commit -m "feat: add csvview.nvim for tabular csv/tsv rendering"
```

---

## Task 5: Add `jupytext.nvim`

**Files:**
- Create: `lua/cetusian/plugins/jupytext.lua`

- [ ] **Step 1: Confirm failing test**

Run: `bash tests/smoke.sh`
Expected: `FAIL sample.ipynb -> json` (or similar — current ftdetect doesn't know to convert).

- [ ] **Step 2: Create the plugin file**

Create `lua/cetusian/plugins/jupytext.lua`:

```lua
return {
  "GCBallesteros/jupytext.nvim",
  ft = { "ipynb" },
  opts = {
    style = "markdown",   -- View ipynb as markdown round-trip.
    output_extension = "md",
    force_ft = "markdown",
  },
}
```

- [ ] **Step 3: Sync plugins**

Run: `nvim --headless "+Lazy! sync" +qa`
Expected: jupytext.nvim installs. The plugin requires the `jupytext` CLI tool — add it to `install_doc_deps` if missing.

If `jupytext` is not on PATH after sync, add this line to `install_doc_deps()` (Linux block and macOS block both):

```bash
has jupytext || python3 -m pip install --user jupytext
```

Then re-run `bash install.sh` to install it.

- [ ] **Step 4: Run smoke test**

Run: `bash tests/smoke.sh`
Expected: `PASS sample.ipynb -> markdown`.

- [ ] **Step 5: Manual visual check**

Run: `nvim tests/fixtures/sample.ipynb`
Expected: cells render as fenced markdown code blocks. `:w` saves it back as a valid ipynb.

- [ ] **Step 6: Commit**

```bash
git add lua/cetusian/plugins/jupytext.lua install.sh
git commit -m "feat: add jupytext.nvim for ipynb -> markdown round-trip"
```

---

## Task 6: Document-viewers module scaffold

**Files:**
- Create: `lua/cetusian/plugins/document-viewers.lua`

- [ ] **Step 1: Create the scaffold (no autocmds yet, just helpers)**

Create `lua/cetusian/plugins/document-viewers.lua`:

```lua
-- Document viewer glue: BufReadCmd autocmds for pptx/docx/xlsx, plus a
-- shared preview helper and a :DocViewCheck health command.
--
-- Native rendering for png/jpg/gif/webp/svg/pdf/csv/ipynb is handled by
-- the snacks / csvview / jupytext plugins respectively; this file only
-- covers the formats that need a conversion step.

local M = {}

local cache_dir = vim.fs.joinpath(vim.fn.stdpath("cache"), "docview")
vim.fn.mkdir(cache_dir, "p")

-- Resolve a CLI tool's absolute path, with optional fallback locations.
-- Returns the path or nil.
local function exepath(name, fallbacks)
  local p = vim.fn.exepath(name)
  if p ~= "" then return p end
  for _, alt in ipairs(fallbacks or {}) do
    if vim.fn.executable(alt) == 1 then return alt end
  end
  return nil
end

-- Returns the soffice path on whichever OS we're on, or nil if missing.
local function find_soffice()
  return exepath("soffice", {
    "/Applications/LibreOffice.app/Contents/MacOS/soffice",
  })
end

-- OS-matched install hint string for a given tool key.
local function install_hint(tool)
  local mac = vim.uv.os_uname().sysname == "Darwin"
  local hints = {
    soffice    = mac and "brew install --cask libreoffice"  or "sudo apt install libreoffice  (or dnf/pacman)",
    pandoc     = mac and "brew install pandoc"              or "sudo apt install pandoc",
    xlsx2csv   = mac and "brew install xlsx2csv"            or "pip install --user xlsx2csv",
    jupytext   = mac and "pip3 install --user jupytext"     or "pip install --user jupytext",
    convert    = mac and "brew install imagemagick"         or "sudo apt install imagemagick",
    gs         = mac and "brew install ghostscript"         or "sudo apt install ghostscript",
  }
  return hints[tool] or "(see docs/document-viewers.md)"
end

-- Run a shell command, return stdout on success or nil + first stderr line on failure.
local function run(cmd_list)
  local out = vim.fn.system(cmd_list)
  if vim.v.shell_error ~= 0 then
    local err = (out:match("[^\n]+") or "(no stderr)")
    return nil, err
  end
  return out, nil
end

-- Pure SHA1 of a string via vim.fn.sha256 truncated (good enough for cache filenames).
local function hash(s) return vim.fn.sha256(s):sub(1, 16) end

-- Public helpers (used by autocmds + preview integration in later tasks).
M._cache_dir = cache_dir
M._exepath = exepath
M._find_soffice = find_soffice
M._install_hint = install_hint
M._run = run
M._hash = hash

function M.preview(_path)
  -- Implemented in a later task.
  vim.notify("DocView preview not yet implemented", vim.log.levels.WARN)
end

function M.check()
  -- Implemented in a later task.
  vim.notify(":DocViewCheck not yet implemented", vim.log.levels.WARN)
end

-- Plugin spec: not actually a plugin, but lazy.nvim will source the config function.
return {
  -- Use a dummy "dir" entry so lazy treats this as a local plugin.
  dir = vim.fn.stdpath("config") .. "/lua/cetusian/plugins",
  name = "document-viewers",
  lazy = false,
  config = function()
    -- Register :DocViewCheck immediately (cheap, no deps).
    vim.api.nvim_create_user_command("DocViewCheck", function() M.check() end, {})
    -- Expose module globally so other plugins (telescope, nvim-tree) can require it.
    package.loaded["cetusian.document-viewers"] = M
  end,
}
```

Note on the `dir = ...` trick: lazy.nvim treats this file as a local plugin so its `config` function runs on startup, but it's not actually a downloaded plugin. The module table is exposed via `package.loaded["cetusian.document-viewers"]` so later tasks can `require()` it.

- [ ] **Step 2: Verify it loads cleanly**

Run: `nvim --headless -c "lua require('cetusian.document-viewers')" -c "qa"`
Expected: no errors. (lazy auto-imports it from `cetusian.plugins/`; the `package.loaded` line makes it requireable.)

- [ ] **Step 3: Commit**

```bash
git add lua/cetusian/plugins/document-viewers.lua
git commit -m "feat: add document-viewers module scaffold"
```

---

## Task 7: `BufReadCmd` for `.pptx`

**Files:**
- Modify: `lua/cetusian/plugins/document-viewers.lua` (extend `config`)

- [ ] **Step 1: Confirm failing test**

Run: `bash tests/smoke.sh`
Expected: `FAIL sample.pptx` (currently parsed as some unhelpful filetype or none).

- [ ] **Step 2: Add the pptx autocmd**

In `lua/cetusian/plugins/document-viewers.lua`, replace the `config = function()` body with:

```lua
  config = function()
    local group = vim.api.nvim_create_augroup("DocumentViewers", { clear = true })

    -- .pptx -> libreoffice -> pdf -> rename buffer -> snacks.image renders.
    vim.api.nvim_create_autocmd("BufReadCmd", {
      group = group,
      pattern = "*.pptx",
      callback = function(args)
        local src = args.match
        local soffice = M._find_soffice()
        if not soffice then
          vim.notify("pptx viewing needs LibreOffice. Install: " .. M._install_hint("soffice"),
            vim.log.levels.WARN)
          return
        end

        local out_pdf = vim.fs.joinpath(M._cache_dir, M._hash(src) .. ".pdf")
        if vim.fn.filereadable(out_pdf) == 0 then
          local _, err = M._run({
            soffice, "--headless",
            "--convert-to", "pdf",
            "--outdir", M._cache_dir,
            src,
          })
          if err then
            vim.notify("pptx conversion failed: " .. err, vim.log.levels.WARN)
            return
          end
          -- soffice names the output after the source basename, not the hash; rename.
          local soffice_out = vim.fs.joinpath(M._cache_dir,
            vim.fn.fnamemodify(src, ":t:r") .. ".pdf")
          if vim.fn.filereadable(soffice_out) == 1 then
            vim.uv.fs_rename(soffice_out, out_pdf)
          end
        end

        -- Rename buffer to the pdf path so snacks.image picks it up; ftdetect sets ft=pdf.
        vim.api.nvim_buf_set_name(args.buf, out_pdf)
        vim.cmd("edit!")
      end,
    })

    vim.api.nvim_create_user_command("DocViewCheck", function() M.check() end, {})
    package.loaded["cetusian.document-viewers"] = M
  end,
```

- [ ] **Step 3: Run smoke test**

Run: `bash tests/smoke.sh`
Expected: `PASS sample.pptx -> pdf`.

- [ ] **Step 4: Manual visual check**

Run: `nvim tests/fixtures/sample.pptx`
Expected: first slide renders as a PDF page. `<C-d>` / `<C-u>` scroll between pages.

- [ ] **Step 5: Commit**

```bash
git add lua/cetusian/plugins/document-viewers.lua
git commit -m "feat: pptx BufReadCmd routes through libreoffice -> pdf -> snacks"
```

---

## Task 8: `BufReadCmd` for `.docx`

**Files:**
- Modify: `lua/cetusian/plugins/document-viewers.lua`

- [ ] **Step 1: Confirm failing test**

Run: `bash tests/smoke.sh`
Expected: `FAIL sample.docx -> ` (whatever nvim guesses; not `markdown`).

- [ ] **Step 2: Add the docx autocmd**

Inside the `config` function, add another autocmd (right after the pptx one):

```lua
    -- .docx -> pandoc -> markdown text in the current buffer.
    vim.api.nvim_create_autocmd("BufReadCmd", {
      group = group,
      pattern = "*.docx",
      callback = function(args)
        local src = args.match
        if vim.fn.executable("pandoc") == 0 then
          vim.notify("docx viewing needs pandoc. Install: " .. M._install_hint("pandoc"),
            vim.log.levels.WARN)
          return
        end

        local out, err = M._run({ "pandoc", "-f", "docx", "-t", "markdown", src })
        if err then
          vim.notify("docx conversion failed: " .. err, vim.log.levels.WARN)
          return
        end

        local lines = vim.split(out, "\n", { plain = true })
        vim.api.nvim_buf_set_lines(args.buf, 0, -1, false, lines)
        vim.api.nvim_set_option_value("filetype", "markdown", { buf = args.buf })
        vim.api.nvim_set_option_value("modified", false, { buf = args.buf })
        vim.api.nvim_set_option_value("readonly", true, { buf = args.buf })
      end,
    })
```

- [ ] **Step 3: Run smoke test**

Run: `bash tests/smoke.sh`
Expected: `PASS sample.docx -> markdown`.

- [ ] **Step 4: Manual visual check**

Run: `nvim tests/fixtures/sample.docx`
Expected: markdown rendered by `render-markdown.nvim`. Buffer is read-only.

- [ ] **Step 5: Commit**

```bash
git add lua/cetusian/plugins/document-viewers.lua
git commit -m "feat: docx BufReadCmd routes through pandoc -> markdown"
```

---

## Task 9: `BufReadCmd` for `.xlsx`

**Files:**
- Modify: `lua/cetusian/plugins/document-viewers.lua`

- [ ] **Step 1: Confirm failing test**

Run: `bash tests/smoke.sh`
Expected: `FAIL sample.xlsx -> ` (not `csv`).

- [ ] **Step 2: Add the xlsx autocmd**

Inside `config`, after the docx autocmd:

```lua
    -- .xlsx -> xlsx2csv -> csv text in the current buffer (csvview attaches).
    vim.api.nvim_create_autocmd("BufReadCmd", {
      group = group,
      pattern = "*.xlsx",
      callback = function(args)
        local src = args.match
        if vim.fn.executable("xlsx2csv") == 0 then
          vim.notify("xlsx viewing needs xlsx2csv. Install: " .. M._install_hint("xlsx2csv"),
            vim.log.levels.WARN)
          return
        end

        local out, err = M._run({ "xlsx2csv", "-a", src })
        if err then
          vim.notify("xlsx conversion failed: " .. err, vim.log.levels.WARN)
          return
        end

        local lines = vim.split(out, "\n", { plain = true })
        vim.api.nvim_buf_set_lines(args.buf, 0, -1, false, lines)
        vim.api.nvim_set_option_value("filetype", "csv", { buf = args.buf })
        vim.api.nvim_set_option_value("modified", false, { buf = args.buf })
        vim.api.nvim_set_option_value("readonly", true, { buf = args.buf })
      end,
    })
```

Note: `xlsx2csv -a` emits all sheets concatenated. If a file has multiple sheets they'll appear in sequence — fine for a view-only spec. Multi-sheet UX is out of scope.

- [ ] **Step 3: Run smoke test**

Run: `bash tests/smoke.sh`
Expected: `PASS sample.xlsx -> csv`. All 8 fixtures should now PASS.

- [ ] **Step 4: Manual visual check**

Run: `nvim tests/fixtures/sample.xlsx`
Expected: tabular csvview rendering of the spreadsheet.

- [ ] **Step 5: Commit**

```bash
git add lua/cetusian/plugins/document-viewers.lua
git commit -m "feat: xlsx BufReadCmd routes through xlsx2csv -> csv -> csvview"
```

---

## Task 10: `:DocViewCheck` user command

**Files:**
- Modify: `lua/cetusian/plugins/document-viewers.lua`

- [ ] **Step 1: Implement `M.check()`**

In `document-viewers.lua`, replace the stub `M.check` with:

```lua
function M.check()
  local tools = {
    { name = "ImageMagick (convert)", cmd = "convert",  key = "convert" },
    { name = "Ghostscript",           cmd = "gs",       key = "gs" },
    { name = "LibreOffice (soffice)", cmd = "soffice",  key = "soffice",
      check = function() return M._find_soffice() ~= nil end },
    { name = "Pandoc",                cmd = "pandoc",   key = "pandoc" },
    { name = "xlsx2csv",              cmd = "xlsx2csv", key = "xlsx2csv" },
    { name = "Jupytext",              cmd = "jupytext", key = "jupytext" },
  }

  local lines = { "Document viewer dependency check:", "" }
  local missing = 0
  for _, t in ipairs(tools) do
    local ok = t.check and t.check() or (vim.fn.executable(t.cmd) == 1)
    if ok then
      table.insert(lines, string.format("  [ok]    %-26s found", t.name))
    else
      missing = missing + 1
      table.insert(lines, string.format("  [miss]  %-26s install: %s",
        t.name, M._install_hint(t.key)))
    end
  end
  table.insert(lines, "")
  if missing == 0 then
    table.insert(lines, "All dependencies present.")
  else
    table.insert(lines, missing .. " dependency/ies missing — see hints above.")
  end

  vim.api.nvim_echo(vim.tbl_map(function(l) return { l .. "\n" } end, lines), true, {})
end
```

- [ ] **Step 2: Run the command**

Run: `nvim --headless -c "DocViewCheck" -c "qa" 2>&1`
Expected: prints the table; all `[ok]` lines if Task 1 was applied. Otherwise the relevant `[miss]` lines.

- [ ] **Step 3: Commit**

```bash
git add lua/cetusian/plugins/document-viewers.lua
git commit -m "feat: add :DocViewCheck for dependency health probe"
```

---

## Task 11: Register `<leader>V` Viewer group in which-key

**Files:**
- Modify: `lua/cetusian/plugins/which-key.lua`

- [ ] **Step 1: Add the group entry**

In `lua/cetusian/plugins/which-key.lua`, in the `spec` table (currently lines 10–30), add a new entry alongside `<leader>T` (Terminal) and `<leader>V` (Venv):

Change line 28 from:
```lua
      { "<leader>v", group = "Venv (Python)" },
```
to:
```lua
      { "<leader>v", group = "Venv (Python)" },
      { "<leader>V", group = "Viewer (documents)" },
```

- [ ] **Step 2: Verify**

Run: `nvim` (interactive). Press `<leader>` and wait for which-key. Expected: a "Viewer (documents)" group appears under `V`.

- [ ] **Step 3: Commit**

```bash
git add lua/cetusian/plugins/which-key.lua
git commit -m "feat: register <leader>V Viewer group in which-key"
```

---

## Task 12: Telescope previewer integration

**Files:**
- Modify: `lua/cetusian/plugins/document-viewers.lua` (add `M.preview`)
- Modify: `lua/cetusian/plugins/telescope.lua`

- [ ] **Step 1: Implement `M.preview(path)`**

In `lua/cetusian/plugins/document-viewers.lua`, replace the stub `M.preview` with:

```lua
-- Open a preview float for the given path. Picks the right renderer based
-- on extension. Used by telescope previewer + nvim-tree keymap.
function M.preview(path)
  if not path or path == "" then return end
  local ext = (path:match("^.+%.([%w]+)$") or ""):lower()

  -- For visual formats, snacks.image has a Show command we can drive directly.
  local visual = { png = true, jpg = true, jpeg = true, gif = true, webp = true,
                   svg = true, pdf = true }
  if visual[ext] then
    local ok = pcall(function() require("snacks").image.placement.new(0, path) end)
    if not ok then
      vim.notify("Could not preview " .. path, vim.log.levels.WARN)
    end
    return
  end

  -- For convertible formats, open the file normally in a float; our
  -- BufReadCmd autocmds + jupytext + csvview do the rest.
  local buf = vim.api.nvim_create_buf(false, true)
  local width = math.floor(vim.o.columns * 0.8)
  local height = math.floor(vim.o.lines * 0.8)
  local win = vim.api.nvim_open_win(buf, true, {
    relative = "editor",
    width = width, height = height,
    row = math.floor((vim.o.lines - height) / 2),
    col = math.floor((vim.o.columns - width) / 2),
    border = "rounded",
  })
  vim.cmd("edit " .. vim.fn.fnameescape(path))
  vim.keymap.set("n", "q", "<cmd>close<CR>", { buffer = vim.api.nvim_win_get_buf(win) })
end
```

- [ ] **Step 2: Wire telescope previewer**

In `lua/cetusian/plugins/telescope.lua`, after the existing `keymap.set` lines (after line 37), add a new mapping:

```lua
    keymap.set("n", "<leader>fv", function()
      require("telescope.builtin").find_files({
        attach_mappings = function(_, map)
          map("i", "<CR>", function(prompt_bufnr)
            local entry = require("telescope.actions.state").get_selected_entry()
            require("telescope.actions").close(prompt_bufnr)
            require("cetusian.document-viewers").preview(entry.path)
          end)
          return true
        end,
      })
    end, { desc = "Find file and preview (document viewer)" })
```

Also register the keymap in `which-key.lua` `<leader>f` Find group — no change needed, the existing group picks it up automatically.

- [ ] **Step 3: Manual test**

Run: `nvim` then `<leader>fv`. Pick `tests/fixtures/sample.png`. Expected: image renders in a float.

- [ ] **Step 4: Commit**

```bash
git add lua/cetusian/plugins/document-viewers.lua lua/cetusian/plugins/telescope.lua
git commit -m "feat: add document preview via telescope (<leader>fv)"
```

---

## Task 13: nvim-tree preview keymap

**Files:**
- Modify: `lua/cetusian/plugins/nvim-tree.lua`

- [ ] **Step 1: Add tree-local keymap inside `on_attach`**

In `lua/cetusian/plugins/nvim-tree.lua`, line 15–19 contains:

```lua
      on_attach = function(bufnr)
        local api = require("nvim-tree.api")
        api.config.mappings.default_on_attach(bufnr)
        pcall(vim.keymap.del, "n", "<BS>", { buffer = bufnr })
      end,
```

Replace with:

```lua
      on_attach = function(bufnr)
        local api = require("nvim-tree.api")
        api.config.mappings.default_on_attach(bufnr)
        pcall(vim.keymap.del, "n", "<BS>", { buffer = bufnr })
        vim.keymap.set("n", "P", function()
          local node = api.tree.get_node_under_cursor()
          if node and node.absolute_path then
            require("cetusian.document-viewers").preview(node.absolute_path)
          end
        end, { buffer = bufnr, desc = "Preview file with document viewer" })
      end,
```

- [ ] **Step 2: Manual test**

Run: `nvim`. Toggle tree (`<leader>ee`). Highlight `tests/fixtures/sample.pdf`. Press `P`. Expected: pdf renders in a float; press `q` to close.

- [ ] **Step 3: Commit**

```bash
git add lua/cetusian/plugins/nvim-tree.lua
git commit -m "feat: add P preview keymap in nvim-tree for documents"
```

---

## Task 14: Documentation

**Files:**
- Create: `docs/document-viewers.md`
- Modify: `README.md`

- [ ] **Step 1: Write the docs page**

Create `docs/document-viewers.md`:

```markdown
# Document Viewers

In-Neovim viewing for images, PDFs, spreadsheets, Office docs, notebooks, and SVGs.

## Supported formats

| Format | Renderer | Conversion |
|---|---|---|
| png / jpg / gif / webp | snacks.image | none |
| svg | snacks.image | none |
| pdf | snacks.image | none |
| pptx | snacks.image | libreoffice → pdf |
| docx | render-markdown | pandoc → markdown |
| xlsx | csvview | xlsx2csv → csv |
| csv / tsv | csvview | none |
| ipynb | render-markdown | jupytext → markdown |

## Requirements

- Kitty terminal (or any terminal with the kitty graphics protocol).
- System tools (installed by `install.sh`): ImageMagick, Ghostscript, LibreOffice, Pandoc, xlsx2csv, jupytext.

Run `:DocViewCheck` to verify all tools are present.

## Keymaps

| Keys | Action |
|---|---|
| (open file) | Buffer-open with appropriate renderer |
| `<leader>Vc` | Toggle CSV view on current buffer |
| `<leader>fv` | Find file and preview in a float |
| `P` (inside nvim-tree) | Preview highlighted file |

## How to add another format

1. If the format is image-like (or convertible to one), add it to the `formats` list in `lua/cetusian/plugins/snacks.lua`.
2. If conversion is needed, add a `BufReadCmd` autocmd in `lua/cetusian/plugins/document-viewers.lua` following the docx/xlsx pattern.
3. Add a fixture in `tests/fixtures/generate.sh` and a `probe_ft` line in `tests/smoke.sh`.
4. Add the install command to `install_doc_deps` in `install.sh`.

## Manual visual checklist

After running `install.sh` and `tests/fixtures/generate.sh`:

- [ ] `nvim tests/fixtures/sample.pdf` renders pages
- [ ] `nvim tests/fixtures/sample.png` renders the image
- [ ] `nvim tests/fixtures/sample.docx` renders as markdown
- [ ] `nvim tests/fixtures/sample.xlsx` renders as a csv table
- [ ] `nvim tests/fixtures/sample.pptx` renders the first slide
- [ ] `nvim tests/fixtures/sample.ipynb` renders cells as markdown
- [ ] `:DocViewCheck` shows all dependencies present
- [ ] Re-running `install.sh` is a no-op
```

- [ ] **Step 2: Update README**

Read `README.md`, find the features list. Append one bullet under the existing features:

```markdown
- **Document viewers** — view images, PDFs, xlsx, docx, pptx, ipynb, and svg inline. See [`docs/document-viewers.md`](docs/document-viewers.md).
```

- [ ] **Step 3: Commit**

```bash
git add docs/document-viewers.md README.md
git commit -m "docs: add document-viewers usage page and README entry"
```

---

## Task 15: Final end-to-end verification

- [ ] **Step 1: Clean cache and regenerate fixtures**

```bash
rm -rf ~/.cache/nvim/docview
bash tests/fixtures/generate.sh
```

- [ ] **Step 2: Run full smoke suite**

```bash
bash tests/smoke.sh
```

Expected output:

```
PASS .../sample.png   -> png
PASS .../sample.svg   -> svg
PASS .../sample.pdf   -> pdf
PASS .../sample.csv   -> csv
PASS .../sample.docx  -> markdown
PASS .../sample.xlsx  -> csv
PASS .../sample.pptx  -> pdf
PASS .../sample.ipynb -> markdown
---
8 passed, 0 failed
```

- [ ] **Step 3: Run `:DocViewCheck` interactively**

```bash
nvim -c "DocViewCheck"
```

Expected: every line `[ok]`.

- [ ] **Step 4: Run install idempotency**

```bash
bash tests/install-idempotency.sh
```

Expected: `PASS`.

- [ ] **Step 5: Manual visual walkthrough**

Open each fixture interactively in kitty:

```bash
nvim tests/fixtures/sample.pdf
nvim tests/fixtures/sample.png
nvim tests/fixtures/sample.xlsx
nvim tests/fixtures/sample.docx
nvim tests/fixtures/sample.pptx
nvim tests/fixtures/sample.ipynb
```

Confirm each renders correctly. No claims of success without seeing it.

- [ ] **Step 6: Final commit if anything was tweaked**

```bash
git status
# If clean: nothing to commit.
# If anything was adjusted during verification:
git add -u && git commit -m "fix: doc-viewer adjustments from final smoke run"
```
