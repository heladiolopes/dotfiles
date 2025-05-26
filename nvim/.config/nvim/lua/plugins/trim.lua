return {
  {
    "cappyzawa/trim.nvim",
    event = "VeryLazy",
    config = function()
      require("trim").setup({
        -- Ignore types
        ft_blocklist = { "markdown" },
        trim_on_write = false,
        trim_last_line = false,
      })
    end,
  },
}
