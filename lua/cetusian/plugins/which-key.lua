return {
  "folke/which-key.nvim",
  event = "VeryLazy",
  init = function()
    vim.o.timeout = true
    vim.o.timeoutlen = 500
  end,
  opts = {
    preset = "helix",
    spec = {
      { "<leader>c", group = "Code" },
      { "<leader>d", group = "Diagnostic / Debug" },
      { "<leader>e", group = "Explorer" },
      { "<leader>f", group = "Find / Format" },
      { "<leader>g", group = "Git" },
      { "<leader>h", group = "Harpoon" },
      { "<leader>j", group = "JQ" },
      { "<leader>l", group = "LSP" },
      { "<leader>m", group = "Markdown / Format" },
      { "<leader>n", group = "Neotest / Notify" },
      { "<leader>p", group = "Pathfinder" },
      { "<leader>r", group = "Rename / Run" },
      { "<leader>s", group = "Split / Snip" },
      { "<leader>t", group = "Tab" },
      { "<leader>T", group = "Terminal" },
      { "<leader>v", group = "Venv (Python)" },
      { "<leader>x", group = "Trouble" },
    },
  },
}
