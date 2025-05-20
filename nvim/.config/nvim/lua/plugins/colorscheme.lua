return {
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
        -- "dashboard",
        -- "eyeliner",
        "fidget",
        -- "flash",
        "gitsigns",
        -- "illuminate",
        "indent-blankline",
        "mini",
        "neo-tree",
        "noice",
        "nvim-cmp",
        "nvim-web-devicons",
        -- "rainbow-delimiters",
        -- "sneak",
        "telescope",
        "which-key",
        "nvim-notify",
      },
      disable = {
        eob_lines = true, -- Hide the end-of-buffer lines
      },
      lualine_style = "material-nvim",
    })

    vim.g.material_style = "deep ocean"
    vim.cmd.colorscheme("material")
  end,
}
