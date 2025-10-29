return {
  "AckslD/swenv.nvim",
  ft = "python",
  dependencies = {
    "nvim-lua/plenary.nvim",
  },
  config = function()
    require("swenv").setup({
      get_venvs = function(venvs_path)
        return require("swenv.api").get_venvs(venvs_path)
      end,
      venvs_path = vim.fn.expand("~/.virtualenvs"),
      post_set_venv = function()
        vim.cmd("LspRestart")
      end,
    })

    -- Keybindings
    vim.keymap.set("n", "<leader>ve", "<cmd>lua require('swenv.api').pick_venv()<CR>",
      { desc = "Pick Python virtual environment" })
    vim.keymap.set("n", "<leader>vc", "<cmd>lua require('swenv.api').get_current_venv()<CR>",
      { desc = "Show current virtual environment" })
  end,
}
