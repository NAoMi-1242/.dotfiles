return {
  "https://github.com/brenoprata10/nvim-highlight-colors.git",
  event = "VeryLazy",
  opts = {
    -- 表示形式の指定
    -- 'background': 文字の背景色 (デフォルト)
    -- 'foreground': 文字の色自体
    -- 'virtual': 文字の隣に小さな四角を表示 (VS Code風)
    render = 'virtual',

    -- virtualの時の記号 (■ などが一般的です)
    virtual_symbol = '■',

    -- CSS, Tailwind, RGB, Hexなどをサポート
    enable_named_colors = true,
    enable_tailwind = true,
  }
}
