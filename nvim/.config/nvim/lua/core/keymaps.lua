-- stylua: ignore start
-- [[ General mappings ]]
--  See `:help vim.keymap.set()`

vim.keymap.set("n", "<Esc>", "<cmd>nohlsearch<CR>", { desc = "General: Clear Highlights on Search" })

vim.keymap.set("n", "<C-s>", "<cmd>w<CR>",      { desc = "General: Save File" })
vim.keymap.set("i", "<C-s>", "<cmd>w<CR><Esc>", { desc = "General: Save File" })

-- Diagnostic keymaps
vim.keymap.set("n", "<leader>q", vim.diagnostic.setloclist, { desc = "Open diagnostic [Q]uickfix list" })

-- Exit terminal mode in the builtin terminal with a shortcut that is a bit easier
-- for people to discover. Otherwise, you normally need to press <C-\><C-n>, which
-- is not what someone will guess without a bit more experience.
--
-- NOTE: This won't work in all terminal emulators/tmux/etc. Try your own mapping
-- or just use <C-\><C-n> to exit terminal mode
vim.keymap.set("t", "<Esc><Esc>", "<C-\\><C-n>", { desc = "Exit terminal mode" })

--
--  See `:help wincmd` for a list of all window commands
-- NOTE: Some terminals have colliding keymaps or are not able to send distinct keycodes
-- vim.keymap.set("n", "<C-S-h>", "<C-w>H", { desc = "Move window to the left" })
-- vim.keymap.set("n", "<C-S-l>", "<C-w>L", { desc = "Move window to the right" })
-- vim.keymap.set("n", "<C-S-j>", "<C-w>J", { desc = "Move window to the lower" })
-- vim.keymap.set("n", "<C-S-k>", "<C-w>K", { desc = "Move window to the upper" })

-- [[ Editing ]]
vim.keymap.set("i", "<C-H>", "<C-W>", { desc = "Edit: Delete word before (insert)" })

vim.keymap.set("n", "<C-A-Down>", ":t.<CR>",      { desc = "Edit: Duplicate line below (normal)",      silent = true })
vim.keymap.set("n", "<C-A-Up>",   ":t-1<CR>",     { desc = "Edit: Duplicate line above (normal)",      silent = true })
vim.keymap.set("v", "<C-A-Down>", ":t'>+1<CR>gv", { desc = "Edit: Duplicate selection below (visual)", silent = true })
vim.keymap.set("v", "<C-A-Up>",   ":t'<-1<CR>gv", { desc = "Edit: Duplicate selection above (visual)", silent = true })
vim.keymap.set("n", "<C-A-j>",    ":t.<CR>",      { desc = "Edit: Duplicate line below (normal)",      silent = true })
vim.keymap.set("n", "<C-A-k>",    ":t-1<CR>",     { desc = "Edit: Duplicate line above (normal)",      silent = true })
vim.keymap.set("v", "<C-A-j>",    ":t'>+1<CR>gv", { desc = "Edit: Duplicate selection below (visual)", silent = true })
vim.keymap.set("v", "<C-A-k>",    ":t'<-1<CR>gv", { desc = "Edit: Duplicate selection above (visual)", silent = true })

vim.keymap.set("n", "<A-Down>", ":m .+1<CR>==",     { desc = "Edit: Move line down (normal)",      silent = true })
vim.keymap.set("n", "<A-Up>",   ":m .-2<CR>==",     { desc = "Edit: Move line up (normal)",        silent = true })
vim.keymap.set("v", "<A-Down>", ":m '>+1<CR>gv=gv", { desc = "Edit: Move selection down (visual)", silent = true })
vim.keymap.set("v", "<A-Up>",   ":m '<-2<CR>gv=gv", { desc = "Edit: Move selection up (visual)",   silent = true })
vim.keymap.set("n", "<A-j>",    ":m .+1<CR>==",     { desc = "Edit: Move line down (normal)",      silent = true })
vim.keymap.set("n", "<A-k>",    ":m .-2<CR>==",     { desc = "Edit: Move line up (normal)",        silent = true })
vim.keymap.set("v", "<A-j>",    ":m '>+1<CR>gv=gv", { desc = "Edit: Move selection down (visual)", silent = true })
vim.keymap.set("v", "<A-k>",    ":m '<-2<CR>gv=gv", { desc = "Edit: Move selection up (visual)",   silent = true })

-- [[ Navigation Keymaps ]]

-- Keybinds to make split navigation easier.
--  Use CTRL+<hjkl> to switch between windows
vim.keymap.set("n", "<C-h>", "<C-w><C-h>", { desc = "Navigation: Move focus to the left window" })
vim.keymap.set("n", "<C-l>", "<C-w><C-l>", { desc = "Navigation: Move focus to the right window" })
vim.keymap.set("n", "<C-j>", "<C-w><C-j>", { desc = "Navigation: Move focus to the lower window" })
vim.keymap.set("n", "<C-k>", "<C-w><C-k>", { desc = "Navigation: Move focus to the upper window" })

vim.keymap.set("n", "<C-up>",   "gg", { desc = "Navigation: Move to first line" })
vim.keymap.set("n", "<C-down>", "G",  { desc = "Navigation: Move to last line" })
-- stylua: ignore end
