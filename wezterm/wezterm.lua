local wezterm = require 'wezterm'
local config = wezterm.config_builder()

-- 【動的取得】Windowsのホームディレクトリパスとユーザー名を動的に取得
local win_home = wezterm.home_dir
local win_user = win_home:match("[^\\]+$") or "default"

config.automatically_reload_config = true
config.default_domain = 'WSL:Ubuntu'
config.launch_menu = {
    -- PowerShell (通常)
    {
        label = "PowerShell",
        args = { "pwsh.exe" },
        domain = { DomainName = "local" },
    },

    -- Windows PowerShell (通常)
    {
        label = "Windows PowerShell",
        args = { "powershell.exe" },
        domain = { DomainName = "local" },
    },

    -- Command Prompt (通常)
    {
        label = "Command Prompt",
        args = { "cmd.exe" },
        domain = { DomainName = "local" },
    },

    -- Windows Terminal PowerShell (管理者)
    {
        label = "Windows Terminal PowerShell (Admin)",
        args = {
            "powershell.exe",
            "-NoLogo",
            "-Command",
            "Start-Process wt.exe -Verb RunAs -ArgumentList 'new-tab pwsh.exe'"
        },
        domain = { DomainName = "local" },
    },

    -- Windows Terminal CMD (管理者)
    {
        label = "Windows Terminal CMD (Admin)",
        args = {
            "powershell.exe",
            "-NoLogo",
            "-Command",
            "Start-Process wt.exe -Verb RunAs -ArgumentList 'new-tab cmd.exe'"
        },
        domain = { DomainName = "local" },
    },
}

config.font_size = 17.0
config.use_ime = true

config.color_scheme = 'Gruvbox dark, medium (base16)' -- Dracula+
config.font = wezterm.font('Cica')

config.window_background_opacity = 0.8
-- config.win32_system_backdrop = 'Acrylic'

config.window_decorations = "INTEGRATED_BUTTONS|RESIZE"
config.window_frame = {
    inactive_titlebar_bg = "none",
    active_titlebar_bg = "none",
    font_size = 11.0,
}

config.inactive_pane_hsb = {
    saturation = 1.0,
    brightness = 0.6,
}

config.window_background_gradient = {
    colors = { "#222222" },
}

----------- タブバーの見た目設定 -----------
config.show_new_tab_button_in_tab_bar = false
config.show_close_tab_button_in_tabs = false
-- config.show_tabs_in_tab_bar = false
config.tab_max_width = 100

config.colors = {
    tab_bar = {
        inactive_tab_edge = "none",
    },
    split = '#282828',
}

local SOLID_LEFT_ARROW = wezterm.nerdfonts.ple_lower_right_triangle
local SOLID_RIGHT_ARROW = wezterm.nerdfonts.ple_upper_left_triangle


-- SNCの状態を保持するグローバル変数の初期化
if wezterm.GLOBAL.snc_status == nil then
    wezterm.GLOBAL.snc_status = "synced"
end

-- WSLパスから.gitを遡って検索する関数
local function find_git_root_wsl(wsl_path)
    local current = wsl_path
    while current and current ~= "/" and current ~= "" do
        local win_path
        if current:find("^/mnt/c/") then
            win_path = "C:" .. current:sub(7):gsub("/", "\\")
        else
            win_path = "\\\\wsl.localhost\\Ubuntu" .. current:gsub("/", "\\")
        end

        local f = io.open(win_path .. "\\.git\\HEAD", "r")
        if f then
            f:close()
            return current
        end
        local parent = current:match("(.*)/[^/]+$")
        if parent == "" then parent = "/" end
        if parent == current then break end
        current = parent
    end
    return nil
end

