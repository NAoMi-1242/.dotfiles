return {
  "https://github.com/chrisgrieser/nvim-various-textobjs",
  opts = { useDefaultKeymaps = false },
  keys = {
    -- 1. subword (s)
    { "is", function() require("various-textobjs").subword("inner") end, mode = { "o", "x" }, desc = "inner subword" },
    { "as", function() require("various-textobjs").subword("outer") end, mode = { "o", "x" }, desc = "around subword" },

    -- 2. path (P)
    { "iP", function() require("various-textobjs").path("inner") end, mode = { "o", "x" }, desc = "inner path" },
    { "aP", function() require("various-textobjs").path("outer") end, mode = { "o", "x" }, desc = "around path" },

    -- 3. lineCharacter (l) ※これが vil の正体
    { "iL", function() require("various-textobjs").lineCharacterwise("inner") end, mode = { "o", "x" }, desc = "inner line character" },

    -- 4. chainMember (m)
    { "im", function() require("various-textobjs").chainMember("inner") end, mode = { "o", "x" }, desc = "inner chain member" },
    { "am", function() require("various-textobjs").chainMember("outer") end, mode = { "o", "x" }, desc = "around chain member" },

    -- 5. value / key (v / k)
    { "iv", function() require("various-textobjs").value("inner") end, mode = { "o", "x" }, desc = "inner value" },
    { "av", function() require("various-textobjs").value("outer") end, mode = { "o", "x" }, desc = "around value" },
    { "ik", function() require("various-textobjs").key("inner") end, mode = { "o", "x" }, desc = "inner key" },
    { "ak", function() require("various-textobjs").key("outer") end, mode = { "o", "x" }, desc = "around key" },

    -- 6. url (L)
    { "iu", function() require("various-textobjs").url() end, mode = { "o", "x" }, desc = "inner URL" },

    -- 7. number (n)
    { "iN", function() require("various-textobjs").number("inner") end, mode = { "o", "x" }, desc = "inner number" },
    { "aN", function() require("various-textobjs").number("outer") end, mode = { "o", "x" }, desc = "around number" },

    -- 8. diagnostic (d)
    { "id", function() require("various-textobjs").diagnostic() end, mode = { "o", "x" }, desc = "inner diagnostic" },

    -- 9. lastChange (g)
    { "ig", function() require("various-textobjs").lastChange() end, mode = { "o", "x" }, desc = "inner last change" },
  },
}
