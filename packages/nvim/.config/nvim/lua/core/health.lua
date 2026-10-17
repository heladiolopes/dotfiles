--
-- Check external tools on demand and warn about missing tools at startup.
--

local tools = {
  "lua-language-server", "basedpyright-langserver", "ruff", "gopls",
  "bash-language-server", "marksman", "stylua", "shfmt", "debugpy-adapter", "rg", "fd",
}

vim.api.nvim_create_user_command("ConfigTools", function()
  local missing = {}
  for _, name in ipairs(tools) do
    if vim.fn.executable(name) == 0 then table.insert(missing, name) end
  end
  vim.notify(#missing == 0 and "All configured tools are on PATH"
    or "Missing tools: " .. table.concat(missing, ", "),
    #missing == 0 and vim.log.levels.INFO or vim.log.levels.WARN)
end, { desc = "Check external tools required by this config" })

vim.api.nvim_create_autocmd("VimEnter", {
  once = true,
  callback = function()
    local missing = {}
    for _, name in ipairs(tools) do
      if vim.fn.executable(name) == 0 then table.insert(missing, name) end
    end
    if #missing > 0 then
      vim.notify("Missing tools: " .. table.concat(missing, ", ") .. ". Run :ConfigTools after installation.", vim.log.levels.WARN)
    end
  end,
})
