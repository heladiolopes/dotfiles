# Neovim configuration

Start with `nvim` after deploying this package. Neovim 0.12.5 or newer is required. On first launch, lazy.nvim installs plugins and Tree-sitter installs parsers. Run `:Lazy sync` after updating plugin specifications and `:TSUpdate` after updating Tree-sitter. Opening a directory with `nvim <directory>` starts Neo-tree at that directory; opening a file still opens the file directly.

## External tools

Install these on `PATH` with your system or language package manager. Run `:ConfigTools` to see what is missing.

`:ConfigTools` checks the language servers, formatters, debugger adapter, and search tools listed below. On startup, the same check warns once if any are missing. Install the named tools and restart Neovim to enable their features; run `:ConfigTools` again to confirm they are available.

| Purpose                             | Executable                                 |
| ----------------------------------- | ------------------------------------------ |
| Lua LSP                             | `lua-language-server`                      |
| Python type checking                | `basedpyright-langserver`                  |
| Python linting, imports, formatting | `ruff`                                     |
| Go LSP and formatting               | `gopls`                                    |
| Shell LSP                           | `bash-language-server`                     |
| Markdown LSP                        | `marksman`                                 |
| Lua formatting                      | `stylua`                                   |
| Shell formatting                    | `shfmt`                                    |
| Python debugging                    | `debugpy-adapter`                          |
| Telescope search                    | `rg`, `fd`                                 |
| Tree-sitter parsers                 | `tree-sitter` 0.26.1+, `cc`, `curl`, `tar` |

`basedpyright-langserver` was missing when this configuration was created. Install BasedPyright separately and restart Neovim to enable Python type checking. Ruff still provides Python linting, code actions, import organization, and formatting without it. Missing servers are skipped at startup and listed by `:ConfigTools`. The config does not install external language tools through Mason.

## Main keys

| Keys                                | Action                                                                   |
| ----------------------------------- | ------------------------------------------------------------------------ |
| `<C-s>`                             | Save                                                                     |
| `gcc`, `gc{motion}`, visual `gc`   | Toggle line comments or comment a selection                              |
| `sa`, `sd`, `sr`                    | Add, delete, or replace surrounding characters                           |
| `<C-n>` in normal or visual mode    | Start or extend multiple cursors                                         |
| `<leader>?`                         | Show buffer-local keymaps                                                |
| `<C-h/j/k/l>`                       | Move between Neovim or tmux panes                                        |
| `<leader>sv/sh/se/sx`               | Vertical split, horizontal split, equalize, close                        |
| `<leader>bn/bb/bq`                  | New buffer, pick buffer, close buffer                                    |
| `<S-h>/<S-l>`                       | Previous/next buffer                                                     |
| `<leader>ff/fg/fb/fr/fh/fc`         | Files, grep, buffers, recent, help, commands                             |
| `<leader>fs/fS`                     | Document/workspace symbols                                               |
| `<leader>et/er/eb`                  | Explorer toggle, reveal file, buffer tree                                |
| `K`, `gd`, `gD`, `gi`, `gr`         | Hover, definition, declaration, implementation, references               |
| `<leader>rn/ca/cs/ih`               | Rename, code action, signature help, inlay hints                         |
| `[d`/`]d`, `<leader>dl`             | Previous/next diagnostic, diagnostic popup                               |
| `<C-Space>`, `<C-n>/<C-p>`, `<C-y>` | Request, navigate, accept native completion                              |
| `<leader>xx/xb/xr/xq/xl`            | Workspace problems, buffer problems, references, quickfix, location list |
| `]h`/`[h`, `<leader>gp/ga/gr/gb`    | Git hunks, preview, stage, reset, blame                                  |
| `<leader>cf`                        | Format buffer                                                            |
| `<leader>db/dc/dn/di/do/dx`         | Breakpoint, continue, step over, step into, step out, stop               |
| `<leader>dB/dr/du/de`               | Conditional breakpoint, console, UI, evaluate                            |

The Neo-tree sidebar has built-in file creation, deletion, rename, and hidden-file controls. Use `?` in the sidebar to inspect its mappings. The debugger UI shows variables, watches, call stack, breakpoints, and console during a session.

## Formatting and Python debugging

Saving a writable text file trims trailing whitespace and final blank lines, then leaves one empty final line. This includes Markdown. Conform runs Ruff import organization then Ruff formatting for Python, gopls formatting for Go, Stylua for Lua, and shfmt for shell. `<leader>cf` formats manually. `:ConformInfo` shows active formatter availability.

Tree-sitter installs the listed common parsers at startup. Opening another supported file type installs its parser on demand and starts highlighting when the installation finishes. Unsupported file types do not trigger a download.

Python debugging launches the current file or attaches to a host and port through `debugpy-adapter`. A project `.venv/bin/python` is preferred; otherwise `python3` is used. Start with `<leader>dc` and select a configuration. The Python process must have `debugpy` available for launch or attach.

Mini AI adds text objects, with next and previous variants on `aN`/`iN` and `aL`/`iL`. Mini Pairs inserts matching brackets and quotes in insert mode; it leaves `<CR>` and `<BS>` to Neovim and completion, and pauses while multiple cursors are active. In multiple-cursor mode, press `<Esc>` to leave the selection. Opening Neovim without a path shows the Alpha dashboard. Core options, keymaps, autocommands, and LSP behavior are in `lua/core/`; plugin specifications are in `lua/plugins/`; server definitions are in `lsp/`.
