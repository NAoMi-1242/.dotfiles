return {
  "https://github.com/nvim-lualine/lualine.nvim.git",
  event = "VeryLazy",
  priority = 900,
  dependencies = {
    "nvim-tree/nvim-web-devicons",
    "catppuccin",
  },

  config = function()
    -- LSP名を取得する関数
    local function lsp_name()
      local msg = 'No LSP'
      -- Neovim 0.10以降の推奨APIを使用
      local clients = vim.lsp.get_clients({ bufnr = 0 })
      if next(clients) == nil then
        return msg
      end
      local client_names = {}
      for _, client in pairs(clients) do
        table.insert(client_names, client.name)
      end
      return ' ' .. table.concat(client_names, ', ')
    end

    require("lualine").setup({
      options = {
        theme = "catppuccin",
        component_separators = { left = '', right = '' },
        section_separators = { left = '', right = '' },
      },
      sections = {
        lualine_x = {
          -- 自作したLSP表示コンポーネントを追加
          {
            lsp_name,
            color = { fg = '#ffffff', gui = 'bold' },
          },
          'encoding',
          'fileformat',
          'filetype',
        },
      },
    })
  end,
}
