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
    --  See `:help telescope.builtin`
    -- stylua: ignore start
    local builtin = require("telescope.builtin")
    vim.keymap.set("n", "<leader>ff", builtin.find_files,  { desc = "Telescope: [F]ind [F]iles"   })
    vim.keymap.set("n", "<leader>fk", builtin.keymaps,     { desc = "Telescope: [F]ind [K]eymaps" })
    vim.keymap.set("n", "<leader>fg", builtin.live_grep,   { desc = "Telescope: [F]ind [G]rep"    })
    vim.keymap.set("n", "<leader>fr", builtin.oldfiles,    { desc = "Telescope: [F]ind [R]ecent"  })
    vim.keymap.set("n", "<leader>fb", builtin.buffers,     { desc = "Telescope: [F]ind [B]uffers" })
    vim.keymap.set("n", "<leader>fh", builtin.help_tags,   { desc = "Telescope: [F]ind [H]elp "   })
    vim.keymap.set("n", "<leader>ft", builtin.colorscheme, { desc = "Telescope: [F]ind [T]hemes"  })
    -- stylua: ignore end
  end,
}
