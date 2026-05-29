return {
  "https://github.com/romgrk/barbar.nvim.git",
  event = "VeryLazy",
  priority = 900,
  dependencies = {
    "lewis6991/gitsigns.nvim",
    "nvim-tree/nvim-web-devicons",
  },
  init = function() vim.g.barbar_auto_setup = false end,
  opts = {
    -- nvim-treeが開いている時にタブをずらす設定
    sidebar_filetypes = {
      ['nvim-tree'] = { event = 'BufWipeout' },
    },
  },
  keys = {
    -- タブの移動 (Alt + , または .)
    { "<A-,>", "<Cmd>BufferPrevious<CR>", desc = "Previous Tab" },
    { "<A-.>", "<Cmd>BufferNext<CR>", desc = "Next Tab" },

    -- タブを閉じる (Alt + c)
    { "<A-c>", "<Cmd>BufferClose<CR>", desc = "Close Tab" },
    { "<leader>xc", "<Cmd>BufferClose<CR>", desc = "Close Tab" },
    { "<leader>xa", "<Cmd>BufferCloseAllButCurrent<CR>", desc = "Close Tab all but current" },
  },
}
