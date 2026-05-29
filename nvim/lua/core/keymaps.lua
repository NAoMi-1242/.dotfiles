local keymap = vim.keymap

-- インサートモードを jk で抜ける
keymap.set("i", "jk", "<ESC>", { noremap = true, silent = true, desc = "Exit insert mode" })

-- Ctrl + s で保存(:w)
keymap.set("n", "<C-s>", ":w<CR>", { silent = true, desc = "Save file" })

-- デフォルトのウィンドウ操作 Ctrl + w を leader + w に割り当て
keymap.set('n', '<leader>w', "<C-w>" , { desc = 'Window operations' })

-- 【コピー】選択範囲、またはモーションをシステムクリップボードに保存
vim.keymap.set({'n', 'v'}, '<leader>y', '"+y', { desc = 'Yank to system clipboard' })

-- 【一行コピー】
vim.keymap.set('n', '<leader>yy', '"+yy', { desc = 'Yank line to system clipboard' })

-- 【貼り付け】システムクリップボードから貼り付け
-- dd などで消した直後でも、外部のコピーを優先して貼れるようになります
vim.keymap.set({'n', 'v'}, '<leader>p', '"+p', { desc = 'Paste from system clipboard' })

-- 現在のファイルの親ディレクトリを Oil で開く
vim.keymap.set("n", "-", "<CMD>Oil<CR>", { desc = "Open parent directory" })

-- Esc 2回でハイライトを消す
vim.keymap.set('n', '<Esc><Esc>', '<cmd>nohlsearch<CR>', { silent = true })
