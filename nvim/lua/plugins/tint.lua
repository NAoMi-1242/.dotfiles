return {
  "https://github.com/levouh/tint.nvim.git",
  -- 必要に応じてイベントを指定（例：読み込みを遅延させる場合）
  event = "VeryLazy",
  priority = 900,
  config = function()
    require("tint").setup({
      -- ここに設定を記述します
      amt = -30,              -- 暗くする割合
      keep_executable = false, -- フォーカス外のペインでアニメーション等を維持するか
    })
  end,
}
