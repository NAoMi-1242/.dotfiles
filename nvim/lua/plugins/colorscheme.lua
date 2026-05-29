return {
  {
    "https://github.com/catppuccin/nvim.git",
    name = "catppuccin",
    priority = 1000, -- 他のプラグインより先に読み込む
    config = function()
      require("catppuccin").setup({
        flavour = "mocha", -- latte, frappe, macchiato, mocha から選択
        transparent_background = true, -- 背景透過を有効にする（WezTermの透過を活かすため）
        integrations = {
          cmp = true,
          gitsigns = true,
          nvimtree = true,
          treesitter = true,
          notify = true,
          mini = {
            enabled = true,
            indentscope_color = "",
          },
        },
      })

      -- カラースキームを適用
      vim.cmd.colorscheme("catppuccin")
    end,
  },
}
