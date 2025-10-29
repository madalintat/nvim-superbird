return {
  "ellisonleao/glow.nvim",
  cmd = "Glow",
  ft = "markdown",
  config = function()
    require("glow").setup({
      border = "rounded",
      width = 120,
      height = 100,
      width_ratio = 0.8,
      height_ratio = 0.8,
    })

    -- Keybindings
    vim.keymap.set("n", "<leader>mp", "<cmd>Glow<CR>",
      { desc = "Preview markdown with Glow" })
  end,
}
