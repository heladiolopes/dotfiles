-- stylua: ignore start

---------------- [[ General Mappings ]] ----------------

vim.g.mapleader = " "      -- Set <space> as the leader key
vim.g.maplocalleader = " " -- Set <space> as localleader key

---------------- [[ Global Vars      ]] ----------------

local keymap = vim.keymap

---------------- [[ Insert Mode      ]] ----------------

-- navigation
keymap.set("i", "<C-h>", "<Left>",  { desc = "Move left"  })
keymap.set("i", "<C-l>", "<Right>", { desc = "Move right" })
keymap.set("i", "<C-j>", "<Down>",  { desc = "Move down"  })
keymap.set("i", "<C-k>", "<Up>",    { desc = "Move up"    })

keymap.set("i", "<C-b>", "<ESC>^i", { desc = "Move to the beginning of the line" })
keymap.set("i", "<C-e>", "<End>",   { desc = "Move to the end of the line"       })

-- save file and exit insert mode
keymap.set("i", "<C-s>", "<cmd>w<CR><Esc>", { desc = "Save File" })

-- exit insert mode with jj
keymap.set("i", "jj", "<ESC>", { desc = "Escape insert mode", nowait = true })

---------------- [[ Normal Mode      ]] ----------------

-- use CTRL+<hjkl> to switch between windows
keymap.set("n", "<C-h>", "<C-w><C-h>", { desc = "Move focus to the left window"  })
keymap.set("n", "<C-l>", "<C-w><C-l>", { desc = "Move focus to the right window" })
keymap.set("n", "<C-j>", "<C-w><C-j>", { desc = "Move focus to the lower window" })
keymap.set("n", "<C-k>", "<C-w><C-k>", { desc = "Move focus to the upper window" })

keymap.set("n", "<C-up>",   "gg", { desc = "Move to first line" })
keymap.set("n", "<C-down>", "G",  { desc = "Move to last line" })

-- save file
keymap.set("n", "<C-s>", "<cmd>w<CR>", { desc = "Save File" })

-- clear search highlight
keymap.set("n", "<Esc>", "<cmd>nohlsearch<CR>", { desc = "General: Clear Highlights on Search" })

-- open new buffer
keymap.set("n", "<leader>bn", "<cmd> enew <CR>", { desc = "Open a new buffer" })

-- delete single character without copying into register
keymap.set("n", "x", '"_x')

-- increment/Decrement numbers
keymap.set("n", "<leader>+", "<C-a>", { desc = "Increment number" })
keymap.set("n", "<leader>-", "<C-x>", { desc = "Decrement number" })

-- window management
keymap.set("n", "<leader>sv", "<C-w>v",         { desc = "Split window vertically"   })
keymap.set("n", "<leader>sh", "<C-w>s",         { desc = "Split window horizontally" })
keymap.set("n", "<leader>se", "<C-w>=",         { desc = "Make splits equal size"    })
keymap.set("n", "<leader>sx", "<cmd>close<CR>", { desc = "Close current split"       })

-- -- disable the spacebar key's default behavior in normal and visual modes
-- keymap.set("n", "<Space>", "<Nop>", { desc = "Disable space key's default behaviour", silent = true })

-- diagnostic keymaps
keymap.set("n", "<leader>q", vim.diagnostic.setloclist, { desc = "Open diagnostic [Q]uickfix list" })

-- duplicate selection
keymap.set("n", "<C-A-Down>", ":t.<CR>",      { desc = "Duplicate line below", silent = true })
keymap.set("n", "<C-A-Up>",   ":t-1<CR>",     { desc = "Duplicate line above", silent = true })
keymap.set("n", "<C-A-j>",    ":t.<CR>",      { desc = "Duplicate line below", silent = true })
keymap.set("n", "<C-A-k>",    ":t-1<CR>",     { desc = "Duplicate line above", silent = true })

-- mode lines
keymap.set("n", "<A-Down>",   ":m .+1<CR>==", { desc = "Move line down",       silent = true })
keymap.set("n", "<A-Up>",     ":m .-2<CR>==", { desc = "Move line up",         silent = true })
keymap.set("n", "<A-j>",      ":m .+1<CR>==", { desc = "Move line down",       silent = true })
keymap.set("n", "<A-k>",      ":m .-2<CR>==", { desc = "Move line up",         silent = true })

---------------- [[ Visual Mode      ]] ----------------

-- replace without copying replaced text in visual mode
keymap.set("v", "p", 'p:let @+=@0<CR>:let @"=@0<CR>', { silent = true, desc = "Paste without overwriting the register" })

-- duplicate selection
keymap.set("v", "<C-A-Down>", ":t'>+1<CR>gv",     { desc = "Duplicate selection below", silent = true })
keymap.set("v", "<C-A-Up>",   ":t'<-1<CR>gv",     { desc = "Duplicate selection above", silent = true })
keymap.set("v", "<C-A-j>",    ":t'>+1<CR>gv",     { desc = "Duplicate selection below", silent = true })
keymap.set("v", "<C-A-k>",    ":t'<-1<CR>gv",     { desc = "Duplicate selection above", silent = true })

-- move lines
keymap.set("v", "<A-Down>",   ":m '>+1<CR>gv=gv", { desc = "Move selection down",       silent = true })
keymap.set("v", "<A-Up>",     ":m '<-2<CR>gv=gv", { desc = "Move selection up",         silent = true })
keymap.set("v", "<A-j>",      ":m '>+1<CR>gv=gv", { desc = "Move selection down",       silent = true })
keymap.set("v", "<A-k>",      ":m '<-2<CR>gv=gv", { desc = "Move selection up",         silent = true })

---------------- [[ Terminal Mode    ]] ----------------

-- Exit terminal mode in the builtin terminal
keymap.set("t", "<Esc><Esc>", "<C-\\><C-n>", { desc = "Exit terminal mode" })

-- stylua: ignore end
