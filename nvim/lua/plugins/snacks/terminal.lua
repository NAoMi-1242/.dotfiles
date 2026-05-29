return{
    -- toggletermのターミナル設定
    terminal = {
        enabled = true,
        -- 実行環境に応じてシェルを切り替える
        shell = (function()
            if vim.fn.has("win32") == 1 then
                return "powershell.exe" -- MSYS2が見つからない場合のバックアップ
            end
            -- WSL / Linux 環境
            return "bash"
        end)(),
        win = {
            keys = {
                term_normal = {
                    "<esc><esc>",
                    function(self)
                        self:hide()
                    end,
                    mode = "t",
                    desc = "Hide Terminal",
                }
            }
        }
    },
}
