return {
  "nvim-telescope/telescope.nvim",
  event = "VimEnter",
  tag = "0.1.8",

  dependencies = {
    { "nvim-lua/plenary.nvim" },
    {
      "nvim-telescope/telescope-fzf-native.nvim",
      build = "make",
      cond = function()
        return vim.fn.executable("make") == 1
      end,
    },
    { "nvim-telescope/telescope-ui-select.nvim" },
    { "nvim-tree/nvim-web-devicons", enabled = vim.g.have_nerd_font },
  },

  config = function()
    -- Telescope Configuration
    require("telescope").setup({
      defaults = {
        prompt_prefix = ">> ",
        selection_caret = "-> ",
        winblend = 10,
        sorting_strategy = "ascending",
        layout_strategy = "horizontal",
        layout_config = { prompt_position = "top" },
      },
      pickers = {
        keymaps = { theme = "dropdown" },
        colorscheme = { theme = "dropdown" },
      },
      extensions = {
        ["ui-select"] = {
          require("telescope.themes").get_dropdown({}),
        },
      },
    })

    -- Enable Telescope extensions if they are installed
    pcall(require("telescope").load_extension, "fzf")
    pcall(require("telescope").load_extension, "ui-select")

    -- Keymaps
    -- stylua: ignore start
    local builtin = require("telescope.builtin")
    vim.keymap.set("n", "<leader>ff", builtin.find_files,  { desc = "Find Files"   })
    vim.keymap.set("n", "<leader>fk", builtin.keymaps,     { desc = "Find Keymaps" })
    vim.keymap.set("n", "<leader>fg", builtin.live_grep,   { desc = "Find Grep"    })
    vim.keymap.set("n", "<leader>fr", builtin.oldfiles,    { desc = "Find Recent"  })
    vim.keymap.set("n", "<leader>fb", builtin.buffers,     { desc = "Find Buffers" })
    vim.keymap.set("n", "<leader>fh", builtin.help_tags,   { desc = "Find Help "   })
    vim.keymap.set("n", "<leader>ft", builtin.colorscheme, { desc = "Find Themes"  })

    vim.keymap.set("n", "<leader>gs", builtin.git_status,  { desc = "Git Status"   })
    -- stylua: ignore end
  end,
}
