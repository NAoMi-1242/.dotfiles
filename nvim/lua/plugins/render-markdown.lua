return {
  "https://github.com/MeanderingProgrammer/render-markdown.nvim.git",
  dependencies = { "nvim-treesitter/nvim-treesitter", "nvim-tree/nvim-web-devicons" },
  ft = { "markdown" },
  opts = {
    -- Snacks.image と連携して画像を表示
    latex = { enabled = true }, -- 数式をレンダリング
    heading = {
      icons = { "󰲡 ", "󰲣 ", "󰲥 ", "󰲧 ", "󰲩 ", "󰲫 " },
    },
  },
}
