return {
    {
        "https://github.com/luukvbaal/statuscol.nvim",
        event = { "BufReadPre", "BufNewFile" },
        config = function()
            local builtin = require("statuscol.builtin")
            require("statuscol").setup({
                ft_ignore = { "help", "terminal", "neo-tree", "alpha", "NvimTree" },
                relculright = true,
                segments = {
                    -- 1. GitSigns (一番左)
                    {
                        sign = { namespace = { "gitsigns" }, colwidth = 1 },
                        click = "v:lua.ScSa",
                        maxwidth = 1,
                        colwidth = 1,
                    },
                    -- 2. Diagnostics (旗などのアイコン)
                    {
                        sign = { namespace = { "diagnostic" }, colwidth = 1 },
                        click = "v:lua.ScSa",
                        maxwidth = 1,
                        colwidth = 1,
                    },
                    -- 3. Fold (最小限の幅)
                    {
                        text = { builtin.foldfunc },
                        click = "v:lua.ScFa",
                        maxwidth = 1,
                        colwidth = 1,
                    },
                    -- 4. 行番号
                    {
                        text = { builtin.lnumfunc, " " },
                        click = "v:lua.ScLa",
                    },
                },
            })
        end,
    }
}
