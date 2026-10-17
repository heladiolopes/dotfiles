--
-- Configure colors, status and buffer lines, notifications, and UI messages.
--
return {
  {
    "marko-cerovac/material.nvim",
    name = "material",
    lazy = false,
    priority = 1000,
    config = function()
      vim.g.material_style = "deep ocean"
      require("material").setup({
        high_visibility = { darker = true },
        disable = { eob_lines = true },
        plugins = {
          "gitsigns",
          "indent-blankline",
          "neo-tree",
          "noice",
          "nvim-web-devicons",
          "telescope",
          "which-key",
          "nvim-notify",
          "illuminate",
          "mini",
        },
        lualine_style = "material-nvim",
      })
      vim.cmd.colorscheme("material")
    end,
  },
  { "nvim-tree/nvim-web-devicons", lazy = true },
  { "RRethy/vim-illuminate" },
  {
    "nvim-lualine/lualine.nvim",
    event = "VeryLazy",
    dependencies = { "nvim-tree/nvim-web-devicons" },
    opts = {
      options = {
        theme = "material",
        icons_enabled = true,
        globalstatus = true,
        disabled_filetypes = { statusline = { "neo-tree" } },
        component_separators = { left = "", right = "" },
        section_separators = { left = "", right = "" },
      },
    },
  },
  {
    "akinsho/bufferline.nvim",
    event = "VeryLazy",
    dependencies = { "nvim-tree/nvim-web-devicons", "echasnovski/mini.bufremove" },
    opts = {
      options = {
        mode = "buffers",
        close_command = function(bufnr)
          require("mini.bufremove").delete(bufnr, false)
        end,
        middle_mouse_command = function(bufnr)
          require("mini.bufremove").delete(bufnr, false)
        end,
        themable = true,
        numbers = "none",
        diagnostics = "nvim_lsp",
        separator_style = "thick",
        color_icons = true,
        enforce_regular_tabs = false,
        always_show_bufferline = true,
        show_close_icon = false,
        show_buffer_close_icons = false,
        offsets = { { filetype = "neo-tree", text = "File Explorer", text_align = "center" } },
        custom_filter = function(buf, _)
          -- Directory buffers appears after restoring the session and
          -- they should be ignored.
          local buf_name = vim.api.nvim_buf_get_name(buf)
          local state = vim.uv.fs_stat(buf_name)
          if state and state.type == "directory" then
            return false
          end
          return true
        end,
      },
    },
    keys = {
      { "<S-l>", "<Cmd>BufferLineCycleNext<CR>", desc = "Next buffer" },
      { "<S-h>", "<Cmd>BufferLineCyclePrev<CR>", desc = "Previous buffer" },
      { "<S-Left>", "<Cmd>BufferLineCycleNext<CR>", desc = "Next buffer" },
      { "<S-Right>", "<Cmd>BufferLineCyclePrev<CR>", desc = "Previous buffer" },
      { "<leader>bb", "<Cmd>BufferLinePick<CR>", desc = "Pick buffer" },
      {
        "<leader>bq",
        function()
          require("mini.bufremove").delete(0, false)
        end,
        desc = "Close buffer",
      },
      { "<leader>bc", "<Cmd>BufferLinePickClose<CR>", desc = "Close picked buffer" },
      { "<leader>bo", "<Cmd>BufferLineCloseOthers<CR>", desc = "Close other buffers" },
    },
  },
  {
    "lukas-reineke/indent-blankline.nvim",
    main = "ibl",
    event = { "BufReadPost", "BufNewFile" },
    opts = {
      indent = { char = "┊" },
      scope = {
        highlight = { "Function", "Label" },
      },
    },
  },
  {
    "rcarriga/nvim-notify",
    lazy = false,
    config = function()
      local notify = require("notify")
      notify.setup({ timeout = 3000, render = "simple" })
      vim.notify = notify
    end,
  },
  {
    "folke/noice.nvim",
    event = "VeryLazy",
    dependencies = { "MunifTanjim/nui.nvim", "rcarriga/nvim-notify" },
    opts = {
      -- Keep Noice's default routes until a specific message needs rerouting.
      presets = { command_palette = true, long_message_to_split = true },
    },
  },
}
