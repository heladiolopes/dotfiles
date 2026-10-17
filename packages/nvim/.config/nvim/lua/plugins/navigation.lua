--
-- Configure Telescope searches and its vim.ui.select picker.
--
return {
  "nvim-telescope/telescope.nvim",
  tag = "v0.2.0",
  cmd = "Telescope",

  dependencies = {
    "nvim-lua/plenary.nvim",
    "nvim-tree/nvim-web-devicons",
    { "nvim-telescope/telescope-fzf-native.nvim", build = "make", cond = function() return vim.fn.executable("make") == 1 end },
    "nvim-telescope/telescope-ui-select.nvim",
  },

  opts = {
    defaults = {
      prompt_prefix = " ",
      sorting_strategy = "ascending",
      layout_config = { prompt_position = "top" },
      layout_strategy = "horizontal",
      selection_caret = "➜ ",
      winblend = 10,
    },
  },

  config = function(_, opts)
    -- Enable Telescope extensions if they are installed
    require("telescope").setup(opts)
    pcall(require("telescope").load_extension, "fzf")
    require("telescope").load_extension("ui-select")
  end,

  keys = {
    { "<leader>ff", function() require("telescope.builtin").find_files({ hidden = true, no_ignore = false, file_ignore_patterns = { "^%.git/" } }) end, desc = "Find files" },
    { "<leader>fg", function() require("telescope.builtin").live_grep() end, desc = "Live grep" },
    { "<leader>fb", function() require("telescope.builtin").buffers() end, desc = "Find buffers" },
    { "<leader>fr", function() require("telescope.builtin").oldfiles() end, desc = "Recent files" },
    { "<leader>fh", function() require("telescope.builtin").help_tags() end, desc = "Help search" },
    { "<leader>fc", function() require("telescope.builtin").commands() end, desc = "Commands" },
    { "<leader>fk", function() require("telescope.builtin").keymaps() end, desc = "Keymaps" },
    { "<leader>fs", function() require("telescope.builtin").lsp_document_symbols() end, desc = "Document symbols" },
    { "<leader>fS", function() require("telescope.builtin").lsp_dynamic_workspace_symbols() end, desc = "Workspace symbols" },
    { "<leader>gs", function() require("telescope.builtin").git_status() end, desc = "Git status" },
  },
}
