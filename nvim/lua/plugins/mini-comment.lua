return {
  "https://github.com/nvim-mini/mini.comment.git",
  event = "VeryLazy",
  config = function()
    require('mini.comment').setup({
      -- オプション（必要に応じてカスタマイズ可能）
      options = {
        -- 空行をコメントアウトするかどうか
        ignore_blank_line = false,
        -- コメント行の先頭にスペースを入れるかどうか
        start_of_line = false,
        -- hooks を使って、Treesitterなどと連携した高度なコメント処理も可能
      },
      -- キーバインド設定（デフォルトで gc, gcc が設定されます）
      mappings = {
        -- ノーマルモード/ビジュアルモードでのコメント操作
        comment = 'gc',
        -- カレント行のコメント操作
        comment_line = 'gcc',
        -- ビジュアルモード（トグル）
        comment_visual = 'gc',
        -- mini.ai などのテキストオブジェクトと組み合わせる際の定義
        textobject = 'gc',
      },
    })
  end,
}
