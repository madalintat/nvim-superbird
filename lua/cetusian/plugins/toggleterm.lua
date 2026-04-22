return {
  "akinsho/toggleterm.nvim",
  version = "*",
  cmd = { "ToggleTerm", "TermExec", "ToggleTermToggleAll" },
  keys = {
    { "<leader>Tf", "<cmd>ToggleTerm direction=float<CR>",      desc = "Terminal: float" },
    { "<leader>Th", "<cmd>ToggleTerm direction=horizontal<CR>", desc = "Terminal: horizontal" },
    { "<leader>Tv", "<cmd>ToggleTerm direction=vertical size=80<CR>", desc = "Terminal: vertical" },
  },
  opts = {
    size = function(term)
      if term.direction == "horizontal" then return 15
      elseif term.direction == "vertical" then return vim.o.columns * 0.4 end
    end,
    open_mapping = [[<c-\>]],
    shade_terminals = true,
    start_in_insert = true,
    persist_size = true,
    direction = "float",
    float_opts = {
      border = "rounded",
      winblend = 0,
    },
  },
}
