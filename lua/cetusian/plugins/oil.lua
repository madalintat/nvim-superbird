return {
  "stevearc/oil.nvim",
  dependencies = { "nvim-tree/nvim-web-devicons" },
  lazy = false,
  keys = {
    { "-", "<cmd>Oil<CR>", desc = "Open parent directory (oil)" },
  },
  opts = {
    default_file_explorer = false,
    columns = { "icon" },
    view_options = {
      show_hidden = true,
    },
    keymaps = {
      ["<C-h>"] = false,
      ["<C-l>"] = false,
      ["q"] = "actions.close",
    },
  },
}
