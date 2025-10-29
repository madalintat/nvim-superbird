return {
  "gennaro-tedesco/nvim-jqx",
  ft = { "json", "yaml" },
  config = function()
    -- nvim-jqx works out of the box, mainly uses commands

    -- Keybindings
    vim.keymap.set("n", "<leader>jq", "<cmd>JqxList<CR>",
      { desc = "Open JQX query list" })
    vim.keymap.set("n", "<leader>jx", "<cmd>JqxQuery<CR>",
      { desc = "Execute JQX query" })
  end,
}
