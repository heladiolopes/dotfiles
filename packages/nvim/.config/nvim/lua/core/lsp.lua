--
-- Configure LSP capabilities, diagnostics, completion, and buffer keymaps.
--

-- LSP capabilities
vim.lsp.config("*", {
  capabilities = {
    textDocument = {
      completion = { completionItem = { snippetSupport = true } },
      foldingRange = { dynamicRegistration = false, lineFoldingOnly = true },
    },
  },
})

--
-- Diagnostic Config
--
vim.diagnostic.config({
  severity_sort = true,
  underline = true,
  virtual_text = { spacing = 2, source = "if_many" },
  -- Rounded borders match other floats; show the diagnostic source.
  float = { border = "rounded", source = true },
  signs = {
    text = {
      [vim.diagnostic.severity.ERROR] = "",
      [vim.diagnostic.severity.WARN] = "",
      [vim.diagnostic.severity.INFO] = "",
      [vim.diagnostic.severity.HINT] = "",
    },
  },
})

--
-- LSP Autocommands
--

local group = vim.api.nvim_create_augroup("NvimNewLsp", { clear = true })
vim.api.nvim_create_autocmd("LspAttach", {
  group = group,
  callback = function(args)
    local client = vim.lsp.get_client_by_id(args.data.client_id)
    if not client then
      return
    end
    local buf = args.buf

    if client:supports_method(vim.lsp.protocol.Methods.textDocument_completion) then
      vim.lsp.completion.enable(true, client.id, buf, { autotrigger = true })
      vim.b[buf].nvim_new_completion = true
    end

    -- Several servers may attach to one buffer; install its mappings once.
    if vim.b[buf].nvim_new_lsp_maps then
      return
    end
    vim.b[buf].nvim_new_lsp_maps = true
    local function map(modes, lhs, rhs, desc)
      vim.keymap.set(modes, lhs, rhs, { buffer = buf, desc = "LSP: " .. desc })
    end
    map("n", "K", vim.lsp.buf.hover, "Hover")
    map("n", "gd", vim.lsp.buf.definition, "Definition")
    map("n", "gD", vim.lsp.buf.declaration, "Declaration")
    map("n", "gi", vim.lsp.buf.implementation, "Implementation")
    map("n", "gr", vim.lsp.buf.references, "References")
    map("n", "<leader>rn", vim.lsp.buf.rename, "Rename")
    map({ "n", "v" }, "<leader>ca", vim.lsp.buf.code_action, "Code action")
    map("n", "<leader>cs", vim.lsp.buf.signature_help, "Signature help")
    map("n", "<leader>ds", vim.lsp.buf.document_symbol, "Document symbols")
    map("n", "<leader>ws", vim.lsp.buf.workspace_symbol, "Workspace symbols")
    map("n", "[d", function()
      vim.diagnostic.jump({ count = -1 })
    end, "Previous diagnostic")
    map("n", "]d", function()
      vim.diagnostic.jump({ count = 1 })
    end, "Next diagnostic")
    map("n", "<leader>dl", vim.diagnostic.open_float, "Line diagnostics")
    map("n", "<leader>ih", function()
      vim.lsp.inlay_hint.enable(not vim.lsp.inlay_hint.is_enabled({ bufnr = buf }), { bufnr = buf })
    end, "Toggle inlay hints")
  end,
})

-- Native autotrigger covers server trigger characters. This adds regular words.
vim.api.nvim_create_autocmd("InsertCharPre", {
  group = group,
  callback = function(args)
    if not vim.b[args.buf].nvim_new_completion or not vim.v.char:match("[%w_]") then
      return
    end
    local buf = args.buf
    vim.schedule(function()
      if vim.api.nvim_get_current_buf() == buf and vim.fn.mode() == "i" then
        vim.lsp.completion.get()
      end
    end)
  end,
})

-- Skip unavailable servers so a missing external tool does not break editing.
-- The configuration is found in the lsp folder: ~.config/nvim/lsp/<name>
for name, executable in pairs({
  lua_ls = "lua-language-server",
  basedpyright = "basedpyright-langserver",
  ruff = "ruff",
  gopls = "gopls",
  bashls = "bash-language-server",
  marksman = "marksman",
}) do
  if vim.fn.executable(executable) == 1 then
    vim.lsp.enable(name)
  end
end
