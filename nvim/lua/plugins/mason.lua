return {
  "https://github.com/mason-org/mason.nvim.git",
  cmd = "Mason",
  build = ":MasonUpdate",
  opts = {
    ui = {
      border = "rounded",
      icons = {
        package_installed = "✓",
        package_pending = "➜",
        package_uninstalled = "✗"
      }
    }
  },
  config = function(_, opts)
    require("mason").setup(opts)
  end
}
