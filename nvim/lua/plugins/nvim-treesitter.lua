return {
    "https://github.com/nvim-treesitter/nvim-treesitter",
    branch = "main",
    dependencies = {
        "https://github.com/nvim-treesitter/nvim-treesitter-textobjects",
    },
    init = function()
        -- Windowsのtr問題を解決するための前処理
        if vim.loop.os_uname().sysname == "Windows_NT" then
            -- PATHの先頭に System32 を追加して、Scoop版より先に標準tarを見つけさせる
            vim.env.PATH = "C:/Windows/System32;" .. vim.env.PATH

        -- ╭─────────────────────────────────────────────────────────╮
        -- │ コンパイラをgccにするための設定                         │
        -- ╰─────────────────────────────────────────────────────────╯
            -- $USERPROFILEを取得
            local home = vim.env.USERPROFILE
            local gcc_path = home .. "/scoop/apps/msys2/current/ucrt64/bin"
            gcc_path = gcc_path:gsub("/", "\\")
            vim.env.PATH = gcc_path .. ";" .. vim.env.PATH
            vim.env.CC = "gcc"
            vim.env.CXX = "g++"

            -- (念のため) Treesitterに「ダウンロードはgitを使え」と指示する
            -- tarの解凍エラーを回避するもう一つの強力な手段です
            require('nvim-treesitter.install').prefer_git = true
        end
    end,
    event = {"BufReadPre", "BufNewFile"},
        config = function()
        require("nvim-treesitter").setup({})
        vim.api.nvim_create_autocmd("FileType", {
        group = vim.api.nvim_create_augroup("vim-treesitter-start", {}),
        callback = function(ctx)
            -- 必要に応じて`ctx.match`に入っているファイルタイプの値に応じて挙動を制御
            -- `pcall`でエラーを無視することでパーサーやクエリがあるか気にしなくてすむ
            pcall(vim.treesitter.start)
        end,
        })
    end
}
