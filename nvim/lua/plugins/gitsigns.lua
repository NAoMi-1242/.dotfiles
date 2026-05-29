return {
    "https://github.com/lewis6991/gitsigns.nvim.git",
    event = { "BufReadPost", "BufNewFile" },
    -- options
    opts = {
        signs = {
            add          = { text = '┃' },
            change       = { text = '┃' },
            delete       = { text = '_' },
            topdelete    = { text = '‾' },
            changedelete = { text = '~' },
            untracked    = { text = '┆' },
        },
        signs_staged = {
            add          = { text = '┃' },
            change       = { text = '┃' },
            delete       = { text = '_' },
            topdelete    = { text = '‾' },
            changedelete = { text = '~' },
            untracked    = { text = '┆' },
        },
        signs_staged_enable = true,
        signcolumn = true,  -- Toggle with `:Gitsigns toggle_signs`
        numhl      = false, -- Toggle with `:Gitsigns toggle_numhl`
        linehl     = false, -- Toggle with `:Gitsigns toggle_linehl`
        word_diff  = false, -- Toggle with `:Gitsigns toggle_word_diff`
        watch_gitdir = {
            follow_files = true
        },
        auto_attach = true,
        attach_to_untracked = false,
        current_line_blame = false, -- Toggle with `:Gitsigns toggle_current_line_blame`
        current_line_blame_opts = {
            virt_text = true,
            virt_text_pos = 'eol', -- 'eol' | 'overlay' | 'right_align'
            delay = 1000,
            ignore_whitespace = false,
            virt_text_priority = 100,
            use_focus = true,
        },
        current_line_blame_formatter = '<author>, <author_time:%R> - <summary>',
        sign_priority = 6,
        update_debounce = 100,
        status_formatter = nil, -- Use default
        max_file_length = 40000, -- Disable if file is longer than this (in lines)
        preview_config = {
            -- Options passed to nvim_open_win
            style = 'minimal',
            relative = 'cursor',
            row = 0,
            col = 1
        },
    -- keymaps
    on_attach = function(bufnr)
        local gitsigns = require('gitsigns')

        local function map(mode, l, r, opts)
            opts = opts or {}
            opts.buffer = bufnr
            vim.keymap.set(mode, l, r, opts)
        end

        -- Navigation
        map('n', ']c', function()
            if vim.wo.diff then
                vim.cmd.normal({']c', bang = true})
            else
                gitsigns.nav_hunk('next')
            end
        end, {desc = "Next Hunk"})

        map('n', '[c', function()
            if vim.wo.diff then
                vim.cmd.normal({'[c', bang = true})
            else
                gitsigns.nav_hunk('prev')
            end
        end, {desc = "Prev Hunk"})

        -- Actions
        map('n', '<leader>hs', gitsigns.stage_hunk, {desc = "Stage Hunk"})
        map('n', '<leader>hr', gitsigns.reset_hunk, {desc = "Reset Hunk"})

        map('v', '<leader>hs', function()
            gitsigns.stage_hunk({ vim.fn.line('.'), vim.fn.line('v') })
        end, {desc = "Stage Hunk"})

        map('v', '<leader>hr', function()
            gitsigns.reset_hunk({ vim.fn.line('.'), vim.fn.line('v') })
        end, {desc = "Reset Hunk"})

        map('n', '<leader>hS', gitsigns.stage_buffer, {desc = "Stage Buffer"})
        map('n', '<leader>hR', gitsigns.reset_buffer, {desc = "Reset Buffer"})
        map('n', '<leader>hp', gitsigns.preview_hunk, {desc = "Preview Hunk"})
        map('n', '<leader>hi', gitsigns.preview_hunk_inline, {desc = "Preview Hunk Inline"})

        map('n', '<leader>hb', function()
            gitsigns.blame_line({ full = true })
        end, {desc = "Blame Line (Full)"})

        map('n', '<leader>hd', gitsigns.diffthis, {desc = "Diff (vs Index)"})

        map('n', '<leader>hD', function()
            gitsigns.diffthis('~')
        end, {desc = "Diff (vs Last Commit)"})

        map('n', '<leader>hQ', function() gitsigns.setqflist('all') end, {desc = "Project Hunks to QF"})
        map('n', '<leader>hq', gitsigns.setqflist, {desc = "Buffer Hunks to QF"})

        -- Toggles
        map('n', '<leader>tb', gitsigns.toggle_current_line_blame, {desc = "Toggle Blame"})
        map('n', '<leader>tw', gitsigns.toggle_word_diff, {desc = "Toggle Hunks"})

        -- Text object
        map({'o', 'x'}, 'ih', gitsigns.select_hunk, {desc = "Inner Hunk (Text Object)"})
    end
    },
}
