-- lua/utils/makeRelpath.lua

local M = {}

function M.relpath(path, base)
    local sep = "/"

    local function split(p)
        local t = {}
        for part in string.gmatch(p, "[^" .. sep .. "]+") do
            table.insert(t, part)
        end
        return t
    end

    path = path:gsub("\\", "/")
    base = base:gsub("\\", "/")

    local path_parts = split(path)
    local base_parts = split(base)

    local i = 1
    while path_parts[i] and base_parts[i] and path_parts[i] == base_parts[i] do
        i = i + 1
    end

    local result = {}

    for j = i, #base_parts do
        table.insert(result, "..")
    end

    for j = i, #path_parts do
        table.insert(result, path_parts[j])
    end

    return (#result > 0) and table.concat(result, sep) or "."
end

function M.relpath_with_dot(path, base)
    local rel = M.relpath(path, base)

    if rel == "." then
        return vim.fn.fnamemodify(path, ":t")
    end

    if not rel:match("^%.%.") and not rel:match("^/") then
        return "./" .. rel
    end

    return rel
end

function M.git_root()
    local handle = io.popen("git rev-parse --show-toplevel 2>nul")
    if not handle then return nil end

    local result = handle:read("*l")
    handle:close()

    if result and result ~= "" then
        return result:gsub("\\", "/")
    end

    return nil
end

function M.relpath_from_git(path)
    local root = M.git_root()
    if not root then return "N/A" end
    return M.relpath(path, root)
end

function M.to_file_url(path)
    path = path:gsub("\\", "/")
    return "file:///" .. path
end

function M.to_unity_assets(path)
    local root = M.git_root()
    if not root then return "N/A" end

    local rel = M.relpath(path, root)
    local assets = rel:match("Project:Assets/.*")

    return assets or "N/A"
end

return M
