return {
  {
    "https://github.com/seblyng/roslyn.nvim",
    ft = "cs",
    dependencies = {
      -- Roslyn本体をMasonで入れるためのカスタムレジストリ
      {
        "https://github.com/williamboman/mason.nvim",
        opts = {
          registries = {
            "github:mason-org/mason-registry",
            "github:Crashdummyy/mason-registry", -- Roslyn用
          },
        },
      },
    },
    config = function()
      require("roslyn").setup({
        -- 以前.zshrcに設定したdotnetパスが自動で使われます
        args = {
          "--logLevel=Information",
          "--extensionLogDirectory=" .. vim.fs.dirname(vim.lsp.get_log_path()),
          "--stdio",
        },
        config = {
          -- Unityプロジェクトの場合、プロジェクト全体の解析を有効にする
          settings = {
            ["csharp|background_analysis"] = {
              dotnet_compiler_diagnostics_scope = "fullSolution",
            },
          },
        },
      })
    end,
  },
  -- Unity側のファイル変更をLSPに伝えるための補助プラグイン
  {
    "https://github.com/khoido2003/roslyn-filewatch.nvim",
    enable = false,
    ft = "cs",
    opts = function()
      local root = vim.fs.root(0, { ".sln", ".csproj", ".git" })
      return{
        -- Unityエンジンのプリセットを有効化
        game_engine = "unity",
        watch_directory = root,
      }
    end,
  },
}
