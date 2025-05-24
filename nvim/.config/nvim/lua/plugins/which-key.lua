return {
  "folke/which-key.nvim",
  event = "VimEnter",
  opts = {
    preset = "helix",
    delay = 0,
    spec = {
      { "<leader>b", group = "BufferLine" },
      { "<leader>f", group = "Telescope" },
      { "<leader>g", group = "Git" },
    },
  },
  keys = {
    {
      "<leader>?",
      function()
        require("which-key").show({ global = false })
      end,
      desc = "Which-Key: Buffer Local Keymaps",
    },
  },
}
