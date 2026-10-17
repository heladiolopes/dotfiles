--
-- Configure commenting, text objects, surroundings, pairs, and multiple cursors.
--
local no_special_keys = { cr = false, bs = false }

return {
  {
    "numToStr/Comment.nvim",
    lazy = false,
    opts = {},
    keys = {
        { "gcc", mode = "n",          desc = "Comment toggle current line" },
        { "gc",  mode = { "n", "o" }, desc = "Comment toggle linewise" },
        { "gc",  mode = "x",          desc = "Comment toggle linewise (visual)" },
        { "gbc", mode = "n",          desc = "Comment toggle current block" },
        { "gb",  mode = { "n", "o" }, desc = "Comment toggle blockwise" },
        { "gb",  mode = "x",          desc = "Comment toggle blockwise (visual)" },
        {
          "<C-c>",
          function()
            require("Comment.api").toggle.linewise.current()
          end,
          desc = "Toggle comment",
        },
        {
          "<C-c>",
          "<ESC><Cmd>lua require('Comment.api').toggle.linewise(vim.fn.visualmode())<CR>",
          mode = "v",
          desc = "Toggle comment",
        },
      },
  },
  {
    "nvim-mini/mini.nvim",
    lazy = false,
    config = function()
      -- Better Around/Inside textobjects
      --
      -- Examples:
      --  - va)  - [V]isually select [A]round [)]paren
      --  - yinq - [Y]ank [I]nside [N]ext [Q]uote
      --  - ci"  - [C]hange [I]nside ["]quote
      require("mini.ai").setup({
        mappings = {
          around_next = "aN",
          inside_next = "iN",
          around_last = "aL",
          inside_last = "iL",
        },
      })

      -- Add/delete/replace surroundings (brackets, quotes, etc.)
      --
      -- - saiw) - [S]urround [A]dd [I]nner [W]ord [)]Paren
      -- - sd"   - [S]urround [D]elete ["]quotes
      -- - sr)"  - [S]urround [R]eplace [)] ["]
      require("mini.surround").setup()

      -- Paired characters conditional on cursor's neighborhood
      --
      -- () / [] / {} / "" / ''
      require("mini.pairs").setup({
        modes = { insert = true, command = false, terminal = false },
        -- skip autopair when next character is one of these
        skip_next = [=[[%w%%%'%[%"%.%`%$]]=],
        -- skip autopair when the cursor is inside these treesitter nodes
        skip_ts = { "string" },
        -- skip autopair when next character is closing pair
        -- and there are more closing pairs than opening pairs
        skip_unbalanced = true,
        -- better deal with markdown code blocks
        markdown = true,
        -- Leave Enter and Backspace to completion and existing insert mappings.
        mappings = {
          ["("] = { register = no_special_keys },
          ["["] = { register = no_special_keys },
          ["{"] = { register = no_special_keys },
          [")"] = { register = no_special_keys },
          ["]"] = { register = no_special_keys },
          ["}"] = { register = no_special_keys },
          ['"'] = { register = no_special_keys },
          ["'"] = { register = no_special_keys },
          ["`"] = { register = no_special_keys },
        },
      })

      -- Visual Multi replays typed characters at each cursor itself.
      local group = vim.api.nvim_create_augroup("NvimNewMultiCursorPairs", { clear = true })
      vim.api.nvim_create_autocmd("User", {
        group = group,
        pattern = "visual_multi_start",
        callback = function(args) vim.b[args.buf].minipairs_disable = true end,
      })
      vim.api.nvim_create_autocmd("User", {
        group = group,
        pattern = "visual_multi_exit",
        callback = function(args) vim.b[args.buf].minipairs_disable = nil end,
      })
    end,
  },
  {
    "mg979/vim-visual-multi",
    lazy = false,
  },
}
