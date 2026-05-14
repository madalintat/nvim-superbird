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

- Kitty terminal (or any terminal speaking the kitty graphics protocol).
- System tools installed by `install.sh`: ImageMagick, Ghostscript, LibreOffice, Pandoc, xlsx2csv, jupytext.

Run `:DocViewCheck` inside nvim to see which deps are present.

## Keymaps

| Keys | Action |
|---|---|
| (open file) | Buffer-open with the appropriate renderer |
| `<leader>Vc` | Toggle CSV view on current buffer |
| `<leader>fv` | Find a file and preview it in a float |
| `P` (inside nvim-tree) | Preview the highlighted file |

## How to add another format

1. If the format is image-like, add its extension to `formats` in `lua/cetusian/plugins/snacks.lua`.
2. Otherwise add a `BufReadCmd` in `lua/cetusian/plugins/document-viewers.lua` following the docx/xlsx pattern.
3. Add a fixture in `tests/fixtures/generate.sh` and a `probe_ft` line in `tests/smoke.sh`.
4. Add the install command to `install_doc_deps` in `install.sh`.

## Manual visual checklist

After running `install.sh` and `bash tests/fixtures/generate.sh`:

- [ ] `nvim tests/fixtures/sample.pdf` renders pages
- [ ] `nvim tests/fixtures/sample.png` renders the image
- [ ] `nvim tests/fixtures/sample.docx` renders as markdown
- [ ] `nvim tests/fixtures/sample.xlsx` renders as a csv table
- [ ] `nvim tests/fixtures/sample.pptx` renders the first slide
- [ ] `nvim tests/fixtures/sample.ipynb` renders cells as markdown
- [ ] `:DocViewCheck` shows all dependencies present
