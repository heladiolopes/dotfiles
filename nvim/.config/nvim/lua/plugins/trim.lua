return {
  {
    "cappyzawa/trim.nvim",
    event = "VeryLazy",
    config = function()
      require("trim").setup({
        -- Ignore types
        ft_blocklist = { "markdown" },
        trim_on_write = true,
        trim_last_line = true,
        trim_current_line = false,
        highlight = true,
      })
    end,
  },
}
