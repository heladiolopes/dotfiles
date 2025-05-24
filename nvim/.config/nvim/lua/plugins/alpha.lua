return {
  "goolord/alpha-nvim",
  event = "VimEnter",
  dependencies = {
    "nvim-tree/nvim-web-devicons",
  },
  config = function()
    local alpha = require("alpha")
    local dashboard = require("alpha.themes.dashboard")

    local header = {
      [[                                                                       ]],
      [[                                                                       ]],
      [[                                                                       ]],
      [[                                                                       ]],
      [[                                                                       ]],
      [[                                                                     ]],
      [[       ████ ██████           █████      ██                     ]],
      [[      ███████████             █████                             ]],
      [[      █████████ ███████████████████ ███   ███████████   ]],
      [[     █████████  ███    █████████████ █████ ██████████████   ]],
      [[    █████████ ██████████ █████████ █████ █████ ████ █████   ]],
      [[  ███████████ ███    ███ █████████ █████ █████ ████ █████  ]],
      [[ ██████  █████████████████████ ████ █████ █████ ████ ██████ ]],
      [[                                                                       ]],
      [[                                                                       ]],
      [[                                                                       ]],
      [[                                                                       ]],
      [[                                                                       ]],
    }

    dashboard.section.header.val = header

    dashboard.section.buttons.val = {
      dashboard.button("e", "  File explorer", "<cmd>Neotree toggle<CR>"),
      dashboard.button("f", "  Find file", "<cmd>Telescope find_files previewer=false<CR>"),
      dashboard.button("w", "  Find word", "<cmd>Telescope live_grep<CR>"),
      dashboard.button("r", "  Recent", "<cmd>Telescope oldfiles<CR>"),
      dashboard.button("c", "  Config", "<cmd>e $MYVIMRC<CR>"),
      dashboard.button("l", "󰒲  Lazy", "<cmd>Lazy<CR>"),
      dashboard.button("m", "  Mason", "<cmd>Mason<CR>"),
      dashboard.button("q", "󰿅  Quit NVIM", "<cmd>qa<CR>"),
    }

    dashboard.opts.opts.noautocmd = true -- This prevents any unwanted autocommands (e.g., BufRead, BufEnter)

    alpha.setup(dashboard.opts)

    vim.api.nvim_create_autocmd("User", { -- Measure start up time
      pattern = "LazyVimStarted",
      callback = function()
        local plugins = require("lazy").stats()
        local time = (math.floor(plugins.startuptime * 100) / 100)

        dashboard.section.footer.val = {
          " ",
          " ",
          " ",
          "󱐌 " .. plugins.count .. " plugins loaded in " .. time .. " ms",
        }
        pcall(vim.cmd.AlphaRedraw)
      end,
    })
  end,
}
