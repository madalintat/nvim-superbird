return {
  "yetone/avante.nvim",
  event = "VeryLazy",
  build = "make",
  dependencies = {
    "nvim-treesitter/nvim-treesitter",
    "stevearc/dressing.nvim",
    "nvim-lua/plenary.nvim",
    "MunifTanjim/nui.nvim",
    "nvim-tree/nvim-web-devicons",
  },
  config = function()
    require("avante").setup({
      provider = "claude",
      claude = {
        endpoint = "https://api.anthropic.com",
        model = "claude-3-5-sonnet-20241022",
        temperature = 0,
        max_tokens = 4096,
      },
      mappings = {
        ask = "<leader>aa",
        edit = "<leader>ae",
        refresh = "<leader>ar",
      },
      hints = { enabled = true },
      windows = {
        wrap = true,
        width = 30,
        sidebar_header = {
          align = "center",
          rounded = true,
        },
      },
    })

    -- Keybindings
    vim.keymap.set("n", "<leader>aa", "<cmd>AvanteAsk<CR>",
      { desc = "Avante: Ask AI" })
    vim.keymap.set("v", "<leader>ae", "<cmd>AvanteEdit<CR>",
      { desc = "Avante: Edit with AI" })
    vim.keymap.set("n", "<leader>ar", "<cmd>AvanteRefresh<CR>",
      { desc = "Avante: Refresh" })
    vim.keymap.set("n", "<leader>at", "<cmd>AvanteToggle<CR>",
      { desc = "Avante: Toggle sidebar" })
  end,
}
