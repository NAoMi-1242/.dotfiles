-- lua/plugins/nvim-ufo.lua
return {
    "https://github.com/kevinhwang91/nvim-ufo",
    dependencies = "https://github.com/kevinhwang91/promise-async",
    event = "BufReadPost",
    opts = {
        fold_virt_text_handler = function(virtText, lnum, endLnum, width, truncate)
            local newVirtText = {}
            local suffix = " ・・・ "
            local sufWidth = vim.fn.strdisplaywidth(suffix)
            local targetWidth = width - sufWidth
            local curWidth = 0

            -- 1行目のテキスト（ハイライト付き）をそのまま newVirtText にコピー
            for _, chunk in ipairs(virtText) do
                local chunkText = chunk[1]
                local chunkWidth = vim.fn.strdisplaywidth(chunkText)
                if targetWidth > curWidth + chunkWidth then
                    table.insert(newVirtText, chunk)
                else
                    chunkText = truncate(chunkText, targetWidth - curWidth)
                    table.insert(newVirtText, { chunkText, chunk[2] })
                    chunkWidth = vim.fn.strdisplaywidth(chunkText)
                    break
                end
                curWidth = curWidth + chunkWidth
            end

            -- 最後に「 ... 」をハイライト付きで追加
            table.insert(newVirtText, { suffix, "Fold" })
            return newVirtText
        end,
    },
}
