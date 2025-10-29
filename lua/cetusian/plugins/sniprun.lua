return {
  "michaelb/sniprun",
  build = "bash ./install.sh",
  cmd = { "SnipRun", "SnipInfo", "SnipReset", "SnipReplMemoryClean", "SnipClose", "SnipLive" },
  config = function()
    require("sniprun").setup({
      selected_interpreters = {},
      repl_enable = {},
      repl_disable = {},
      interpreter_options = {},
      display = {
        "Classic",
        "VirtualTextOk",
      },
      display_options = {
        terminal_width = 45,
        notification_timeout = 5,
      },
      show_no_output = {
        "Classic",
        "TempFloatingWindow",
      },
      inline_messages = 0,
      borders = "rounded",
    })

    -- Keybindings
    vim.keymap.set("n", "<leader>rs", "<cmd>SnipRun<CR>",
      { desc = "Run code snippet" })
    vim.keymap.set("v", "<leader>rs", "<cmd>SnipRun<CR>",
      { desc = "Run selected code" })
    vim.keymap.set("n", "<leader>rc", "<cmd>SnipClose<CR>",
      { desc = "Close sniprun" })
    vim.keymap.set("n", "<leader>rr", "<cmd>SnipReset<CR>",
      { desc = "Reset sniprun" })
    vim.keymap.set("n", "<leader>rl", "<cmd>SnipLive<CR>",
      { desc = "Toggle live mode" })
  end,
}
