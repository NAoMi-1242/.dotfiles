return {
  "https://github.com/stevearc/oil.nvim.git",
  -- アイコン表示のために nvim-web-devicons が必要です
  dependencies = { "nvim-tree/nvim-web-devicons" },
  keys = {
    { "-", "<CMD>Oil<CR>", desc = "Open parent directory" },
  },
  config = function()
    local oil = require("oil")

    oil.setup({
      -- デフォルトの設定で十分強力ですが、いくつか使いやすく調整します
      default_file_explorer = true,
      columns = {
        "icon",
        -- "permissions",
        -- "size",
        -- "mtime",
      },
      -- ウィンドウの設定
      view_options = {
        -- ドットファイル（.gitignoreなど）を表示するかどうか
        show_hidden = true,
      },
      keymaps = {
        -- Ctrl+sを無効
        ["<C-s>"] = false,
        ["<C-h>"] = false,
        -- leader+vを垂直分割セレクトに割り当て
        ["<leader>v"] = {
          callback = function()
            oil.select({ vertical = true })
          end,
          desc = "Open the entry under the cursor { vertical = true }",
        },
        ["<leader>h"] = {
          callback = function()
            oil.select({ horizontal = true })
          end,
          desc = "Open the entry under the cursor { horizontal = true }",
        },
      }
    })
  end,
}
