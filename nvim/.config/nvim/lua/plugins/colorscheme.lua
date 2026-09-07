local theme = require("core.theme")

return {
  {
    "marko-cerovac/material.nvim",
    lazy = false,
    name = "material",
    priority = 1000,
    config = function()
      require("material").setup({
        high_visibility = {
          darker = true,
        },
        plugins = {
          "fidget",
          "gitsigns",
          "illuminate",
          "indent-blankline",
          "mini",
          "neo-tree",
          "noice",
          "nvim-cmp",
          "nvim-web-devicons",
          "telescope",
          "which-key",
          "nvim-notify",
        },
        disable = {
          eob_lines = true,
        },
        lualine_style = "material-nvim",
      })

      if theme.colorscheme == "material" then
        vim.g.material_style = theme.material_style
        vim.cmd.colorscheme(theme.colorscheme)
      end
    end,
  },
  {
    "folke/tokyonight.nvim",
    lazy = false,
    priority = 1000,
    config = function()
      if theme.colorscheme == "tokyonight-night" then
        vim.cmd.colorscheme(theme.colorscheme)
      end
    end,
  },
}
