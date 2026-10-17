--
-- Bootstrap lazy.nvim and load the plugin specifications.
--
local path = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
-- Bootstrap only the plugin manager; lazy.nvim installs the remaining plugins.
if not (vim.uv or vim.loop).fs_stat(path) then
  local output = vim.fn.system({
    "git", "clone", "--filter=blob:none", "--branch=stable",
    "https://github.com/folke/lazy.nvim.git", path,
  })
  if vim.v.shell_error ~= 0 then
    error("Cannot install lazy.nvim: " .. output)
  end
end

vim.opt.rtp:prepend(path)

-- Load plugins
require("lazy").setup({ { import = "plugins" } }, {
  checker = { enabled = false },
  change_detection = { notify = false },
})
