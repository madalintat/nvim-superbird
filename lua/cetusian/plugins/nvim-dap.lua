return {
  "mfussenegger/nvim-dap",
  dependencies = {
    "rcarriga/nvim-dap-ui",
    "theHamsta/nvim-dap-virtual-text",
    "nvim-neotest/nvim-nio",
  },
  event = "VeryLazy",
  config = function()
    local dap = require("dap")
    local dapui = require("dapui")

    -- Setup DAP UI
    dapui.setup()

    -- Setup virtual text
    require("nvim-dap-virtual-text").setup()

    -- Auto open/close DAP UI
    dap.listeners.after.event_initialized["dapui_config"] = function()
      dapui.open()
    end
    dap.listeners.before.event_terminated["dapui_config"] = function()
      dapui.close()
    end
    dap.listeners.before.event_exited["dapui_config"] = function()
      dapui.close()
    end

    -- Keybindings
    vim.keymap.set("n", "<leader>db", "<cmd>lua require('dap').toggle_breakpoint()<CR>",
      { desc = "Toggle breakpoint" })
    vim.keymap.set("n", "<leader>dc", "<cmd>lua require('dap').continue()<CR>",
      { desc = "Debug continue" })
    vim.keymap.set("n", "<leader>di", "<cmd>lua require('dap').step_into()<CR>",
      { desc = "Debug step into" })
    vim.keymap.set("n", "<leader>do", "<cmd>lua require('dap').step_over()<CR>",
      { desc = "Debug step over" })
    vim.keymap.set("n", "<leader>dO", "<cmd>lua require('dap').step_out()<CR>",
      { desc = "Debug step out" })
    vim.keymap.set("n", "<leader>dr", "<cmd>lua require('dap').repl.toggle()<CR>",
      { desc = "Toggle REPL" })
    vim.keymap.set("n", "<leader>dl", "<cmd>lua require('dap').run_last()<CR>",
      { desc = "Run last debug config" })
    vim.keymap.set("n", "<leader>du", "<cmd>lua require('dapui').toggle()<CR>",
      { desc = "Toggle DAP UI" })
  end,
}
