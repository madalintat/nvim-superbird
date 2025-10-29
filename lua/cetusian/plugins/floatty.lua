return {
  "ingur/floatty.nvim",
  event = "VeryLazy",
  config = function()
    require("floatty").setup({
      width = 0.8,
      height = 0.8,
      border = "rounded",
    })

    -- Keybindings
    vim.keymap.set("n", "<leader>ft", "<cmd>Floatty<CR>",
      { desc = "Toggle floating terminal" })
    vim.keymap.set("n", "<leader>fn", "<cmd>FloattyNew<CR>",
      { desc = "New floating terminal" })
    vim.keymap.set("t", "<C-\\><C-n>", "<C-\\><C-n>",
      { desc = "Exit terminal mode" })
  end,
}
