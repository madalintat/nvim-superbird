# Document Viewers in nvim-superbird

**Date:** 2026-05-14
**Status:** Approved design, ready for implementation plan

## Goal

Visualize images, PDFs, spreadsheets, Office docs, notebooks, and SVGs *inside* Neovim with high fidelity (true images, not ASCII), in two workflows:

1. **Buffer-open** — `nvim file.{pdf,xlsx,docx,pptx,ipynb,png,svg,...}` renders the file in place.
2. **Preview** — from telescope and `nvim-tree`, preview the same file types without opening them as buffers.

View-only. No editing of office formats.

Must work on **both Linux and macOS**. No platform-only behavior.

## Supported formats

| Format | Renderer | Conversion (if any) |
|---|---|---|
| `.png .jpg .jpeg .gif .webp` | snacks.image | none |
| `.svg` | snacks.image | none |
| `.pdf` | snacks.image | none (paged render) |
| `.pptx` | snacks.image | libreoffice → pdf |
| `.docx` | render-markdown | pandoc → markdown |
| `.xlsx` | csvview | xlsx2csv → csv |
| `.csv .tsv` | csvview | none |
| `.ipynb` | render-markdown | jupytext → markdown |

## Architecture

Single visual backend: **`snacks.nvim`'s `image` module**, using kitty's graphics protocol. Formats that aren't natively images become images (or markdown/csv) via thin `BufReadCmd` autocmds. Conversion uses already-mature CLI tools.

Two routing paths:

- **Native to snacks/csvview/jupytext** — png, jpg, gif, webp, svg, pdf, csv, tsv, ipynb. Their owning plugin hooks the buffer itself; we don't write any autocmd.
- **Our `BufReadCmd` autocmds** — pptx, docx, xlsx only. Each converts to a format the row above can render, then hands off.

```
        ┌──────────────────────────────────────────────────────────┐
file open
        ├──────────────────────────────────────────────────────────┤
        │ HANDLED NATIVELY BY THE OWNING PLUGIN:                   │
        │   png/jpg/gif/webp/svg ──▶ snacks.image                  │
        │   pdf                  ──▶ snacks.image                  │
        │   csv / tsv            ──▶ csvview                       │
        │   ipynb                ──▶ jupytext → markdown → render-md│
        ├──────────────────────────────────────────────────────────┤
        │ HANDLED BY OUR BufReadCmd AUTOCMDS:                      │
        │   pptx ──▶ libreoffice → pdf  ──▶ snacks.image           │
        │   docx ──▶ pandoc → markdown  ──▶ render-markdown        │
        │   xlsx ──▶ xlsx2csv → csv     ──▶ csvview                │
        └──────────────────────────────────────────────────────────┘

Previews (telescope, nvim-tree): single dispatcher function exported by
document-viewers.lua, called from a custom telescope previewer and a
<leader>p keymap on the nvim-tree node. No duplication of conversion logic.
```

## Components

### 1. `lua/cetusian/plugins/snacks.lua`

- Plugin: `folke/snacks.nvim`
- Only the `image` module enabled. Other snacks modules explicitly `enabled = false`.
- Kitty backend. snacks.image natively hooks buffer events for png/jpg/gif/webp/svg/pdf — we do not write our own autocmds for those.
- No custom keymaps.

### 2. `lua/cetusian/plugins/csvview.lua`

- Plugin: `hat0uma/csvview.nvim`
- Auto-enable on `csv`, `tsv`.
- Bordered table cells, sticky header.
- Keymap `<leader>tc` to toggle view, registered under the existing which-key `t` group.

### 3. `lua/cetusian/plugins/jupytext.lua`

