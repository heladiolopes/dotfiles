--
-- Install Tree-sitter parsers and enable highlighting, folds, and selected indentation.
--
return {
  "nvim-treesitter/nvim-treesitter",
  lazy = false,
  build = ":TSUpdate",
  config = function()
    local ts = require("nvim-treesitter")
    local languages = { "lua", "vim", "vimdoc", "query", "python", "go", "bash", "markdown", "markdown_inline" }
    local available = {}
    for _, lang in ipairs(ts.get_available()) do available[lang] = true end
    local pending = {}

    local function start_buffer(buf, lang)
      if not vim.api.nvim_buf_is_loaded(buf) or vim.treesitter.language.get_lang(vim.bo[buf].filetype) ~= lang then return end
      if not pcall(vim.treesitter.start, buf) then return end
      for _, win in ipairs(vim.fn.win_findbuf(buf)) do
        vim.api.nvim_set_option_value("foldmethod", "expr", { win = win })
        vim.api.nvim_set_option_value("foldexpr", "v:lua.vim.treesitter.foldexpr()", { win = win })
      end
      -- Indentation is currently experimental; use it only for Lua and Go.
      if lang == "lua" or lang == "go" then
        vim.bo[buf].indentexpr = "v:lua.require'nvim-treesitter'.indentexpr()"
      end
    end

    local function install(lang)
      if pending[lang] then return end
      pending[lang] = true
      ts.install(lang):await(function(err, ok)
        pending[lang] = nil
        if err or not ok then return end
        for _, buf in ipairs(vim.api.nvim_list_bufs()) do start_buffer(buf, lang) end
      end)
    end

    -- Install common parsers in one task; the callback starts any open buffers.
    for _, lang in ipairs(languages) do pending[lang] = true end
    ts.install(languages):await(function(err)
      for _, lang in ipairs(languages) do
        pending[lang] = nil
        if not err and vim.list_contains(ts.get_installed("parsers"), lang) then
          for _, buf in ipairs(vim.api.nvim_list_bufs()) do start_buffer(buf, lang) end
        end
      end
    end)
    local group = vim.api.nvim_create_augroup("NvimNewTreesitter", { clear = true })
    vim.api.nvim_create_autocmd("FileType", {
      group = group,
      callback = function(args)
        local ft = vim.bo[args.buf].filetype
        local lang = vim.treesitter.language.get_lang(ft)
        if not lang or not available[lang] then return end
        if vim.list_contains(ts.get_installed("parsers"), lang) then
          start_buffer(args.buf, lang)
        else
          install(lang)
        end
      end,
    })
  end,
}
