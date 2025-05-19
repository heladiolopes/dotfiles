return {
  "nvim-treesitter/nvim-treesitter",
  build = ":TSUpdate",
  config = function()
    require("nvim-treesitter.configs").setup({
      ensure_installed = { "bash", "lua", "vim", "vimdoc", "query", "python", "markdown" },
      auto_install = true,
      highlight = { enable = true },
      indent = { enable = true },
    })
  end,
}
