return {
  "lewis6991/gitsigns.nvim",

  config = function()
    require("gitsigns").setup({
      -- Layout configuration
      signs = {
        add = { text = "+" },
        change = { text = "~" },
        delete = { text = "_" },
        topdelete = { text = "‾" },
        changedelete = { text = "~" },
        untracked = { text = " " },
      },
      signs_staged = {
        add = { text = "+" },
        change = { text = "~" },
        delete = { text = "_" },
        topdelete = { text = "‾" },
        changedelete = { text = "~" },
        untracked = { text = " " },
      },

      -- Keymappings
      on_attach = function(bufnr)
        local gitsigns = require("gitsigns")

        local map = function(mode, keys, action, desc)
          vim.keymap.set(mode, keys, action, { buffer = bufnr, desc = "Git: " .. desc })
        end

        -- stylua: ignore start
        map("n", "<leader>gp", gitsigns.preview_hunk,              "Preview Hunk")
        map("n", "<leader>gi", gitsigns.preview_hunk_inline,       "Preview Hunk Inline")
        map("n", "<leader>gb", gitsigns.toggle_current_line_blame, "Toggle Inline Blame")
        map("n", "<leader>gd", gitsigns.toggle_word_diff,          "Toggle Word Diff")
        -- stylua: ignore end
      end,
    })
  end,
}
