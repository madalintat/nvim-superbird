return {
  "LuxVim/nvim-luxterm",
  event = "VeryLazy",
  config = function()
    require("luxterm").setup({
      -- Terminal configuration
      position = "bottom",
      size = 15,
    })

    -- Keybindings
    vim.keymap.set("n", "<leader>lt", "<cmd>lua require('luxterm').toggle()<CR>",
      { desc = "Toggle Luxterm terminal" })
    vim.keymap.set("n", "<leader>lv", "<cmd>lua require('luxterm').toggle_vsplit()<CR>",
      { desc = "Toggle Luxterm vertical split" })
    vim.keymap.set("n", "<leader>lh", "<cmd>lua require('luxterm').toggle_hsplit()<CR>",
      { desc = "Toggle Luxterm horizontal split" })
  end,
}
