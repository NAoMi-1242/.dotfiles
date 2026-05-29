return {
  "https://github.com/dominikduda/vim_current_word.git",
  event = "BufReadPost",
  config = function()
    -- ハイライトの色を控えめに設定（検索ハイライトと混同しないように）
    vim.api.nvim_set_hl(0, "CurrentWord", { underline = true, bg = "#313244" })
    vim.g.vim_current_word_enabled = 1
  end
}
