local M = {}

local utils = require('lvim.utils')

M.config = function()
  lvim.builtin.dap = {
    active = true,
    on_config_done = nil,
    breakpoint = {
      text = lvim.icons.ui.Breakpoint,
      texthl = "DiagnosticSignError",
      linehl = "",
      numhl = "",
    },
    breakpoint_rejected = {
      text = lvim.icons.ui.BugText,
      texthl = "DiagnosticSignError",
      linehl = "",
      numhl = "",
    },
    stopped = {
      text = lvim.icons.ui.BoldArrowRight,
      texthl = "DiagnosticSignWarn",
      linehl = "Visual",
      numhl = "DiagnosticSignWarn",
    },
    log = {
      level = "info",
    },
    ui = {
      auto_open = true,
      notify = {
        threshold = vim.log.levels.INFO,
      },
      config = {
        expand_lines = true,
        icons = {
          expanded = lvim.icons.ui.ChevronShortDown,
          collapsed = lvim.icons.ui.NormalArrowRight,
          circular = lvim.icons.ui.Circular,
          current_frame = " " .. lvim.icons.ui.Frame,
        },
        -- icons = { expanded = "", collapsed = "", circular = "" },
        mappings = {
          -- Use a table to apply multiple mappings
          expand = { "<CR>", "<2-LeftMouse>" },
          open = "o",
          remove = "d",
          edit = "e",
          repl = "r",
          toggle = "t",
        },
        -- Use this to override mappings for specific elements
        element_mappings = {},
        layouts = {
          {
            elements = {
              { id = "scopes", size = 0.38 },
              { id = "watches", size = 0.20 },
              { id = "breakpoints", size = 0.17 },
              { id = "stacks", size = 0.25 },
            },
            size = 0.33,
            position = "right",
          },
          {
            elements = {
              { id = "repl", size = 0.40 },
              { id = "console", size = 0.60 },
            },
            size = 0.25,
            position = "bottom",
          },
        },
        floating = {
          max_height = 0.9,
          max_width = 0.5, -- Floats will be treated as percentage of your screen.
          border = vim.g.border_chars, -- Border style. Can be 'single', 'double' or 'rounded'
          mappings = {
            close = { "q", "<Esc>" },
          },
        },
        controls = {
          enabled = true,
          -- Display controls in this element
          element = "repl",
          icons = {
            pause = lvim.icons.ui.Pause,
            play = lvim.icons.ui.Play,
            step_into = lvim.icons.ui.StepInto,
            step_over = lvim.icons.ui.StepOver,
            step_out = lvim.icons.ui.StepOut,
            step_back = lvim.icons.ui.StepBack,
            run_last = lvim.icons.ui.RunLast,
            terminate = lvim.icons.ui.Terminate,
          }
        },
        windows = { indent = 1 },
        render = {
          max_type_length = nil, -- Can be integer or nil.
          max_value_lines = 100, -- Can be integer or nil.
        },
      },
    },
  }
end

M.setup = function()
  local status_ok, dap = pcall(require, "dap")
  if not status_ok then
    return
  end

  -- defined sign
  if lvim.use_icons then
    vim.fn.sign_define("DapBreakpoint", lvim.builtin.dap.breakpoint)
    vim.fn.sign_define("DapBreakpointRejected", lvim.builtin.dap.breakpoint_rejected)
    vim.fn.sign_define("DapStopped", lvim.builtin.dap.stopped)
  end

  -- debug keybindings
  M.dap_keybings()

  -- more develop language config
  M.config_debug()

  dap.set_log_level(lvim.builtin.dap.log.level)

  require("lvim.core.dap.dap_python")
  require("lvim.core.dap.dap_js")
  require("lvim.core.dap.dap_bash")
  require("lvim.core.dap.dap_go")

  if lvim.builtin.dap.on_config_done then
    lvim.builtin.dap.on_config_done(dap)
  end
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
  --   p = { "<cmd>lua require'dap'.pause()<cr>", "Pause" },
  --   r = { "<cmd>lua require'dap'.repl.toggle()<cr>", "Toggle Repl" },
  --   s = { "<cmd>lua require'dap'.continue()<cr>", "Start" },
  --   q = { "<cmd>lua require'dap'.close()<cr>", "Quit" },
  --   U = { "<cmd>lua require'dapui'.toggle()<cr>", "Toggle UI" },
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
M.setup_ui = function()
  local status_ok, dap = pcall(require, "dap")
  if not status_ok then
    return
  end
  local dapui = require "dapui"
  dapui.setup(lvim.builtin.dap.ui.config)

  if lvim.builtin.dap.ui.auto_open then
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
    dap.listeners.after.event_initialized["dapui_config"] = function()
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

  local Log = require "lvim.core.log"

  -- until rcarriga/nvim-dap-ui#164 is fixed
  local function notify_handler(msg, level, opts)
    if level >= lvim.builtin.dap.ui.notify.threshold then
      return vim.notify(msg, level, opts)
    end

    opts = vim.tbl_extend("keep", opts or {}, {
      title = "dap-ui",
      icon = "",
      on_open = function(win)
        vim.api.nvim_buf_set_option(vim.api.nvim_win_get_buf(win), "filetype", "markdown")
      end,
    })

    -- vim_log_level can be omitted
    if level == nil then
      level = Log.levels["INFO"]
    elseif type(level) == "string" then
      level = Log.levels[(level):upper()] or Log.levels["INFO"]
    else
      -- https://github.com/neovim/neovim/blob/685cf398130c61c158401b992a1893c2405cd7d2/runtime/lua/vim/lsp/log.lua#L5
      level = level + 1
    end

    msg = string.format("%s: %s", opts.title, msg)
    Log:add_entry(level, msg)
  end

  local dapui_ok, _ = xpcall(function()
    require("dapui.util").notify = notify_handler
  end, debug.traceback)
  if not dapui_ok then
    Log:debug "Unable to override dap-ui logging level"
  end
end

return M
