return {
  cmd = { "gopls" },
  filetypes = { "go", "gotempl", "gowork", "gomod" },
  root_markers = { ".git", "go.mod", "go.work", vim.uv.cwd() },
  capabilities = {
    textDocument = {
      semanticTokens = {
        dynamicRegistration = false,
        requests = {
          range = false,
          full = { delta = true },
        },
      },
    },
  },
  settings = {
    gopls = {
      completeUnimported = true,
      usePlaceholders = true,
      analyses = {
        unusedparams = true,
      },
      ["ui.inlayhint.hints"] = {
        compositeLiteralFields = true,
        constantValues = true,
        parameterNames = true,
        rangeVariableTypes = true,
      },
    },
    analyses = {
      unusedparams = true,
      unreachable = true,
      unusedvariable = true,
    },
    usePlaceholders = true,
    completionBudget = "200ms",
    staticcheck = true,
    gofumpt = true,
    semanticTokens = true,
  },
}
