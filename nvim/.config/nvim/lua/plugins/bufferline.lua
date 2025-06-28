return {
  "akinsho/bufferline.nvim",
  version = "*",
  event = "VeryLazy",
  dependencies = {
    { "nvim-tree/nvim-web-devicons" },
    { "echasnovski/mini.bufremove", version = "*" },
  },

  config = function()
    local bufremove = require("mini.bufremove")

    require("bufferline").setup({
      options = {
        mode = "buffers",
        -- stylua: ignore
        close_command = function(n) bufremove.delete(n, false) end,
        -- stylua: ignore
        middle_mouse_command = function(n) bufremove.delete(n, false) end,
        themable = true,
        numbers = "none",
        diagnostics = "nvim_lsp",
        separator_style = "thick",
        color_icons = true,
        enforce_regular_tabs = false,
        always_show_bufferline = true,
        show_close_icon = false,
        show_buffer_close_icons = false,
        indicator = {
          style = "icon",
          icon = "▎",
        },
        offsets = {
          {
            filetype = "neo-tree",
            text = "File Explorer",
            highlight = "Directory",
            text_align = "center",
            separator = true,
          },
        },
      },
    })

    -- stylua: ignore start
    -- Map para picking de buffers
    vim.keymap.set("n", "<leader>bb", "<cmd>BufferLinePick<CR>",                 { desc = "Buffer Pick"         })
    vim.keymap.set("n", "<leader>bq", function() bufremove.delete(0, false) end, { desc = "Buffer Quit"         })
    vim.keymap.set("n", "<leader>bc", "<cmd>BufferLinePickClose<CR>",            { desc = "Buffer Close Pick"   })
    vim.keymap.set("n", "<leader>bo", "<cmd>BufferLineCloseOthers<CR>",          { desc = "Buffer Close Others" })
    vim.keymap.set("n", "<S-l>",      "<cmd>BufferLineCycleNext<CR>",            { desc = "Next"                    })
    vim.keymap.set("n", "<S-Left>",   "<cmd>BufferLineCycleNext<CR>",            { desc = "Next"                    })
    vim.keymap.set("n", "<S-h>",      "<cmd>BufferLineCyclePrev<CR>",            { desc = "Previous"                })
    vim.keymap.set("n", "<S-Right>",  "<cmd>BufferLineCyclePrev<CR>",            { desc = "Previous"                })
    -- stylua: ignore end
    vim.cmd([[
      highlight! link BufferLineFill Normal
    ]])
  end,
}
