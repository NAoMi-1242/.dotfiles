return{
    -- ダッシュボード（起動画面）
    dashboard = { enabled = true },
    -- インデントガイド（以前設定した listchars をより美しくします）
    indent = { enabled = false },
    -- 美しい通知表示
    notifier = {
        enabled = true,
        timeout = 6000
    },
    -- 入力UIの改善
    input = { enabled = true },
    -- スコープの強調表示
    scope = { enabled = true },
    -- 一時的なメモやコード片を書くためのスクラッチパッド
    scratch = { enabled = true },
    words = { enabled = true },
    -- 画像プレビューを有効化
    image = { enabled = true },
    -- その他の無効になっていた機能を必要に応じて有効化
    bigfile = { enabled = true },
    quickfile = { enabled = true },
    scroll = { enabled = false },

    -- explorerの設定
    explorer = {
        enabled = true,
        replace_netrw = true,
    },

    picker = {
        enabled = true,
        sources = {
            -- explorer.lua の設定を注入
            explorer = require("plugins.snacks.explorer").source,
        },
    },
}
