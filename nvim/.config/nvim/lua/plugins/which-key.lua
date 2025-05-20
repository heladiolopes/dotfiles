return {
  "folke/which-key.nvim",
  event = "VimEnter",
  opts = {
    preset = "helix",
    delay = 0,
    spec = {
      { "<leader>g", group = "LSP" },
      { "<leader>b", group = "BufferLine" },
      { "<leader>f", group = "Telescope" },
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
