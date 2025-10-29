return {
  "pwntester/octo.nvim",
  dependencies = {
    "nvim-lua/plenary.nvim",
    "nvim-telescope/telescope.nvim",
    "nvim-tree/nvim-web-devicons",
  },
  cmd = "Octo",
  config = function()
    require("octo").setup({
      use_local_fs = false,
      enable_builtin = true,
      default_remote = { "upstream", "origin" },
      ssh_aliases = {},
      picker = "telescope",
      issues = {
        order_by = {
          field = "CREATED_AT",
          direction = "DESC",
        },
      },
    })

    -- Keybindings
    vim.keymap.set("n", "<leader>go", "<cmd>Octo<CR>",
      { desc = "Open Octo menu" })
    vim.keymap.set("n", "<leader>goi", "<cmd>Octo issue list<CR>",
      { desc = "List GitHub issues" })
    vim.keymap.set("n", "<leader>gop", "<cmd>Octo pr list<CR>",
      { desc = "List GitHub PRs" })
    vim.keymap.set("n", "<leader>gor", "<cmd>Octo repo view<CR>",
      { desc = "View GitHub repo" })
  end,
}
