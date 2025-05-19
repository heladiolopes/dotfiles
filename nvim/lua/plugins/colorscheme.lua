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
        "mini",
        "neo-tree",
        "noice",
        "nvim-web-devicons",
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
