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

    dapui.setup()
    require("nvim-dap-virtual-text").setup()

    dap.listeners.after.event_initialized["dapui_config"] = function() dapui.open() end
    dap.listeners.before.event_terminated["dapui_config"] = function() dapui.close() end
    dap.listeners.before.event_exited["dapui_config"]     = function() dapui.close() end

    local function map(lhs, rhs, desc)
      vim.keymap.set("n", lhs, rhs, { desc = desc })
    end

    map("<leader>db", dap.toggle_breakpoint,  "Toggle breakpoint")
    map("<leader>dc", dap.continue,           "Debug continue")
    map("<leader>di", dap.step_into,          "Debug step into")
    map("<leader>do", dap.step_over,          "Debug step over")
    map("<leader>dO", dap.step_out,           "Debug step out")
    map("<leader>dr", dap.repl.toggle,        "Toggle REPL")
    map("<leader>dl", dap.run_last,           "Run last debug config")
    map("<leader>du", dapui.toggle,           "Toggle DAP UI")
  end,
}
