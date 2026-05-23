-- local function load_local_neotree_config()
--   local path = vim.fn.getcwd() .. '/.neotree.lua'
--   if vim.fn.filereadable(path) == 1 then
--     return dofile(path)
--   end
--   return {}
-- end
--
-- local local_cfg = load_local_neotree_config()
--
return {
  "nvim-neo-tree/neo-tree.nvim",
  branch = "v3.x",
  dependencies = {
    { "nvim-lua/plenary.nvim" },
    { "nvim-tree/nvim-web-devicons" },
    { "MunifTanjim/nui.nvim" },
  },
  lazy = false, -- neo-tree will lazily load itself

  config = function()
    require("neo-tree").setup({
      close_if_last_window = false,
      filesystem = {
        hijack_netrw_behavior = "open_default",
        filtered_items = {
          hide_dotfiles = false,
          hide_gitignored = true,
          hide_by_name = {
            ".git",
          },
        },
      },
      buffers = {
        follow_current_file = {
          enable = true,
        },
      },
      window = {
        mappings = {
          ["l"] = "open",
          ["<Right>"] = "open",
          ["h"] = "close_node",
          ["<Left>"] = "close_node",
          ["<esc>"] = "close_window",
        },
      },
      default_component_configs = {
        container = {
          enable_character_fade = true,
        },
      },
    })

    -- Keymaps
    -- stylua: ignore start
    vim.keymap.set("n", "<leader>et", "<cmd>Neotree toggle<CR>",
      { desc = "Neotree: [E]xplorer [T]oggle", silent = true })
    vim.keymap.set("n", "<leader>er", "<cmd>Neotree filesystem reveal left<CR>",
      { desc = "Neotree: [E]xplorer [R]eveal File", silent = true })
    -- stylua: ignore end
  end,
}
