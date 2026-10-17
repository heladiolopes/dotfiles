--
-- Configure Bash language support for shell buffers.
--
return {
  cmd = { "bash-language-server", "start" },
  filetypes = { "bash", "sh", "zsh" },
  root_markers = { ".git" },
}
