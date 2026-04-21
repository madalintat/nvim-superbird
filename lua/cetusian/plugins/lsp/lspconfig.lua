return {
  "neovim/nvim-lspconfig",
  event = { "BufReadPre", "BufNewFile" },
  dependencies = {
    "hrsh7th/cmp-nvim-lsp",
    { "antosha417/nvim-lsp-file-operations", config = true },
    { "folke/neodev.nvim", opts = {} },
    {
      "williamboman/mason-lspconfig.nvim",
      dependencies = { "williamboman/mason.nvim" },
    },
  },
  config = function()
    local lspconfig = require("lspconfig")
    local cmp_nvim_lsp = require("cmp_nvim_lsp")
    local mason_lspconfig = require("mason-lspconfig")

    vim.api.nvim_create_autocmd("LspAttach", {
      group = vim.api.nvim_create_augroup("UserLspConfig", { clear = true }),
      callback = function(ev)
        local buf = { buffer = ev.buf, silent = true }
        local function bmap(mode, lhs, rhs, desc)
          vim.keymap.set(mode, lhs, rhs, vim.tbl_extend("force", buf, { desc = desc }))
        end
        bmap("n",           "gR",          "<cmd>Telescope lsp_references<CR>",      "Show LSP references")
        bmap("n",           "gD",          vim.lsp.buf.declaration,                  "Go to declaration")
        bmap("n",           "gd",          "<cmd>Telescope lsp_definitions<CR>",     "Show LSP definitions")
        bmap("n",           "gi",          "<cmd>Telescope lsp_implementations<CR>", "Show LSP implementations")
        bmap("n",           "gt",          "<cmd>Telescope lsp_type_definitions<CR>","Show LSP type definitions")
        bmap({ "n", "v" },  "<leader>ca",  vim.lsp.buf.code_action,                 "See available code actions")
        bmap("n",           "<leader>rn",  vim.lsp.buf.rename,                      "Smart rename")
        bmap("n",           "<leader>D",   "<cmd>Telescope diagnostics bufnr=0<CR>","Show buffer diagnostics")
        bmap("n",           "<leader>d",   vim.diagnostic.open_float,               "Show line diagnostics")
        bmap("n",           "[d",          vim.diagnostic.goto_prev,                "Go to previous diagnostic")
        bmap("n",           "]d",          vim.diagnostic.goto_next,                "Go to next diagnostic")
        bmap("n",           "K",           vim.lsp.buf.hover,                       "Show documentation for what is under cursor")
        bmap("n",           "<leader>rs",  ":LspRestart<CR>",                       "Restart LSP")
      end,
    })

    local capabilities = cmp_nvim_lsp.default_capabilities()

    local signs = { Error = " ", Warn = " ", Hint = "󰠠 ", Info = " " }
    for type, icon in pairs(signs) do
      local hl = "DiagnosticSign" .. type
      vim.fn.sign_define(hl, { text = icon, texthl = hl, numhl = "" })
    end

    local function setup(server_name, extra)
      lspconfig[server_name].setup(vim.tbl_extend("force", { capabilities = capabilities }, extra or {}))
    end

    mason_lspconfig.setup({
      ensure_installed = {
        "ts_ls", "html", "cssls", "tailwindcss", "svelte",
        "lua_ls", "graphql", "emmet_ls", "prismals", "pyright",
      },
      handlers = {
        setup,

        ["svelte"] = function(server_name)
          setup(server_name, {
            on_attach = function(client, bufnr)
              local group = vim.api.nvim_create_augroup("SvelteOnTsChange_" .. bufnr, { clear = true })
              vim.api.nvim_create_autocmd("BufWritePost", {
                group = group,
                pattern = { "*.js", "*.ts" },
                callback = function(ctx)
                  client.notify("$/onDidChangeTsOrJsFile", { uri = ctx.match })
                end,
              })
            end,
          })
        end,

        ["graphql"] = function(server_name)
          setup(server_name, {
            filetypes = { "graphql", "gql", "svelte", "typescriptreact", "javascriptreact" },
          })
        end,

        ["emmet_ls"] = function(server_name)
          setup(server_name, {
            filetypes = { "html", "typescriptreact", "javascriptreact", "css", "sass", "scss", "less", "svelte" },
          })
        end,

        ["lua_ls"] = function(server_name)
          setup(server_name, {
            settings = {
              Lua = {
                diagnostics = { globals = { "vim" } },
                completion = { callSnippet = "Replace" },
              },
            },
          })
        end,

        ["pyright"] = function(server_name)
          setup(server_name, {
            settings = {
              python = {
                analysis = {
                  autoSearchPaths = true,
                  useLibraryCodeForTypes = true,
                  diagnosticMode = "workspace",
                },
              },
            },
            filetypes = { "python" },
          })
        end,
      },
    })
  end,
}
