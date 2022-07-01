local M = {}

local utils = require('lvim.utils')

M.config = function()
  lvim.builtin.dap = {
    active = false,
    on_config_done = nil,
    breakpoint = {
      text = "🔴",
      texthl = "LspDiagnosticsSignError",
      linehl = "",
      numhl = "",
    },
    breakpoint_rejected = {
      text = "🪲",
      texthl = "LspDiagnosticsSignHint",
      linehl = "",
      numhl = "",
    },
    stopped = {
      text = "",
      texthl = "LspDiagnosticsSignInformation",
      linehl = "DiagnosticUnderlineInfo",
      numhl = "LspDiagnosticsSignInformation",
    },
    install_path = utils.join_paths(vim.call('stdpath', 'data'), 'dapinstall/'),
  }
end

M.setup = function()
  local dap, dapui  = require "dap", require 'dapui'
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

  -- defined dapui
  dap.defaults.fallback.terminal_win_cmd = "50vsplit new"
  require('dap.ext.vscode').load_launchjs(nil, { cppdgb = { "cpp" } })

  -- dapui config
  dap.listeners.after.event_initialized['dapui_config'] = function()
    dapui.open()
    vim.api.nvim_command("DapVirtualTextEnable")
    dapui.close('tray')
  end
  dap.listeners.before.event_terminated['dapui_config'] = function()
    vim.api.nvim_command("DapVirtualTextDisable")
    dapui.close()
  end
  dap.listeners.before.event_exited['dapui_config'] = function()
    vim.api.nvim_command("DapVirtualTextDisable")
    dapui.close()
  end
  -- for some debug adapter, terminate to exit events will no fire, use disconnect reuset instead
  dap.listeners.before.disconnect['dapui_config'] = function()
    vim.api.nvim_command("DapVirtualTextDisable")
    dapui.close()
  end

  -- debug keybindings
  M.dap_keybings()

  -- debug level
  dap.set_log_level("DEBUG")

  -- dap_config
  dap_install.config("python", {})

  if lvim.builtin.dap.on_config_done then
    lvim.builtin.dap.on_config_done(dap)
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
