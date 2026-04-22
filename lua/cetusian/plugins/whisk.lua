return {
  "LuxVim/whisk.nvim",
  event = "VeryLazy",
  config = function()
    local whisk = require("whisk")

    whisk.setup({
      jump_key = "<leader><leader>",
      forward_key = "s",
      backward_key = "S",
      highlight = {
        enabled = true,
      },
    })

    vim.keymap.set({ "n", "x", "o" }, "s", function() whisk.forward() end,
      { desc = "Whisk forward jump" })
    vim.keymap.set({ "n", "x", "o" }, "S", function() whisk.backward() end,
      { desc = "Whisk backward jump" })
  end,
}
