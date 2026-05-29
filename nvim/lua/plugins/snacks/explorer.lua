local rel = require("utils.makeRelpath")

local M = {}

M.actions = {
    copy_tree = function()
        local lines = vim.api.nvim_buf_get_lines(0, 0, -1, false)

        local filtered = {}
        for _, line in ipairs(lines) do
            if line:match("%S") then
                table.insert(filtered, line)
            end
        end
        vim.fn.setreg("+", filtered)
        vim.fn.setreg('"', filtered)

        vim.notify("Yanked explorer tree")
    end,
    copy_path = function(_, item)
        local modify = vim.fn.fnamemodify
        local filepath = item.file

        filepath = filepath:gsub("\\", "/")

        -- current file
        local current = vim.g.last_real_file or ""
        local current_dir = ""

        if current ~= "" then
            current = current:gsub("\\", "/")
            current_dir = modify(current, ":h")
        end

        local relative_to_buffer = "n/a"

        if current_dir ~= "" then
            relative_to_buffer = rel.relpath_with_dot(filepath, current_dir)
        end

        -- extra paths
        local git_path   = rel.relpath_from_git and rel.relpath_from_git(filepath) or "n/a"
        local url_path   = rel.to_file_url and rel.to_file_url(filepath) or "n/a"
        local unity_path = rel.to_unity_assets and rel.to_unity_assets(filepath) or "n/a"

        local entries = {
            { label = "relative to current file", value = relative_to_buffer },
            { label = "filename", value = modify(filepath, ":t") },
            { label = "relative to cwd", value = modify(filepath, ":.") },
            { label = "absolute path", value = modify(filepath, ":p") },
            { label = "relative to home", value = modify(filepath, ":~") },
            { label = "git root", value = git_path },
            { label = "unity assets", value = unity_path },
            { label = "file url", value = url_path },
        }

        -- ファイルのみ追加
        if vim.fn.isdirectory(filepath) == 0 then
            table.insert(entries, {
                label = "filename without extension",
                value = modify(filepath, ":t:r"),
            })
            table.insert(entries, {
                label = "extension",
                value = modify(filepath, ":e"),
            })
        end

        -- 最大ラベル長を取得
        local max_len = 0
        for _, e in ipairs(entries) do
            if #e.label > max_len then
                max_len = #e.label
            end
        end

        -- ui生成
        local items = {}
        for i, e in ipairs(entries) do
            items[i] = string.format(
                "%-" .. max_len .. "s : %s",
                e.label,
                e.value
            )
        end

        vim.ui.select(items, { prompt = "copy path format:" }, function(_, i)
            if not i then return end

            local result = entries[i].value
            vim.fn.setreg("+", result)
            vim.fn.setreg('"', result)

            vim.notify("copied: " .. result)
        end)
    end,
}

M.source = {
    hidden = true,
    layout = { layout = { width = 30 } },
    win = {
        list = {
            keys = {
                ["a"] = false,
                ["d"] = false,
                ["m"] = false,
                ["r"] = false,
                ["c"] = false,
                ["l"] = false,

                ["<C-s>"] = false,
                ["<C-v>"] = false,
                ["<C-h>"] = false,
                ["<C-u>"] = false,
                ["<C-d>"] = false,

                ["<bs>"] = false,
                ["-"] = "explorer_up",

                ["y"] = "copy_path",
                ["Y"] = "copy_tree"
            }
        },
    },
    actions = M.actions,
}

return M
