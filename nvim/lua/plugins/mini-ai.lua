return {
  "https://github.com/nvim-mini/mini.ai.git",
  event = "VeryLazy",
  opts = function()
    local ai = require("mini.ai")
    return{
      n_lines = 500,
      custom_textobjects = {
        -- textobject "function"
        f = ai.gen_spec.treesitter({
          a = "@function.outer",
          i = "@function.inner",
        }),
        -- textobject "class"
        c = ai.gen_spec.treesitter({
          a = "@class.outer",
          i = "@class.inner",
        }),
        -- disable iv, av
        v = false,
        -- textobject "sentence" s -> S
        S = ai.gen_spec.treesitter({
            a = '@sentence.outer',
            i = '@sentence.inner',
        }),
        s = false,
      },
    }
  end
}
