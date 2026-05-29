return {
  "https://github.com/kevinhwang91/nvim-hlslens.git",
  event = "VeryLazy",
  config = function()
    require('hlslens').setup()
  end,
}
