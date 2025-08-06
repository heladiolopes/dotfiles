-- [[ Bootstrap lazy.nvim ]]
require("config.lazy")

-- [[ Set Custom Keymap bidings ]]
require("core.options")
require("core.keymaps")
require("core.autocommands")

-- [[ Start LSP ]]
require("config.lsp")

-- [[ Load plugins ]]
---@diagnostic disable-next-line: different-requires
require("lazy").setup("plugins")