- Plugin: `GCBallesteros/jupytext.nvim`
- Converts `.ipynb` ↔ markdown on read/write.
- Cells render as fenced code blocks; embedded images render through snacks.
- View-only; no kernel execution (kernel work is out of scope — that's `molten.nvim` territory).

### 4. `lua/cetusian/plugins/document-viewers.lua`

The glue. Single file, three `BufReadCmd` autocmds + one user command:

- `*.pptx` → resolve `soffice` (Linux PATH **or** `/Applications/LibreOffice.app/Contents/MacOS/soffice` on macOS), convert to `vim.fs.joinpath(vim.fn.stdpath("cache"), "docview", "<hash>.pdf")`, rename buffer, set filetype, snacks renders.
- `*.docx` → `pandoc -f docx -t markdown`, write into current buffer with `nvim_buf_set_lines`, set `filetype=markdown`.
- `*.xlsx` → `xlsx2csv`, write into buffer, set `filetype=csv`. csvview lights up.
- `:DocViewCheck` — probes each CLI dep, prints ✓/✗ with **per-OS install hints**.

### 5. Preview integration

A single function `M.preview(path)` exported by `document-viewers.lua`:
- For visual formats (image/svg/pdf/pptx) → opens a snacks.image float (transient, closed on next keypress).
- For text-convertible formats (docx/xlsx/csv/ipynb) → opens a scratch buffer in a float with the converted content and the right filetype set.

Wired in from two callsites:
- `telescope.lua`: a custom `previewer` (built with `telescope.previewers.new_buffer_previewer`) checks the extension and, for supported visual formats, calls `M.preview`. For unsupported types it falls back to telescope's default file previewer.
- `nvim-tree.lua`: keymap `<leader>p` in the tree buffer reads `require("nvim-tree.api").tree.get_node_under_cursor().absolute_path` and calls `M.preview`.

### 6. `install.sh` additions

Per-OS dependency install, idempotent (each step guarded by `has <cmd>`):

| Tool | apt | dnf | pacman | brew |
|---|---|---|---|---|
| ImageMagick | `imagemagick` | `ImageMagick` | `imagemagick` | `imagemagick` |
| Ghostscript | `ghostscript` | `ghostscript` | `ghostscript` | `ghostscript` |
| LibreOffice | `libreoffice` | `libreoffice` | `libreoffice-fresh` | `--cask libreoffice` |
| Pandoc | `pandoc` | `pandoc` | `pandoc` | `pandoc` |
| xlsx2csv | `python3-xlsx2csv` | `python3-xlsx2csv` | `python-xlsx2csv` (AUR; fall back to `pip install --user xlsx2csv`) | `xlsx2csv` |

### 7. Docs

- `docs/document-viewers.md` — supported formats, deps, how to add a new format, manual visual checklist.
- `README.md` — one-line entry under features.

## Data flow detail

**Buffer-open (`nvim deck.pptx`):**
1. `BufReadCmd` fires for `*.pptx`.
2. Handler resolves `soffice` cross-platform.
3. If missing → `vim.notify` with OS-matched install hint, abort cleanly (buffer empty, no error).
4. Otherwise convert to `cache/docview/<sha1-of-source-path>.pdf`.
5. Rename buffer to that pdf path; snacks.image renders.

**docx:** identical pattern with `pandoc` → markdown text → `nvim_buf_set_lines` → `filetype=markdown`. No temp file.

**xlsx:** identical with `xlsx2csv` → csv text → buffer → `filetype=csv`.

All temp output lives under `vim.fn.stdpath("cache").."/docview/"` — never `/tmp` literals; OS-agnostic and user-scoped.

## Error handling

One rule: every conversion handler is wrapped so a missing dep or bad input never leaves nvim broken.

- Missing CLI → `vim.notify(level=WARN)` with OS-matched install hint, abort. Buffer falls back to raw bytes (not blank).
- Conversion fails (non-zero exit) → notify with first line of stderr, abort.
- Snacks/kitty unavailable (e.g. plain ssh, tmux without kitty passthrough) → snacks handles this; `:DocViewCheck` surfaces the diagnosis.
- All `vim.fn.system` / `systemlist` calls check `vim.v.shell_error`. No silent failures.

## Testing

Config repo, not a library — smoke tests, not unit tests.

- `tests/fixtures/`: one tiny real file per supported format.
- `tests/smoke.sh`: opens each fixture with `nvim --headless -c "lua print(vim.bo.filetype)" -c "qa"` and asserts the resulting `filetype`. Catches wiring regressions without needing a graphics-capable terminal in CI.
- Manual visual checklist in `docs/document-viewers.md`:
  - [ ] `nvim sample.pdf` renders pages
  - [ ] `:DocViewCheck` shows all green on a fresh install (after running `install.sh`)
  - [ ] Telescope preview on `sample.png` shows the image
  - [ ] Re-running `install.sh` doesn't reinstall anything

## Out of scope

- Editing xlsx/docx/pptx
- Jupyter kernel execution (would need `molten.nvim`)
- Video / audio playback
- Encrypted PDFs (will surface as a clean error, not auto-handled)
