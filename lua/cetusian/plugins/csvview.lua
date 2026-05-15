return {
  "hat0uma/csvview.nvim",
  lazy = false,
  cmd = { "CsvViewEnable", "CsvViewDisable", "CsvViewToggle" },
  opts = {
    parser = { comments = { "#", "//" } },
    view = {
      display_mode = "border",
      header_lnum = 1,
      sticky_header = { enabled = true, separator = "─" },
      spacing = { left = 1, right = 2 },
      min_column_width = 6,
    },
  },
  config = function(_, opts)
    require("csvview").setup(opts)
    vim.api.nvim_create_autocmd("FileType", {
      pattern = { "csv", "tsv" },
      callback = function() vim.cmd("CsvViewEnable") end,
    })
    vim.keymap.set("n", "<leader>Vc", "<cmd>CsvViewToggle<CR>",
      { desc = "Toggle CSV view" })
  end,
}
