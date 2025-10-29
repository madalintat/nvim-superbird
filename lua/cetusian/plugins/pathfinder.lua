return {
  "HawkinsT/pathfinder.nvim",
  event = "VeryLazy",
  config = function()
    require("pathfinder").setup({
      -- Pathfinder configuration
    })

    -- Keybindings
    vim.keymap.set("n", "<leader>pf", "<cmd>PathfinderFind<CR>",
      { desc = "Find path to current file" })
    vim.keymap.set("n", "<leader>pd", "<cmd>PathfinderDirs<CR>",
      { desc = "Find directories" })
    vim.keymap.set("n", "<leader>pc", "<cmd>PathfinderCopy<CR>",
      { desc = "Copy current path" })
  end,
}
