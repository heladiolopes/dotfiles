return {
  "nvim-lualine/lualine.nvim",
  dependencies = {
    "nvim-tree/nvim-web-devicons",
  },

  config = function()
    require("lualine").setup({
      options = {
        globalstatus = true,
        icons_enabled = true,
        theme = "material",
        component_separators = { left = "", right = "" },
        section_separators = { left = "", right = "" },
      },

      sections = {
        lualine_a = { "mode" },
        lualine_b = { "branch", "diff", "diagnostics" },
        lualine_c = {
          {
            "filename",
            cond = function()
              return vim.bo.buftype == ""
            end,
            symbols = {
              modified = "[+]",
              readonly = "[-]",
              unnamed = "[No Name]",
              newfile = "[New]",
            },
          },
        },
        lualine_x = { "encoding", "filetype" },
        lualine_y = { "progress" },
        lualine_z = { "location" },
      },
    })

    -- Supress lualine when focus neo-tree
    vim.api.nvim_create_autocmd("FileType", {
      pattern = "neo-tree",
      callback = function()
        vim.b.lualine_disable = true
      end,
    })
  end,
}
