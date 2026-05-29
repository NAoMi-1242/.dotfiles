return {
  "https://github.com/mason-org/mason-lspconfig.nvim.git",
  event = {"BufReadPre", "BufNewFile"},
  dependencies = {
    "mason-org/mason.nvim",
    "neovim/nvim-lspconfig",
    "saghen/blink.cmp",
  },
  config = function()
    -- 全てのLSPサーバーに共通の設定 (blink.cmp の能力を付与)
    local mason_lspconfig = require("mason-lspconfig")
    vim.lsp.config("*", {
      capabilities = require("blink.cmp").get_lsp_capabilities(),
      root_markers = { ".git" }, -- デフォルトのルート検知マーカー
    })

    -- サーバーのインストール管理
    mason_lspconfig.setup({
      ensure_installed = {
        "clangd",          -- C / C++
        "pyright",         -- Python
        "jdtls",           -- Java
        "ts_ls",           -- JavaScript / TypeScript (旧 tsserver)
        "rust_analyzer",   -- Rust
        "html",            -- HTML
        "cssls",           -- CSS
        "marksman",        -- Markdown
        "lua_ls",          -- Lua
      },
    })

    -- 各サーバーの個別設定 (Mason v2 + Neovim 0.11+ 向け新方式)
    -- Luaの設定（vimグローバル変数を認識させる）
    vim.lsp.config("lua_ls", {
      settings = {
        Lua = {
          diagnostics = { globals = { "vim" } },
        },
      },
    })

    -- C/C++ (clangd) の設定
    vim.lsp.config("clangd", {
      cmd = { "clangd", "--background-index", "--clang-tidy" },
    })

    -- Python (pyright) 設定
    vim.lsp.config("pyright", {})
  end
}
