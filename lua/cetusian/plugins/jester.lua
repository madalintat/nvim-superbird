return {
  "David-Kunz/jester",
  ft = { "javascript", "typescript", "javascriptreact", "typescriptreact" },
  dependencies = {
    "nvim-lua/plenary.nvim",
    "mfussenegger/nvim-dap",
  },
  config = function()
    require("jester").setup({
      cmd = "jest -t '$result' -- $file",
      identifiers = { "test", "it" },
      path_to_jest_run = "jest",
      path_to_jest_debug = "./node_modules/.bin/jest",
      terminal_cmd = ":vsplit | terminal",
      dap = {
        console = "integratedTerminal",
        type = "node2",
      },
    })

    -- Keybindings
    vim.keymap.set("n", "<leader>jr", "<cmd>lua require('jester').run()<CR>",
      { desc = "Run nearest Jest test" })
    vim.keymap.set("n", "<leader>jf", "<cmd>lua require('jester').run_file()<CR>",
      { desc = "Run Jest file" })
    vim.keymap.set("n", "<leader>jl", "<cmd>lua require('jester').run_last()<CR>",
      { desc = "Run last Jest test" })
    vim.keymap.set("n", "<leader>jd", "<cmd>lua require('jester').debug()<CR>",
      { desc = "Debug nearest Jest test" })
    vim.keymap.set("n", "<leader>jD", "<cmd>lua require('jester').debug_file()<CR>",
      { desc = "Debug Jest file" })
  end,
}
