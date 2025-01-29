return {
  "boganworld/crackboard.nvim",
  dependencies = { "nvim-lua/plenary.nvim" },
  config = function()
    require("crackboard").setup({
      session_key = "0f9186bf8fb826a8b783b8e21b0f211b696aea80d9540b303492479c37ec2bbf",
    })
  end,
}
