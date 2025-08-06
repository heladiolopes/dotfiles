return {
  "stevearc/conform.nvim",
  event = { "BufWritePre" },
  cmd = { "ConformInfo" },
  keys = {
    {
      "<leader>cf",
      function()
        require("conform").format({ async = true, lsp_format = "fallback" })
      end,
      mode = "n",
      desc = "Conform: Format buffer",
    },
  },
  notify_on_error = false,
  opts = {
    format_on_save = function(bufnr)
      -- Disable "format_on_save lsp_fallback" for languages that don't
      -- have a well standardized coding style. You can add additional
      -- languages here or re-enable it for the disabled ones.
      local disable_filetypes = { c = true, cpp = true, sql_bigquery = true }
      if disable_filetypes[vim.bo[bufnr].filetype] then
        return nil
      else
        return {
          timeout_ms = 500,
          lsp_format = "fallback",
        }
      end
    end,
    formatters_by_ft = {
      lua = { "stylua" },
      -- python = { "isort", "black" },
      go = { "gofumpt", "goimports" },
      sh = { "shfmt" },
      -- sql_bigquery = { "bigquery_fmt" },
    },
    -- formatters = {
    --   bigquery_fmt = {
    --     command = "./~/dev/bqlang/cmd/bqfmt/bqfmt",
    --     args = { "-w", "$FILENAME" },
    --     stdin = true,
    --   }
    -- }
  },
}
