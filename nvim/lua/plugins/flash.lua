return {
  "https://github.com/folke/flash.nvim.git",
  event = "VeryLazy",
  opts = {},
  keys = {
    -- "leader+space" でジャンプモード開始
    { "<leader><space>", mode = { "n", "x", "o" }, function() require("flash").jump() end, desc = "Flash" },
    -- "S" でツリー形式の選択（コードブロック単位での選択など）
    { "S", mode = { "n", "x", "o" }, function() require("flash").treesitter() end, desc = "Flash Treesitter" },
    -- Remote操作
    { "r", mode = "o", function() require("flash").remote() end, desc = "Remote Flash" },
    { "R", mode = { "o", "x" }, function() require("flash").treesitter_search() end, desc = "Treesitter Search" },
    { "<c-s>", mode = { "c" }, function() require("flash").toggle() end, desc = "Toggle Flash Search" },
  },
}
