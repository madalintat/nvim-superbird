return {
  "ThePrimeagen/harpoon",
  branch = "harpoon2",
  dependencies = { "nvim-lua/plenary.nvim" },
  keys = function()
    local harpoon = require("harpoon")
    return {
      { "<leader>ha", function() harpoon:list():add() end,    desc = "Harpoon add file" },
      { "<leader>hm", function() harpoon.ui:toggle_quick_menu(harpoon:list()) end, desc = "Harpoon menu" },
      { "<leader>h1", function() harpoon:list():select(1) end, desc = "Harpoon file 1" },
      { "<leader>h2", function() harpoon:list():select(2) end, desc = "Harpoon file 2" },
      { "<leader>h3", function() harpoon:list():select(3) end, desc = "Harpoon file 3" },
      { "<leader>h4", function() harpoon:list():select(4) end, desc = "Harpoon file 4" },
      { "<leader>hn", function() harpoon:list():next() end,    desc = "Harpoon next" },
      { "<leader>hp", function() harpoon:list():prev() end,    desc = "Harpoon prev" },
    }
  end,
  config = function()
    require("harpoon"):setup()
  end,
}
