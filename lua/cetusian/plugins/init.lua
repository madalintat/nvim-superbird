return {
  "nvim-lua/plenary.nvim",
  {
    "christoomey/vim-tmux-navigator",
    cmd = {
      "TmuxNavigateLeft",
      "TmuxNavigateDown",
      "TmuxNavigateUp",
      "TmuxNavigateRight",
      "TmuxNavigatePrevious",
    },
    keys = {
      { "<C-h>", "<cmd>TmuxNavigateLeft<CR>",  desc = "Navigate left (split/tmux)" },
      { "<C-j>", "<cmd>TmuxNavigateDown<CR>",  desc = "Navigate down (split/tmux)" },
      { "<C-k>", "<cmd>TmuxNavigateUp<CR>",    desc = "Navigate up (split/tmux)" },
      { "<C-l>", "<cmd>TmuxNavigateRight<CR>", desc = "Navigate right (split/tmux)" },
    },
  },
}
