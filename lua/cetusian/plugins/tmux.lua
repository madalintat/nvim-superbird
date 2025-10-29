return {
  "aserowy/tmux.nvim",
  event = "VeryLazy",
  config = function()
    require("tmux").setup({
      copy_sync = {
        enable = true,
        redirect_to_clipboard = true,
      },
      navigation = {
        enable_default_keybindings = true,
        cycle_navigation = true,
      },
      resize = {
        enable_default_keybindings = true,
        resize_step_x = 2,
        resize_step_y = 2,
      },
    })

    -- Additional keybindings
    vim.keymap.set("n", "<leader>tr", "<cmd>lua require('tmux').resize_bottom()<CR>",
      { desc = "Resize tmux pane" })
  end,
}
