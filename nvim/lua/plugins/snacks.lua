return {
    "https://github.com/folke/snacks.nvim.git",
    priority = 1000,
    lazy = false,
    ---@type snacks.Config
    opts = function()
        return vim.tbl_deep_extend("force",
            require("plugins.snacks.core"),
            require("plugins.snacks.terminal")
        )
    end,

    keys = {
        -- --- ピッカー (Telescope代替) ---
        { "<leader>ff", function() Snacks.picker.files() end, desc = "Find Files" },
        { "<leader>fg", function() Snacks.picker.grep() end, desc = "Grep" },
        { "<leader>fl", function() Snacks.picker.lines() end, desc = "Lines" },
        { "<leader>fb", function() Snacks.picker.buffers() end, desc = "Buffers" },
        { "<leader>fr", function() Snacks.picker.recent() end, desc = "Recent" },
        { "<leader>sk", function() Snacks.picker.keymaps() end, desc = "Keymaps" },

        -- --- LSP
        { "gd", function() Snacks.picker.lsp_definitions() end, desc = "Goto Definition" },
        { "gr", function() Snacks.picker.lsp_references() end, nowait = true, desc = "References" },
        { "gi", function() Snacks.picker.lsp_implementations() end, desc = "Goto Implementation" },
        { "gy", function() Snacks.picker.lsp_type_definitions() end, desc = "Goto Type Definition" },

        -- --- lazygitの表示 ---
        { "<leader>gg", function() Snacks.lazygit() end, desc = "Lazygit" },
        { "<leader>gf", function() Snacks.lazygit.log_file() end, desc = "Lazygit Current File History" },
        { "<leader>gl", function() Snacks.lazygit.log() end, desc = "Lazygit Log " },

        -- --- explorer ---
        { "<leader>e", function() Snacks.explorer() end, desc = "File explorer (Snacks)" },

        -- --- 便利なユーティリティ ---
        -- 通知履歴の確認
        { "<leader>un", function() Snacks.notifier.show_history() end, desc = "Notification History" },
        -- スクラッチパッド (大学の課題のアイデアメモなどに便利！)
        { "<leader>sc", function() Snacks.scratch() end, desc = "Scratchpad" },
        { "<leader>sp", function() Snacks.scratch.select() end, desc = "Scratchpad picker" },
        -- ターミナルのトグル (Neovim内で即座にシェルを叩く)
        { "<leader>tt", function() Snacks.terminal() end, desc = "Toggle Terminal" },
    },
}
