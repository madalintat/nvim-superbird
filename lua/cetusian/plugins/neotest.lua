return {
  "nvim-neotest/neotest",
  dependencies = {
    "nvim-lua/plenary.nvim",
    "antoinemadec/FixCursorHold.nvim",
    "nvim-treesitter/nvim-treesitter",
    "nvim-neotest/nvim-nio",
    "nvim-neotest/neotest-jest",
    "nvim-neotest/neotest-python",
  },
  keys = {
    { "<leader>nr", function() require("neotest").run.run() end,                 desc = "Test: run nearest" },
    { "<leader>nf", function() require("neotest").run.run(vim.fn.expand("%")) end, desc = "Test: run file" },
    { "<leader>nl", function() require("neotest").run.run_last() end,            desc = "Test: run last" },
    { "<leader>ns", function() require("neotest").summary.toggle() end,          desc = "Test: toggle summary" },
    { "<leader>no", function() require("neotest").output.open({ enter = true }) end, desc = "Test: output panel" },
    { "<leader>nO", function() require("neotest").output_panel.toggle() end,     desc = "Test: output (panel)" },
    { "<leader>nd", function() require("neotest").run.run({ strategy = "dap" }) end, desc = "Test: debug nearest" },
    { "<leader>nS", function() require("neotest").run.stop() end,                desc = "Test: stop" },
  },
  config = function()
    require("neotest").setup({
      adapters = {
        require("neotest-jest")({
          jestCommand = "npm test --",
          env = { CI = true },
        }),
        require("neotest-python")({
          runner = "pytest",
        }),
      },
    })
  end,
}
