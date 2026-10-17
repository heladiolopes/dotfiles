--
-- Configure Neo-tree file and buffer explorers.
--
return {
  "nvim-neo-tree/neo-tree.nvim",
  branch = "v3.x",
  lazy = false,
  dependencies = { "nvim-lua/plenary.nvim", "nvim-tree/nvim-web-devicons", "MunifTanjim/nui.nvim" },

  opts = {
    close_if_last_window = true,
    filesystem = {
      hijack_netrw_behavior = "open_default",
      follow_current_file = { enabled = true },
      -- Show dotfiles while keeping ignored files and Git internals out of view.
      filtered_items = {
        visible = false,
        hide_dotfiles = false,
        hide_gitignored = true,
        hide_by_name = { ".git" }
      },
    },
    buffers = { follow_current_file = { enabled = true } },
    window = {
      mappings = {
        ["l"] = "open",
        ["h"] = "close_node",
        ["<Right>"] = "open",
        ["<Left>"] = "close_node",
        ["<Esc>"] = "close_window"
      }
    },
  },

  keys = {
    { "<leader>et", "<Cmd>Neotree filesystem toggle left<CR>", desc = "Toggle explorer" },
    { "<leader>er", "<Cmd>Neotree filesystem reveal left<CR>", desc = "Reveal current file" },
    { "<leader>eb", "<Cmd>Neotree buffers toggle left<CR>", desc = "Open buffer tree" },
  },
}
