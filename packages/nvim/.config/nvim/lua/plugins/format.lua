--
-- Format Lua, Python, Go, and shell files with Conform.
--
return {
  "stevearc/conform.nvim",
  event = "BufWritePre",
  cmd = "ConformInfo",
  keys = {
    {
      "<leader>cf",
      function()
        local buf = vim.api.nvim_get_current_buf()
        local ft = vim.bo[buf].filetype
        local opts = { bufnr = buf, async = true, timeout_ms = 2000 }
        if ft == "python" then
          opts.lsp_format = "never"
        elseif ft == "go" then
          opts.lsp_format = "prefer"
          opts.filter = function(client) return client.name == "gopls" end
        else
          opts.lsp_format = "fallback"
        end
        require("conform").format(opts)
      end,
      desc = "Format buffer",
    },
  },
  opts = {
    -- Run Ruff's import organizer before its formatter; Go uses gopls.
    formatters_by_ft = {
      lua = { "stylua" },
      python = { "ruff_organize_imports", "ruff_format" },
      go = {},
      sh = { "shfmt" },
      bash = { "shfmt" },
      zsh = { "shfmt" },
    },
    format_on_save = function(buf)
      local ft = vim.bo[buf].filetype
      if ft == "python" then
        return {
          timeout_ms = 2000,
          lsp_format = "never",
        }
      elseif ft == "go" then
        return {
          timeout_ms = 2000,
          lsp_format = "prefer",
          filter = function(client) return client.name == "gopls" end,
        }
      elseif ft == "lua" or ft == "sh" or ft == "bash" or ft == "zsh" then
        return { timeout_ms = 2000, lsp_format = "fallback" }
      end
    end,
  },
}
