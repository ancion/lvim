local M = {}

local utils = require('lvim.utils')

M.config = function()
  lvim.builtin.dap = {
    active = false,
    on_config_done = nil,
    breakpoint = {
     -- text = "🔴",
      text = lvim.icons.ui.Bug,
      texthl = "LspDiagnosticsSignError",
      linehl = "",
      numhl = "",
    },
    breakpoint_rejected = {
     --  text = "🪲",
      text = lvim.icons.ui.Bug,
      texthl = "LspDiagnosticsSignHint",
      linehl = "",
      numhl = "",
    },
    stopped = {
      text = lvim.icons.ui.BoldArrowRight,
      texthl = "LspDiagnosticsSignInformation",
      linehl = "DiagnosticUnderlineInfo",
      numhl = "LspDiagnosticsSignInformation",
    },
    install_path = utils.join_paths(vim.call('stdpath', 'data'), 'dapinstall/'),
    dap_ui_opt = {
      icons = { expanded = "", collapsed = "" },
      mappings = {
        -- Use a table to apply multiple mappings
        expand = { "o", "<2-LeftMouse>", "<CR>" },
        open = "O",
        remove = "d",
        edit = "e",
        repl = "r",
        toggle = "t",
      },
      layouts = {
        {
          -- You can change the order of elements in the sidebar
          elements = {
            { id = "scopes", size = 0.38 }, -- Can be float or integer > 1
            { id = "stacks", size = 0.35 },
            { id = "watches", size = 0.15 },
            { id = "breakpoints", size = 0.12 },
          },
          size = 40,
          position = "left", -- Can be "left", "right", "top", "bottom"
        },
        {
          elements = {
            { id = "repl", size = 0.5 },
            { id = "console", size = 0.5 },
          },
          size = 15,
          position = "bottom", -- Can be "left", "right", "top", "bottom"
        }
      },
      floating = {
        max_height = nil, -- These can be integers or a float between 0 and 1.
        max_width = nil, -- Floats will be treated as percentage of your screen.
        border = "single", -- Border style. Can be "single", "double" or "rounded"
        mappings = {
          close = { "q", "<Esc>" },
        },
      },
      windows = { indent = 1 },
    }
  }
end

M.setup = function()
  local dap_install = require 'dap-install'

  -- defined dap install_path
  dap_install.setup({
    installation_path = lvim.builtin.dap.install_path
  })

  -- defined sign
  if lvim.use_icons then
    vim.fn.sign_define("DapBreakpoint", lvim.builtin.dap.breakpoint)
    vim.fn.sign_define("DapBreakpointRejected", lvim.builtin.dap.breakpoint_rejected)
    vim.fn.sign_define("DapStopped", lvim.builtin.dap.stopped)
  end

  -- set_dap_ui grid
  M.set_dap_ui()

  -- debug keybindings
  M.dap_keybings()

  -- more develop language config
  M.config_debug()

  -- dap_config
  dap_install.config("python", {})
end


-- 配置调试的信息
M.config_debug = function()
  local dap = require("dap")

  -- defined dapui
  dap.defaults.fallback.terminal_win_cmd = "50vsplit new"
  -- debug level
  dap.set_log_level("DEBUG")

  -- debug cpp
  require('dap.ext.vscode').load_launchjs(nil, { cppdgb = { "cpp" } })


  if lvim.builtin.dap.on_config_done then
    lvim.builtin.dap.on_config_done(dap)
  end
end


M.set_dap_ui = function()
  local dap, dapui = require "dap", require 'dapui'

  dapui.setup(lvim.builtin.dap.dap_ui_opt)

  local debug_open = function()
    dapui.open()
    vim.api.nvim_command("DapVirtualTextEnable")
  end
  local debug_close = function()
    dap.repl.close()
    dapui.close()
    vim.api.nvim_command("DapVirtualTextDisable")
    --vim.api.nvim_command("bdelete! term:") -- close debug terminal
  end

  -- dapui config
  dap.listeners.after.event_initialized['dapui_config'] = function()
    debug_open()
  end
  dap.listeners.before.event_terminated['dapui_config'] = function()
    debug_close()
  end
  dap.listeners.before.event_exited['dapui_config'] = function()
    debug_close()
  end
  -- for some debug adapter, terminate to exit events will no fire, use disconnect reuset instead
  dap.listeners.before.disconnect['dapui_config'] = function()
    debug_close()
  end
end

M.dap_keybings = function()
  -- lvim.builtin.which_key.mappings["d"] = {
  --   name = "Debug",
  --   t = { "<cmd>lua require'dap'.toggle_breakpoint()<cr>", "Toggle Breakpoint" },
  --   b = { "<cmd>lua require'dap'.step_back()<cr>", "Step Back" },
  --   c = { "<cmd>lua require'dap'.continue()<cr>", "Continue" },
  --   C = { "<cmd>lua require'dap'.run_to_cursor()<cr>", "Run To Cursor" },
  --   d = { "<cmd>lua require'dap'.disconnect()<cr>", "Disconnect" },
  --   g = { "<cmd>lua require'dap'.session()<cr>", "Get Session" },
  --   i = { "<cmd>lua require'dap'.step_into()<cr>", "Step Into" },
  --   o = { "<cmd>lua require'dap'.step_over()<cr>", "Step Over" },
  --   u = { "<cmd>lua require'dap'.step_out()<cr>", "Step Out" },
  --   p = { "<cmd>lua require'dap'.pause.toggle()<cr>", "Pause" },
  --   r = { "<cmd>lua require'dap'.repl.toggle()<cr>", "Toggle Repl" },
  --   s = { "<cmd>lua require'dap'.continue()<cr>", "Start" },
  --   q = { "<cmd>lua require'dap'.close()<cr>", "Quit" },
  -- }
  vim.api.nvim_set_keymap("n", '<F3>', "<cmd>lua require'dap'.pause.toggle()<cr>", {})
  vim.api.nvim_set_keymap("n", '<F4>', "<cmd>lua require'dap'.repl.toggle()<cr>", {})
  vim.api.nvim_set_keymap("n", '<F5>', "<cmd>lua require'dap'.continue()<cr>", {})
  vim.api.nvim_set_keymap("n", "<F6>", "<cmd>lua require'dap'.step_back()<cr>", {})
  vim.api.nvim_set_keymap("n", '<F7>', "<cmd>lua require'dap'.step_into()<cr>", {})
  vim.api.nvim_set_keymap("n", '<F8>', "<cmd>lua require'dap'.step_over()<cr>", {})
  vim.api.nvim_set_keymap("n", "<F9>", "<cmd>lua require'dap'.toggle_breakpoint()<cr>", {})
  vim.api.nvim_set_keymap("n", '<F10>', "<cmd>lua require'dap'.step_out()<cr>", {})
  vim.api.nvim_set_keymap("n", '<F20>', "<cmd>lua require'dap'.run_to_cursor()<cr>", {})
  vim.api.nvim_set_keymap("n", "<F17>", "<cmd>lua require'dap'.close()<cr>", {})
end

function M.reload_continue()
  local dap = require "dap"
  dap.continue()
end

-- TODO: put this up there ^^^ call in ftplugin

-- M.dap = function()
--   if lvim.plugin.dap.active then
--     local dap_install = require "dap-install"
--     dap_install.config("python_dbg", {})
--   end
-- end
--
-- M.dap = function()
--   -- gem install readapt ruby-debug-ide
--   if lvim.plugin.dap.active then
--     local dap_install = require "dap-install"
--     dap_install.config("ruby_vsc_dbg", {})
--   end
-- end

return M
