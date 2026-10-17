--
-- Define global editing, navigation, and window keymaps.
--

local keymap = vim.keymap.set

-- keymap.set("i", "<C-b>", "<ESC>^i", { desc = "Move to the beginning of the line" })
-- keymap.set("i", "<C-e>", "<End>",   { desc = "Move to the end of the line"       })

keymap("i", "jj", "<Esc>", { desc = "Leave insert mode", nowait = true })

keymap("i", "<C-s>", "<Esc><Cmd>write<CR>", { desc = "Save file" })
keymap("n", "<C-s>", "<Cmd>write<CR>", { desc = "Save file" })

-- use CTRL+<hjkl> to switch between windows
for key, direction in pairs({ h = "h", j = "j", k = "k", l = "l" }) do
  keymap("n", "<C-" .. key .. ">", "<C-w>" .. direction, { desc = "Focus " .. direction .. " window" })
end

keymap("n", "<C-u>", "<C-u>zz", { desc = "Scroll up" })
keymap("n", "<C-d>", "<C-d>zz", { desc = "Scroll down" })

-- keymap("n", "gg", "gg0", { desc = "Move to first line" })
-- keymap("n", "G" , "G$",  { desc = "Move to last line" })

keymap("n", "yf", "<cmd> %y+ <CR>", { desc = "Yank whole file" })

keymap("n", "<Esc>", "<Cmd>nohlsearch<CR>", { desc = "Clear highlights on search" })

keymap("n", "<leader>sv", "<C-w>v", { desc = "Split vertically" })
keymap("n", "<leader>sh", "<C-w>s", { desc = "Split horizontally" })
keymap("n", "<leader>se", "<C-w>=", { desc = "Equalize splits" })
keymap("n", "<leader>sx", "<Cmd>close<CR>", { desc = "Close split" })

keymap("n", "<leader>bn", "<Cmd>enew<CR>", { desc = "New buffer" })
keymap("n", "<leader>q", vim.diagnostic.setloclist, { desc = "Diagnostics location list" })
keymap("t", "<Esc><Esc>", "<C-\\><C-n>", { desc = "Leave terminal mode" })

keymap("i", "<C-Space>", function()
  vim.lsp.completion.get()
end, { desc = "Request LSP completion" })

keymap("i", "<CR>", function()
  if vim.fn.pumvisible() == 1 then
    return "<C-y>"
  end
  return "<CR>"
end, { desc = "Accept LSP completion with <CR>", expr = true })

-- delete single character without copying into register
keymap("n", "x", '"_x')

-- increment/Decrement numbers
keymap("n", "<leader>+", "<C-a>", { desc = "Increment number" })
keymap("n", "<leader>-", "<C-x>", { desc = "Decrement number" })

-- duplicate selection
keymap("n", "<C-A-Down>", ":t.<CR>", { desc = "Duplicate line below", silent = true })
keymap("n", "<C-A-Up>", ":t-1<CR>", { desc = "Duplicate line above", silent = true })
keymap("n", "<C-A-j>", ":t.<CR>", { desc = "Duplicate line below", silent = true })
keymap("n", "<C-A-k>", ":t-1<CR>", { desc = "Duplicate line above", silent = true })

-- mode lines
keymap("n", "<A-Down>", ":m .+1<CR>==", { desc = "Move line down", silent = true })
keymap("n", "<A-Up>", ":m .-2<CR>==", { desc = "Move line up", silent = true })
keymap("n", "<A-j>", ":m .+1<CR>==", { desc = "Move line down", silent = true })
keymap("n", "<A-k>", ":m .-2<CR>==", { desc = "Move line up", silent = true })

-- replace without copying replaced text in visual mode
keymap("v", "p", 'p:let @+=@0<CR>:let @"=@0<CR>', { silent = true, desc = "Paste without overwriting the register" })

-- duplicate selection
keymap("v", "<C-A-Down>", ":t'>+1<CR>gv", { desc = "Duplicate selection below", silent = true })
keymap("v", "<C-A-Up>", ":t'<-1<CR>gv", { desc = "Duplicate selection above", silent = true })
keymap("v", "<C-A-j>", ":t'>+1<CR>gv", { desc = "Duplicate selection below", silent = true })
keymap("v", "<C-A-k>", ":t'<-1<CR>gv", { desc = "Duplicate selection above", silent = true })

-- move lines
keymap("v", "<A-Down>", ":m '>+1<CR>gv=gv", { desc = "Move selection down", silent = true })
keymap("v", "<A-Up>", ":m '<-2<CR>gv=gv", { desc = "Move selection up", silent = true })
keymap("v", "<A-j>", ":m '>+1<CR>gv=gv", { desc = "Move selection down", silent = true })
keymap("v", "<A-k>", ":m '<-2<CR>gv=gv", { desc = "Move selection up", silent = true })

keymap("n", "<leader>qq", "<cmd>qa<cr>", { desc = "Quit Neovim" })
keymap("n", "<leader>qQ", "<cmd>qa!<cr>", { desc = "Force quit Neovim" })