-- 要件に基づいたディレクトリタイトルを生成する関数
local function get_display_title(wsl_path)
    local path = wsl_path:gsub("/+$", "")
    if path == "" then return "/" end

    -- 【動的抽出】WSLのパスからユーザー名を自動で抜き出す (/home/xxx/ の xxx 部分)
    local wsl_user = path:match("^/home/([^/]+)")
    local wsl_home_path = wsl_user and ("/home/" .. wsl_user) or nil
    local win_home_wsl_path = "/mnt/c/Users/" .. win_user

    -- WSL側ホームディレクトリ自体の場合は「~」を返す
    if path == wsl_home_path then
        return "~"
    end

    -- 【修正箇所】Windows側ホームディレクトリ自体の場合はユーザー名（例: 81806）をそのまま返す
    if path == win_home_wsl_path then
        return win_user
    end

    local git_root = find_git_root_wsl(path)
    local title_result = ""
    
    if git_root then
        local parent = git_root:match("(.*)/[^/]+$") or ""
        if parent ~= "" then
            title_result = path:sub(#parent + 2)
        else
            title_result = path:sub(2)
        end
    else
        local current_name = path:match("[^/]+$") or "/"
        local parent = path:match("(.*)/[^/]+$") or ""
        local parent_name = parent:match("[^/]+$") or "/"
        if parent == "" then
            title_result = current_name
        else
            title_result = parent_name .. "/" .. current_name
        end
    end

    -- 【修正箇所】WSLのユーザー名のみ「~/」に置換（Windows側は「~/」に置換しない）
    if wsl_user then
        title_result = title_result:gsub("^" .. wsl_user .. "/", "~/")
    end
    
    return title_result
end

wezterm.on("format-tab-title", function(tab, tabs, panes, config, hover, max_width)
    local background = "#5c6d74"
    local foreground = "#FFFFFF"
    local edge_background = "none"
    if tab.is_active then
        background = "#ae8b2d"
        foreground = "#FFFFFF"
    end

    local edge_foreground = background

    local pane_id = tab.active_pane.pane_id
    local current_working_dir = tab.active_pane.current_working_dir

    if current_working_dir then
        local wsl_path = current_working_dir.path
        local path_key = "snc_path_" .. tostring(pane_id)
        local title_key = "snc_title_" .. tostring(pane_id)

        if wsl_path and wsl_path ~= wezterm.GLOBAL[path_key] then
            wezterm.GLOBAL[path_key] = wsl_path
            wezterm.GLOBAL[title_key] = get_display_title(wsl_path)
        end
    end

    -- メモリ上のSNC状態を取得してアイコンを決定
    local status = wezterm.GLOBAL.snc_status or "synced"
    local status_icon = "✅  "

    if status == "fetching" then
        status_icon = "🔄  "
    elseif status == "need_merge" then
        status_icon = "📥  "
    elseif status == "error" then
        status_icon = "⚠️  "
    elseif status == "conflict" then
        status_icon = "❌  "
    end

    -- フラットな文字列キーからタイトルを取得
    local title_key = "snc_title_" .. tostring(pane_id)
    local title_text = wezterm.GLOBAL[title_key] or tab.active_pane.title

    -- 現在アクティブな（開いている）タブのタイトルにのみ状態アイコンを付与
    if tab.is_active then
        title_text = status_icon .. title_text
    end

    local title = "   " .. title_text .. "   "

    return {
        { Background = { Color = edge_background } },
        { Foreground = { Color = edge_foreground } },
        { Text = SOLID_LEFT_ARROW },
        { Background = { Color = background } },
        { Foreground = { Color = foreground } },
        { Text = title },
        { Background = { Color = edge_background } },
        { Foreground = { Color = edge_foreground } },
        { Text = SOLID_RIGHT_ARROW },
    }
end)

----------- Ctrl + Shift + Z 用関数 & SNC状態同期 -----------
local function apply_zoom_style(window, is_zoomed)
    if is_zoomed then
        local dims = window:get_dimensions()
        local thickness = dims.pixel_width * 0.0275

        window:set_config_overrides({
            window_frame = {
                active_titlebar_bg = 'none',
                inactive_titlebar_bg = 'none',
                border_left_width = thickness,
                border_right_width = thickness,
                border_top_height = thickness,
                border_bottom_height = thickness,
                border_left_color = 'rgba(0,0,0,0.5)',
                border_right_color = 'rgba(0,0,0,0.5)',
                border_top_color = 'rgba(0,0,0,0.5)',
                border_bottom_color = 'rgba(0,0,0,0.5)',
            },
        })
    else
        window:set_config_overrides({})
    end
end

local function is_tab_zoomed(tab)
    if not tab then return false end
    for _, p in ipairs(tab:panes_with_info()) do
        if p.is_zoomed then
            return true
        end
    end
    return false
end

local last_check_time = 0

-- マウス操作や定期同期イベント
wezterm.on("update-status", function(window, pane)
    local tab = window:active_tab()
    apply_zoom_style(window, is_tab_zoomed(tab))

    -- 2秒ごとにWindows側の状態キャッシュファイルをチェック
    local current_time = os.time()
    if current_time - last_check_time >= 2 then
        last_check_time = current_time
        
        local filepath = win_home .. [[\.dotfiles\.status]]
        local f = io.open(filepath, "r")
        if f then
            local status = f:read("*l")
            f:close()
            if status then
                wezterm.GLOBAL.snc_status = status:gsub("%s+", "")
            end
        else
            wezterm.GLOBAL.snc_status = "synced"
        end
    end
end)

----------- キー割り当て -----------
config.keys = {
    -- Ctrl + C は、選択中ならコピーし、未選択なら SIGINT を送る
    {
        key = 'c',
        mods = 'CTRL',
        action = wezterm.action_callback(function(window, pane)
            local selectiontext = window:get_selection_text_for_pane(pane)
            if selectiontext ~= "" then
                window:perform_action(wezterm.action.CopyTo 'Clipboard', pane)
            else
                window:perform_action(wezterm.action.SendKey { key = 'c', mods = 'CTRL' }, pane)
            end
        end),
    },

    -- Ctrl + V でクリップボードから貼り付ける
    { key = 'v', mods = 'CTRL', action = wezterm.action.PasteFrom 'Clipboard' },

    -- Ctrl + Shift + V でペインを縦に分割する
    {
        key = 'v',
        mods = 'CTRL|SHIFT',
        action = wezterm.action.SplitVertical { domain = 'CurrentPaneDomain' },
    },

    -- Ctrl + Shift + H でペインを横に分割する
    {
        key = 'h',
        mods = 'CTRL|SHIFT',
        action = wezterm.action.SplitHorizontal { domain = 'CurrentPaneDomain' },
    },

    -- Ctrl + Shift + Alt + H でペインを横に分割してAntigravity CLIを起動
    {
        key = 'h',
        mods = 'CTRL|SHIFT|ALT',
        action = wezterm.action.SplitHorizontal { 
            domain = 'CurrentPaneDomain',
            args = {
                'zsh',
                '-ic',
                'agy'
            },
        },
    },

    -- Ctrl + Shift + X で現在のペインを確認付きで閉じる
    {
        key = 'x',
        mods = 'CTRL|SHIFT',
        action = wezterm.action_callback(function(window, pane)
            local pane_id = pane:pane_id()
            wezterm.GLOBAL["snc_title_" .. tostring(pane_id)] = nil
            wezterm.GLOBAL["snc_path_" .. tostring(pane_id)] = nil
            window:perform_action(wezterm.action.CloseCurrentPane { confirm = true }, pane)
        end),
    },
    -- Ctrl + Shift + Z でペインのズーム状態を切り替える
    {
        key = 'z',
        mods = 'CTRL|SHIFT',
        action = wezterm.action_callback(function(window, pane)
            local tab = window:active_tab()
            local currently_zoomed = is_tab_zoomed(tab)
            apply_zoom_style(window, not currently_zoomed)
            window:perform_action(wezterm.action.TogglePaneZoomState, pane)
        end),
    },
    -- Ctrl + Shift + P で Launcher を開く
    {
        key = 'p',
        mods = 'CTRL|SHIFT',
        action = wezterm.action.ShowLauncherArgs {
            flags = 'LAUNCH_MENU_ITEMS',
        },
    },
}

return config
