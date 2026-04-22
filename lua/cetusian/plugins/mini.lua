return {
  {
    "echasnovski/mini.ai",
    event = { "BufReadPre", "BufNewFile" },
    opts = {},
  },
  {
    "echasnovski/mini.move",
    event = { "BufReadPre", "BufNewFile" },
    opts = {
      mappings = {
        left  = "<M-Left>",
        right = "<M-Right>",
        down  = "<M-Down>",
        up    = "<M-Up>",
        line_left  = "<M-Left>",
        line_right = "<M-Right>",
        line_down  = "<M-Down>",
        line_up    = "<M-Up>",
      },
    },
  },
  {
    "echasnovski/mini.bufremove",
    keys = {
      { "<leader>bd", function() require("mini.bufremove").delete(0, false) end, desc = "Delete buffer (keep window)" },
      { "<leader>bD", function() require("mini.bufremove").delete(0, true)  end, desc = "Delete buffer (force)" },
    },
  },
}
