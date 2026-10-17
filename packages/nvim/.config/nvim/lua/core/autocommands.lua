--
-- Highlight copied text and normalize whitespace on save.
--

-- Highlight when yanking (copying) text
--  Try it with `yap` in normal mode
--  See `:help vim.highlight.on_yank()`
local yank = vim.api.nvim_create_augroup("NvimNewYank", { clear = true })
vim.api.nvim_create_autocmd("TextYankPost", {
  desc = "Highlight when yanking (copying) text",
  group = yank,
  callback = function() vim.highlight.on_yank() end,
})

-- Match VS Code whitespace cleanup for every writable text buffer.
local whitespace = vim.api.nvim_create_augroup("NvimNewWhitespace", { clear = true })
vim.api.nvim_create_autocmd("BufWritePre", {
  group = whitespace,
  callback = function(args)
    local buf = args.buf
    if vim.bo[buf].buftype ~= "" or not vim.bo[buf].modifiable or vim.bo[buf].readonly
        or vim.bo[buf].binary then
      return
    end
    local view = vim.fn.winsaveview()
    local lines = vim.api.nvim_buf_get_lines(buf, 0, -1, false)
    for index, line in ipairs(lines) do lines[index] = line:gsub("[ \t]+$", "") end

    local last = #lines
    while last > 0 and lines[last]:match("^%s*$") do last = last - 1 end
    if last == 0 then
      lines = { "" }
    else
      for index = #lines, last + 1, -1 do lines[index] = nil end
      lines[last + 1] = ""
    end

    vim.api.nvim_buf_set_lines(buf, 0, -1, false, lines)
    vim.bo[buf].endofline = true
    vim.bo[buf].fixeol = true
    vim.fn.winrestview(view)
  end,
})
