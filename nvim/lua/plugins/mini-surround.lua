return {
  "https://github.com/nvim-mini/mini.surround.git",
  event = "VeryLazy",
  config = function()
    require('mini.surround').setup({})
  end,
}
