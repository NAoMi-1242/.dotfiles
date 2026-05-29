return {
  "https://github.com/kevinhwang91/nvim-bqf.git",
  ft = "qf", -- Quickfixウィンドウが開いたときだけ読み込む
  dependencies = {
    -- プレビュー内でさらに「あいまい検索」をしたい場合はこれが必要
    { 'junegunn/fzf' }
  },
  opts = {
    preview = {
      win_height = 12,
      win_vheight = 12,
      delay_syntax = 80,
      border = "rounded", -- 他のプラグインと統一
      show_scroll_bar = false,
    },
    -- リスト内の見た目を調整
    func_map = {
      vsplit = "v", -- 垂直分割で開く
      ptoggle = "p", -- プレビューのオンオフ
      stoggleup = "K", -- プレビュー画面のスクロール
      stoggledown = "J",
    },
  },
}
