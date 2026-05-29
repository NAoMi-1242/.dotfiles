return {
  "https://github.com/neovim/nvim-lspconfig.git",
  event = { "BufReadPost", "BufNewFile" },
  config = function()
    -- 1. LSP共通キーマップの設定
    vim.api.nvim_create_autocmd("LspAttach", {
      callback = function(args)
        local opts = { buffer = args.buf }
        -- カーソル下の警告詳細をフローティングウィンドウで表示
        vim.keymap.set("n", "gl", vim.diagnostic.open_float, opts)
        -- 次の警告/前の警告へジャンプ
        vim.keymap.set("n", "[d", vim.diagnostic.goto_prev, opts)
        vim.keymap.set("n", "]d", vim.diagnostic.goto_next, opts)

        vim.keymap.set("n", "K", vim.lsp.buf.hover, opts)
        vim.keymap.set("n", "<leader>rn", vim.lsp.buf.rename, opts)
    end,
    })

    -- 2. 診断（エラー表示）の見た目設定
    vim.diagnostic.config({
      virtual_text = {           -- 行末にメッセージを表示する
        prefix = "●",
        spacing = 4,
      },
      signs = true,              -- 行番号の左側にアイコンを表示する
      underline = true,          -- エラー箇所に下線を引く
      update_in_insert = false,  -- 入力中は警告を更新しない（集中を妨げないため）
      severity_sort = true,      -- 重大なエラーを優先して表示する
      float = {
        border = "rounded",      -- 浮遊ウィンドウの枠線を丸くする
        source = "always",       -- どのLSPが出した警告か表示する (例: pyright)
      },
    })

    -- アイコン（Sign）のデザイン変更
    local signs = { Error = "✘", Warn = "▲", Hint = "⚑", Info = "»" }
    for type, icon in pairs(signs) do
      local hl = "DiagnosticSign" .. type
      vim.fn.sign_define(hl, { text = icon, texthl = hl, numhl = "" })
    end
  end
}
