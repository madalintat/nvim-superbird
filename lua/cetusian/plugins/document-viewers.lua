-- Document viewer glue: BufReadCmd autocmds for pptx/docx/xlsx, plus a
-- shared preview helper and a :DocViewCheck health command.
--
-- Native rendering for png/jpg/gif/webp/svg/pdf/csv/ipynb is handled by
-- snacks / csvview / jupytext; this file only covers formats needing
-- a conversion step.

-- Disable vim's built-in zip browser: it registers a BufReadCmd for
-- *.pptx/*.docx/*.xlsx (they're zip archives under the hood) which would
-- otherwise win against our converters.
vim.g.loaded_zipPlugin = 1
vim.g.loaded_zip = 1

local M = {}

local cache_dir = vim.fs.joinpath(vim.fn.stdpath("cache"), "docview")
vim.fn.mkdir(cache_dir, "p")

local function exepath(name, fallbacks)
  local p = vim.fn.exepath(name)
  if p ~= "" then return p end
  for _, alt in ipairs(fallbacks or {}) do
    if vim.fn.executable(alt) == 1 then return alt end
  end
  return nil
end

local function find_soffice()
  return exepath("soffice", {
    "/Applications/LibreOffice.app/Contents/MacOS/soffice",
  })
end

local function install_hint(tool)
  local mac = vim.uv.os_uname().sysname == "Darwin"
  local hints = {
    soffice  = mac and "brew install --cask libreoffice" or "sudo apt install libreoffice  (or dnf/pacman)",
    pandoc   = mac and "brew install pandoc"             or "sudo apt install pandoc",
    xlsx2csv = mac and "brew install xlsx2csv"           or "pipx install xlsx2csv",
    jupytext = mac and "pipx install jupytext"           or "pipx install jupytext",
    convert  = mac and "brew install imagemagick"        or "sudo apt install imagemagick",
    gs       = mac and "brew install ghostscript"        or "sudo apt install ghostscript",
  }
  return hints[tool] or "(see docs/document-viewers.md)"
end

local function run(cmd_list)
  local out = vim.fn.system(cmd_list)
  if vim.v.shell_error ~= 0 then
    return nil, (out:match("[^\n]+") or "(no stderr)")
  end
  return out, nil
end

local function hash(s) return vim.fn.sha256(s):sub(1, 16) end

M._cache_dir = cache_dir
M._find_soffice = find_soffice
M._install_hint = install_hint
M._run = run
M._hash = hash

function M.preview(path)
  if not path or path == "" then return end
  local ext = (path:match("^.+%.([%w]+)$") or ""):lower()
  local visual = { png = true, jpg = true, jpeg = true, gif = true, webp = true,
                   svg = true, pdf = true }
  if visual[ext] then
    local ok = pcall(function() require("snacks").image.placement.new(0, path) end)
    if not ok then vim.notify("Could not preview " .. path, vim.log.levels.WARN) end
    return
  end
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

function M.check()
  local tools = {
    { name = "ImageMagick (convert)", cmd = "convert",  key = "convert" },
    { name = "Ghostscript",           cmd = "gs",       key = "gs" },
    { name = "LibreOffice (soffice)", cmd = "soffice",  key = "soffice",
      check = function() return find_soffice() ~= nil end },
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
        t.name, install_hint(t.key)))
    end
  end
  table.insert(lines, "")
  table.insert(lines, missing == 0 and "All dependencies present."
    or (missing .. " dependency/ies missing — see hints above."))
  vim.api.nvim_echo(vim.tbl_map(function(l) return { l .. "\n" } end, lines), true, {})
end

return {
  dir = vim.fn.stdpath("config") .. "/lua/cetusian/plugins",
  name = "document-viewers",
  lazy = false,
  config = function()
    local group = vim.api.nvim_create_augroup("DocumentViewers", { clear = true })

    -- .pptx -> libreoffice -> pdf -> snacks.image
    vim.api.nvim_create_autocmd("BufReadCmd", {
      group = group,
      pattern = "*.pptx",
      callback = function(args)
        local src = args.match
        local soffice = find_soffice()
        if not soffice then
          vim.notify("pptx viewing needs LibreOffice. Install: " .. install_hint("soffice"),
            vim.log.levels.WARN)
          return
        end
        local out_pdf = vim.fs.joinpath(cache_dir, hash(src) .. ".pdf")
        if vim.fn.filereadable(out_pdf) == 0 then
          local _, err = run({
            soffice, "--headless", "--convert-to", "pdf",
            "--outdir", cache_dir, src,
          })
          if err then
            vim.notify("pptx conversion failed: " .. err, vim.log.levels.WARN)
            return
          end
          local soffice_out = vim.fs.joinpath(cache_dir,
            vim.fn.fnamemodify(src, ":t:r") .. ".pdf")
          if vim.fn.filereadable(soffice_out) == 1 then
            vim.uv.fs_rename(soffice_out, out_pdf)
          end
        end
        vim.api.nvim_buf_set_name(args.buf, out_pdf)
        vim.cmd("edit!")
      end,
    })

    -- .docx -> pandoc -> markdown
    vim.api.nvim_create_autocmd("BufReadCmd", {
      group = group,
      pattern = "*.docx",
      callback = function(args)
        local src = args.match
        if vim.fn.executable("pandoc") == 0 then
          vim.notify("docx viewing needs pandoc. Install: " .. install_hint("pandoc"),
            vim.log.levels.WARN)
          return
        end
        local out, err = run({ "pandoc", "-f", "docx", "-t", "markdown", src })
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

    -- .xlsx -> xlsx2csv -> csv. Defaults to the first sheet (no -a) so the
    -- output is a clean csv that csvview can align.
    vim.api.nvim_create_autocmd("BufReadCmd", {
      group = group,
      pattern = "*.xlsx",
      callback = function(args)
        local src = args.match
        if vim.fn.executable("xlsx2csv") == 0 then
          vim.notify("xlsx viewing needs xlsx2csv. Install: " .. install_hint("xlsx2csv"),
            vim.log.levels.WARN)
          return
        end
        local out, err = run({ "xlsx2csv", src })
        if err then
          vim.notify("xlsx conversion failed: " .. err, vim.log.levels.WARN)
          return
        end
        local lines = vim.split(out, "\n", { plain = true })
        vim.api.nvim_buf_set_lines(args.buf, 0, -1, false, lines)
        vim.api.nvim_set_option_value("filetype", "csv", { buf = args.buf })
        vim.api.nvim_set_option_value("modified", false, { buf = args.buf })
        vim.api.nvim_set_option_value("readonly", true, { buf = args.buf })
        -- Force csvview to attach now in case its FileType autocmd missed
        -- the timing (e.g. opened directly via `nvim file.xlsx`).
        pcall(vim.cmd, "CsvViewEnable")
      end,
    })

    vim.api.nvim_create_user_command("DocViewCheck", function() M.check() end, {})
    package.loaded["cetusian.document-viewers"] = M
  end,
}
