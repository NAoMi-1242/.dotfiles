return {
  "https://github.com/shellRaining/hlchunk.nvim.git",
  event = "VeryLazy",
  config = function()
    require("hlchunk").setup({
      chunk = { enable = true },
      indent = { enable = true },
    })
  end,
}
