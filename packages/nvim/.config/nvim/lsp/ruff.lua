--
-- Configure Ruff diagnostics and code actions for Python files.
--
return {
  cmd = { "ruff", "server" },
  filetypes = { "python" },
  root_markers = { { "pyproject.toml", "ruff.toml", ".ruff.toml" }, ".git" },
}
