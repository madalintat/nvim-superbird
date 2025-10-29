return {
  "LuxVim/nvim-luxmotion",
  event = "VeryLazy",
  config = function()
    local luxmotion = require("luxmotion")

    luxmotion.setup({
      -- Configuration for luxmotion
      jump_key = "<leader><leader>",
      forward_key = "s",
      backward_key = "S",

      -- Highlight settings
      highlight = {
        enabled = true,
      },
    })

    -- Keybindings
    vim.keymap.set({ "n", "x", "o" }, "s", "<cmd>lua require('luxmotion').forward()<CR>",
      { desc = "Luxmotion forward jump" })
    vim.keymap.set({ "n", "x", "o" }, "S", "<cmd>lua require('luxmotion').backward()<CR>",
      { desc = "Luxmotion backward jump" })
  end,
}
