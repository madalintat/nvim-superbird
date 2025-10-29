-- COQ is now the primary completion engine (nvim-cmp is disabled)
return {
  "ms-jpq/coq_nvim",
  branch = "coq",
  enabled = true,
  event = "VeryLazy",
  priority = 950, -- Load after mason but before lspconfig
  build = ":COQdeps",
  dependencies = {
    { "ms-jpq/coq.artifacts", branch = "artifacts" },
    { "ms-jpq/coq.thirdparty", branch = "3p" },
  },
  init = function()
    vim.g.coq_settings = {
      auto_start = "shut-up",
      keymap = {
        recommended = false,
        manual_complete = "<C-Space>",
      },
    }
  end,
  config = function()
    -- COQ setup
    local coq = require("coq")

    -- Keybindings (COQ uses its own completion mappings)
    vim.keymap.set("i", "<Tab>", [[pumvisible() ? "\<C-n>" : "\<Tab>"]],
      { expr = true, desc = "Next completion" })
    vim.keymap.set("i", "<S-Tab>", [[pumvisible() ? "\<C-p>" : "\<S-Tab>"]],
      { expr = true, desc = "Previous completion" })
  end,
}
