return {
  "nvim-lua/plenary.nvim",
  {
    "christoomey/vim-tmux-navigator",
    lazy = false,
    init = function()
      vim.g.tmux_navigator_no_mappings = 1
      vim.g.tmux_navigator_disable_netrw_workaround = 1
    end,
    config = function()
      vim.keymap.set("n", "<C-h>", "<cmd>TmuxNavigateLeft<CR>",  { silent = true, desc = "Navigate left" })
      vim.keymap.set("n", "<C-j>", "<cmd>TmuxNavigateDown<CR>",  { silent = true, desc = "Navigate down" })
      vim.keymap.set("n", "<C-k>", "<cmd>TmuxNavigateUp<CR>",    { silent = true, desc = "Navigate up" })
      vim.keymap.set("n", "<C-l>", "<cmd>TmuxNavigateRight<CR>", { silent = true, desc = "Navigate right" })
    end,
  },
}
