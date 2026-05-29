return {
  "https://github.com/saghen/blink.cmp.git",
  -- 最新のリリースタグを使用（Rustのビルド済みバイナリをダウンロードしてくれます）
  version = "*",
  event = "InsertEnter",

  opts = {
    -- キーマップの設定（'default', 'super-tab', 'enter' から選べます）
    keymap = { preset = "default" },

    -- 補完ソースの定義
    sources = {
      default = { "lsp", "path", "snippets", "buffer" },
    },

    -- 外観の設定（枠線を付けるなど）
    completion = {
      menu = { border = "rounded" },
      documentation = { window = { border = "rounded" } },
    },

    -- 実験的な機能（ゴーストテキストを表示したい場合は有効化）
    -- ghost_text = { enabled = true },
  },
}
