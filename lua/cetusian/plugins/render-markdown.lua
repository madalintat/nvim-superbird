return {
  "MeanderingProgrammer/render-markdown.nvim",
  dependencies = {
    "nvim-treesitter/nvim-treesitter",
    "nvim-tree/nvim-web-devicons",
  },
  ft = { "markdown" },
  config = function()
    require("render-markdown").setup({
      enabled = true,
      render_modes = { "n", "c" },
      heading = {
        enabled = true,
        sign = false,
        icons = { "󰲡 ", "󰲣 ", "󰲥 ", "󰲧 ", "󰲩 ", "󰲫 " },
        backgrounds = {
          "RenderMarkdownH1Bg",
          "RenderMarkdownH2Bg",
          "RenderMarkdownH3Bg",
          "RenderMarkdownH4Bg",
          "RenderMarkdownH5Bg",
          "RenderMarkdownH6Bg",
        },
      },
      code = {
        enabled = true,
        sign = false,
        style = "full",
        border = "thin",
        width = "block",
        min_width = 45,
      },
      bullet = {
        enabled = true,
        icons = { "●", "○", "◆", "◇" },
      },
      checkbox = {
        enabled = true,
        unchecked = { icon = "󰄱 " },
        checked = { icon = "󰱒 " },
      },
      table = {
        enabled = true,
        style = "full",
        cell = "padded",
      },
      dash = { enabled = true },
      quote = { enabled = true },
      link = { enabled = true },
    })

    vim.keymap.set("n", "<leader>mr", "<cmd>RenderMarkdown toggle<CR>",
      { desc = "Toggle markdown rendering" })
  end,
}
