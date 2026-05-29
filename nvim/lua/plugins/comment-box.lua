return {
  "https://github.com/LudoPinelli/comment-box.nvim.git",
  event = "VeryLazy",
  keys = {
    { "<leader>ac", "<cmd>CBccbox<cr>", mode = { "n", "v" }, desc = "Comment Box Center" },
    { "<leader>al", "<cmd>CBllbox<cr>", mode = { "n", "v" }, desc = "Comment Box Left" },
  },
}
