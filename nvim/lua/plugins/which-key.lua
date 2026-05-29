return {
  "https://github.com/folke/which-key.nvim.git",
  lazy = false,
  priority = 900,
  init = function(_, opts)
    local wk = require("which-key")
    wk.setup(opts)

    wk.add({
      { "<leader>w", proxy = "<c-w>", group = "Window Operations" }
    })
    vim.o.timeout = true
    vim.o.timeoutlen = 300
  end,
  opts = {},
}
