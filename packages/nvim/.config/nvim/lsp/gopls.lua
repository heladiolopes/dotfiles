--
-- Configure gopls completion, diagnostics, and hints for Go projects.
--
return {
  cmd = { "gopls" },
  filetypes = { "go", "gomod", "gowork", "gotmpl" },
  root_markers = { "go.work", "go.mod", ".git" },
  settings = {
    gopls = {
      completeUnimported = true,
      usePlaceholders = true,
      staticcheck = true,
      gofumpt = false,
      analyses = { unusedparams = true },
      hints = { parameterNames = true, rangeVariableTypes = true },
    },
  },
}
