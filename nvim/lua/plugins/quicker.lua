return {
  "https://github.com/stevearc/quicker.nvim.git",
  ft = "qf",
  ---@module "quicker"
  ---@type quicker.SetupOptions
  opts = {
    -- キーバインドの設定
    keys = {
      -- 検索結果の前後の行（コンテキスト）を表示/非表示
      { ">", function() require("quicker").expand() end, desc = "Expand quickfix content" },
      { "<", function() require("quicker").collapse() end, desc = "Collapse quickfix content" },
    },
    -- ハイライトの設定
    highlight = {
      -- 現在の行を強調
      current_line = true,
      -- 以前の検索結果との境界をわかりやすくする
      borders = {
        top = true,
        bottom = true,
      },
    },
    -- コンテキスト表示の設定
    max_context_lines = 3,
  },
}
