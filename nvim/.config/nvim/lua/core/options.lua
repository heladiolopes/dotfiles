-- make it simpple
local opt = vim.opt
local g = vim.g

-- General settings
opt.showmode = false -- disable show the mode, already in the status line
opt.cursorline = true -- highlight line the cursor is on
vim.schedule(function()
  opt.clipboard = "unnamedplus" -- enable system clipboard for yank
end)

-- Identation settings
opt.expandtab = true -- Pressing the TAB key will insert spaces instead of a TAB character
opt.tabstop = 2 -- A TAB character looks like 4 spaces
opt.softtabstop = 2 -- Number of spaces inserted instead of a TAB character
opt.shiftwidth = 2 -- Number of spaces inserted when indenting

-- Display settings
opt.ignorecase = true -- Ignore case in search patterns
opt.smartcase = true -- Override `ignorecase` if the search contains uppercase letters
opt.mouse = "a" -- Enable mouse in all modes

-- Line Numbers
opt.number = true -- Show absolute line number on the cursor line
-- opt.relativenumber = true -- Show relative line numbers for easier navigation
opt.ruler = false -- Disable the ruler, as the global statusline can handle this

-- Split Windows Behavior
opt.signcolumn = "yes" -- Always show the sign column to prevent text shifting
opt.splitbelow = true -- New horizontal splits will open below the current window
opt.splitright = true -- New vertical splits will open to the right of the current window

-- Appearance
g.have_nerd_font = true -- Enable nerd font
opt.termguicolors = true -- Enable 24-bit RGB colors for better syntax highlighting and theming
opt.background = "dark" -- colorschemes that can be light or dark will be made dark

-- Performance
opt.timeoutlen = 300 -- Time in milliseconds to wait for a mapped sequence to complete
opt.undofile = true -- Enable persistent undo, allowing you to undo changes even after reopening the file
opt.updatetime = 250 -- Time in milliseconds before writing the swap file to disk (used by gitsigns and others)

-- Scrolling
opt.scrolloff = 10 -- Keep at least 10 lines visible above and below the cursor during scrolling

-- Disable netrw
g.loaded_netrw = 1 -- Prevent netrw from loading, avoiding conflicts with nvim-tree
g.loaded_netrwPlugin = 1 -- Disable the netrw plugin as well, fully disabling netrw

-- Other settings
opt.breakindent = true -- Enable break indent
opt.list = true -- Sets how neovim will display certain whitespace characters in the editor.
opt.listchars = { tab = "» ", trail = "·", nbsp = "␣" }
opt.inccommand = "split" -- Preview substitutions live, as you type!

-- if performing an operation that would fail due to unsaved changes in the buffer (like `:q`),
-- instead raise a dialog asking if you wish to save the current file(s)
-- See `:help 'confirm'`
opt.confirm = true
