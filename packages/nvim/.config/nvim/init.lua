--
-- Load editor defaults, plugins, language servers, and health checks.
--

vim.g.mapleader = " "      -- Set <space> as the leader key
vim.g.maplocalleader = " " -- Set <space> as localleader key

-- Set editor behavior before plugins create their mappings and autocommands.
require("core.options")
require("core.keymaps")
require("core.autocommands")
require("config.lazy")
require("core.lsp")
require("core.health")
