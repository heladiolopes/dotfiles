--
-- Show diagnostics, references, and list entries with Trouble.
--
return {
  "folke/trouble.nvim",
  cmd = "Trouble",
  opts = {},
  keys = {
    { "<leader>xx", "<Cmd>Trouble diagnostics toggle<CR>", desc = "Workspace problems" },
    { "<leader>xb", "<Cmd>Trouble diagnostics toggle filter.buf=0<CR>", desc = "Buffer problems" },
    { "<leader>xr", "<Cmd>Trouble lsp_references toggle<CR>", desc = "References" },
    { "<leader>xq", "<Cmd>Trouble qflist toggle<CR>", desc = "Quickfix" },
    { "<leader>xl", "<Cmd>Trouble loclist toggle<CR>", desc = "Location list" },
  },
}
