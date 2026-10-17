--
-- Configure key hints, TODO highlighting, indentation detection, and tmux navigation.
--
return {
  {
    "folke/which-key.nvim",
    event = "VeryLazy",
    opts = {
      preset = "helix",
      delay = 300,
      spec = {
        { "<leader>b", group = "Buffers" },
        { "<leader>c", group = "Code" },
        { "<leader>d", group = "Debug" },
        { "<leader>e", group = "Explorer" },
        { "<leader>f", group = "Find" },
        { "<leader>g", group = "Git" },
        { "<leader>s", group = "Splits" },
        { "<leader>x", group = "Problems" },
      },
    },
    keys = {
      { "<leader>?", function() require("which-key").show({ global = false }) end, desc = "Buffer-local keymaps" },
    },
  },
  {
    "folke/todo-comments.nvim",
    event = { "BufReadPost", "BufNewFile" },
    dependencies = { "nvim-lua/plenary.nvim" },
    opts = {}
  },
  {
    "NMAC427/guess-indent.nvim",
    event = { "BufReadPost", "BufNewFile" },
    opts = {}
  },
  {
    "christoomey/vim-tmux-navigator",
    keys = {
      { "<C-h>", "<Cmd>TmuxNavigateLeft<CR>", desc = "Focus left pane" },
      { "<C-j>", "<Cmd>TmuxNavigateDown<CR>", desc = "Focus lower pane" },
      { "<C-k>", "<Cmd>TmuxNavigateUp<CR>", desc = "Focus upper pane" },
      { "<C-l>", "<Cmd>TmuxNavigateRight<CR>", desc = "Focus right pane" },
    },
    init = function() vim.g.tmux_navigator_no_mappings = 1 end,
  },
}
