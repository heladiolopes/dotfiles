-- [[ Basic Autocommands ]]
--  See `:help lua-guide-autocommands`

-- Highlight when yanking (copying) text
--  Try it with `yap` in normal mode
--  See `:help vim.highlight.on_yank()`
vim.api.nvim_create_autocmd("TextYankPost", {
  desc = "Highlight when yanking (copying) text",
  group = vim.api.nvim_create_augroup("kickstart-highlight-yank", { clear = true }),
  callback = function()
    vim.highlight.on_yank()
  end,
})

-- vim.api.nvim_create_autocmd("BufWritePre", {
--   desc = "Trim trailing blank lines and keep a single final newline",
--   group = vim.api.nvim_create_augroup("trim-trailing-blank-lines", { clear = true }),
--   callback = function(args)
--     local bufnr = args.buf
--
--     if not vim.bo[bufnr].modifiable or vim.bo[bufnr].readonly or vim.bo[bufnr].binary then
--       return
--     end
--
--     if vim.bo[bufnr].buftype ~= "" then
--       return
--     end
--
--     local last_line = vim.api.nvim_buf_line_count(bufnr)
--     if last_line == 0 then
--       return
--     end
--
--     local lines = vim.api.nvim_buf_get_lines(bufnr, 0, -1, false)
--     local trimmed_last = #lines
--
--     while trimmed_last > 1 and lines[trimmed_last] == "" do
--       trimmed_last = trimmed_last - 1
--     end
--
--     if trimmed_last == #lines then
--       return
--     end
--
--     local view = vim.fn.winsaveview()
--     vim.api.nvim_buf_set_lines(bufnr, trimmed_last, -1, false, {})
--     vim.fn.winrestview(view)
--   end,
-- })
