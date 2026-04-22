return {
  "ThePrimeagen/harpoon",
  branch = "harpoon2",
  dependencies = { "nvim-lua/plenary.nvim" },
  keys = function()
    local harpoon = require("harpoon")
    return {
      { "<leader>Ha", function() harpoon:list():add() end,    desc = "Harpoon add file" },
      { "<leader>Hm", function() harpoon.ui:toggle_quick_menu(harpoon:list()) end, desc = "Harpoon menu" },
      { "<leader>H1", function() harpoon:list():select(1) end, desc = "Harpoon file 1" },
      { "<leader>H2", function() harpoon:list():select(2) end, desc = "Harpoon file 2" },
      { "<leader>H3", function() harpoon:list():select(3) end, desc = "Harpoon file 3" },
      { "<leader>H4", function() harpoon:list():select(4) end, desc = "Harpoon file 4" },
      { "<leader>Hn", function() harpoon:list():next() end,    desc = "Harpoon next" },
      { "<leader>Hp", function() harpoon:list():prev() end,    desc = "Harpoon prev" },
    }
  end,
  config = function()
    require("harpoon"):setup()
  end,
}
