local opt = vim.opt

-- Leaderキーをspaceに変更
vim.g.mapleader = " "
vim.g.maplocalleader = " "

-- 見た目
opt.number = true         -- 行番号を表示
opt.relativenumber = true -- 相対行番号（j/k移動が楽になります）
opt.numberwidth = 1
opt.cursorline = true     -- 現在の行をハイライト
opt.termguicolors = true  -- TrueColor対応（WezTermなら必須）

-- インデント
opt.smartindent = true
opt.expandtab = true      -- タブをスペースに
opt.tabstop = 4           -- タブ幅
opt.shiftwidth = 4        -- 自動インデント幅

-- 折り畳みの設定
vim.o.foldenable = true
vim.o.foldmethod = "indent"
vim.o.foldcolumn = '1' -- 折りたたみ用の列を表示
vim.o.foldlevel = 99   -- 非常に高い値を設定することで、起動時に展開される
vim.o.foldlevelstart = 99

-- 折りたたみの記号をカスタマイズ
vim.opt.fillchars = {
  foldopen = "|",
  foldclose = "-",
  foldsep = " ",
}

-- 不可視文字の表示の有効化
opt.list = true

-- 表示する文字のデザイン
opt.listchars = {
    tab = ">·",       -- タブを '» ' で表示
    trail = "·",      -- 行末の余分なスペースを '·' で表示
    nbsp = "␣",       -- 改行不可スペース
    -- eol = "↲",    -- 改行記号を表示したい場合はコメントアウトを外す
}

-- 全角スペースを可視化する設定
-- 1. ハイライトグループの定義 (背景: 灰色, 文字: 黄色)
vim.api.nvim_set_hl(0, "ZenkakuSpace", {
  fg = "#f9e2af", -- 黄色
  bg = "#313244", -- 灰色 (CatppuccinのSurfaceに近い色)
  bold = true
})

-- 　
local ns_id = vim.api.nvim_create_namespace("ZenkakuSpace")

local function highlight_zenkaku()
  local bufnr = vim.api.nvim_get_current_buf()
  vim.api.nvim_buf_clear_namespace(bufnr, ns_id, 0, -1)
  local lines = vim.api.nvim_buf_get_lines(bufnr, 0, -1, false)
  for lnum, line in ipairs(lines) do
    -- 文字列の中から全角スペースの位置を探す
    local col = line:find("　", 1, true)
    while col do
      -- 仮想テキスト(overlay)を使って、全角スペースの上に「⬚」を重ねる
      vim.api.nvim_buf_set_extmark(bufnr, ns_id, lnum - 1, col - 1, {
        virt_text = { { "□", "ZenkakuSpace" } },
        virt_text_pos = "overlay",
      })
      col = line:find("　", col + 1, true)
    end
  end
end

-- 2. 自動的に実行されるように設定
vim.api.nvim_create_autocmd({ "BufWinEnter", "TextChanged", "TextChangedI" }, {
  group = vim.api.nvim_create_augroup("ZenkakuHighlight", { clear = true }),
  callback = function()
    highlight_zenkaku()
  end,
})

-- 直前に編集されたバッファを記憶
vim.api.nvim_create_autocmd("BufEnter", {
    callback = function()
        local buf = vim.api.nvim_get_current_buf()
        local name = vim.api.nvim_buf_get_name(buf)

        if name ~= "" and vim.bo[buf].buftype == "" then
            vim.g.last_real_file = name
        end
    end,
})

-- 検索
opt.ignorecase = true     -- 大文字小文字を区別しない
opt.smartcase = true      -- 大文字が含まれる場合は区別する

-- その他
opt.clipboard = "" -- クリップボードをOSと共有
opt.mouse = "a"               -- マウス操作を許可
