--
-- Configure Python debugging and the DAP interface.
--
return {
  {
    "mfussenegger/nvim-dap",
    keys = {
      { "<leader>db", function() require("dap").toggle_breakpoint() end, desc = "Toggle breakpoint" },
      { "<leader>dB", function() require("dap").set_breakpoint(vim.fn.input("Condition: ")) end, desc = "Conditional breakpoint" },
      { "<leader>dc", function() require("dap").continue() end, desc = "Continue or start" },
      { "<leader>dn", function() require("dap").step_over() end, desc = "Step over" },
      { "<leader>di", function() require("dap").step_into() end, desc = "Step into" },
      { "<leader>do", function() require("dap").step_out() end, desc = "Step out" },
      { "<leader>dx", function() require("dap").terminate() end, desc = "Terminate session" },
      { "<leader>dr", function() require("dap").repl.open() end, desc = "Debug console" },
    },
    config = function()
      local dap = require("dap")
      dap.adapters.python = {
        type = "executable",
        command = "debugpy-adapter",
      }

      -- Debug with project dependencies when a local virtual environment exists.
      local function python_path()
        local root = vim.fs.root(0, { "pyproject.toml", "setup.py", "setup.cfg", ".git" }) or vim.fn.getcwd()
        local venv = root .. "/.venv/bin/python"
        if vim.fn.executable(venv) == 1 then return venv end
        return vim.fn.exepath("python3")
      end

      dap.configurations.python = {
        {
          type = "python",
          request = "launch",
          name = "Launch current Python file",
          program = "${file}",
          cwd = "${workspaceFolder}",
          pythonPath = python_path,
          console = "integratedTerminal",
        },
        {
          type = "python",
          request = "attach",
          name = "Attach to Python process",
          connect = {
            host = function() return vim.fn.input("Host [127.0.0.1]: ", "127.0.0.1") end,
            port = function() return tonumber(vim.fn.input("Port [5678]: ", "5678")) end,
          },
          pythonPath = python_path,
        },
      }
    end,
  },
  {
    "rcarriga/nvim-dap-ui",
    event = "VeryLazy",
    dependencies = { "mfussenegger/nvim-dap", "nvim-neotest/nvim-nio" },
    keys = {
      { "<leader>du", function() require("dapui").toggle() end, desc = "Toggle debugger UI" },
      { "<leader>de", function() require("dapui").eval() end, desc = "Evaluate expression" },
    },
    config = function()
      local dap = require("dap")
      local ui = require("dapui")
      ui.setup()
      dap.listeners.after.event_initialized["nvim_new_dapui"] = function() ui.open() end
      dap.listeners.before.event_terminated["nvim_new_dapui"] = function() ui.close() end
      dap.listeners.before.event_exited["nvim_new_dapui"] = function() ui.close() end
    end,
  },
}
