local conditions = require "lvim.core.lualine.conditions"
local colors = require "lvim.core.lualine.colors"
local icons = require "lvim.icons"

local function diff_source()
  local gitsigns = vim.b.gitsigns_status_dict
  if gitsigns then
    return {
      added = gitsigns.added,
      modified = gitsigns.changed,
      removed = gitsigns.removed,
    }
  end
end

local location_color = nil
local branch = lvim.icons.git.Branch

-- if lvim.colorscheme == "tokyonight" then
--   location_color = "SLBranchName"
--   branch = "%#SLGitIcon#" .. lvim.icons.git.Branch .. "%*" .. "%#SLBranchName#"

--   local status_ok, tnc = pcall(require, "tokyonight.colors")
--   if status_ok then
--     local tncolors = tnc.setup { transform = true }
--     vim.api.nvim_set_hl(0, "SLSeparator", { fg = cursorline_hl.background, bg = tncolors.black })
--     separator = "%#SLSeparator#" .. lvim.icons.ui.LineMiddle .. "%*"
--   end
-- end
--
-- if lvim.colorscheme == "lunar" then
--   branch = "%#SLGitIcon#" .. lvim.icons.git.Branch .. "%*" .. "%#SLBranchName#"
-- end

return {
  edge = {
    function()
      return icons.ui.edge
    end,
    color = { bg = "none", gui = "bold", fg = colors.blue },
  },
  mode = {
    "mode",
    fmt = function(str)
      if str == "NORMAL" then
        return " " .. icons.nvim.mode .. "  "
      end
      return " " .. icons.nvim.edit .. "  "
    end,
    padding = { left = 0, right = 0 },
    color = { bg = "none", gui = "bold", fg = colors.blue },
    cond = nil,
  },
  branch = {
    "b:gitsigns_head",
    icon = branch,
    color = { bg = "none", gui = "bold" },
  },
  filename = {
    "filename",
    color = { bg = "none" },
    cond = nil,
  },
  diff = {
    "diff",
    source = diff_source,
    symbols = {
      added = lvim.icons.git.LineAdded,
      modified = lvim.icons.git.LineModified,
      removed = lvim.icons.git.LineRemoved,
    },
    padding = { left = 2, right = 1 },
    diff_color = {
      added = { fg = colors.green },
      modified = { fg = colors.yellow },
      removed = { fg = colors.red },
    },
    color = { bg = "none" },
    cond = nil,
  },
  python_env = {
    function()
      local utils = require "lvim.core.lualine.utils"
      if vim.bo.filetype == "python" then
        local venv = os.getenv "CONDA_DEFAULT_ENV" or os.getenv "VIRTUAL_ENV"
        if venv then
          local web_icons = require "nvim-web-devicons"
          local py_icon, _ = web_icons.get_icon ".py"
          return string.format(" " .. py_icon .. " (%s)", utils.env_cleanup(venv))
        end
      end
      return ""
    end,
    color = { fg = colors.green, bg = "none" },
    cond = conditions.hide_in_width,
  },
  diagnostics = {
    "diagnostics",
    sources = { "nvim_diagnostic" },
    sections = { "error", "warn" },
    color = {
      bg = "none",
      gui = "bold",
    },
    colored = false,
    always_visible = true,
    symbols = {
      error = lvim.icons.diagnostics.Error .. " ",
      warn = lvim.icons.diagnostics.Warning .. " ",
      -- info = lvim.icons.diagnostics.BoldInformation .. " ",
      -- hint = lvim.icons.diagnostics.BoldHint .. " ",
    },
    cond = conditions.hide_in_width,
  },
  treesitter = {
    function()
      return lvim.icons.nvim.mode .. " TS"
    end,
    color = function()
      local buf = vim.api.nvim_get_current_buf()
      local ts = vim.treesitter.highlighter.active[buf]
      return { fg = ts and not vim.tbl_isempty(ts) and colors.green or colors.red, bg = "none" }
    end,
    cond = conditions.hide_in_width,
  },
  copilot = {
    function(msg)
      local buf_clients = vim.lsp.get_clients()
      if next(buf_clients) == nil then
        if type(msg) == "boolean" or #msg == 0 then
          return ""
        end
        return msg
      end
      local copilot_active = false
      for _, client in pairs(buf_clients) do
        if client.name == "copilot" then
          copilot_active = true
        end
      end
      if copilot_active then
        return "copilot"
      end
    end,
    color = { fg = colors.green, bg = "none" },
  },
  lsp = {
    function()
      local buf_clients = vim.lsp.get_clients { bufnr = 0 }
      if #buf_clients == 0 then
        return icons.ui.lsp .. " "
      end

      local buf_ft = vim.bo.filetype
      local buf_client_names = {}

      -- add client
      for _, client in pairs(buf_clients) do
        if client.name ~= "null-ls" and client.name ~= "copilot" then
          table.insert(buf_client_names, client.name)
        end
      end

      -- add formatter
      local formatters = require "lvim.lsp.null-ls.formatters"
      local supported_formatters = formatters.list_registered(buf_ft)

      vim.list_extend(buf_client_names, supported_formatters)

      -- add linter
      local linters = require "lvim.lsp.null-ls.linters"
      local supported_linters = linters.list_registered(buf_ft)
      vim.list_extend(buf_client_names, supported_linters)

      local unique_client_names = table.concat(buf_client_names, " · ")
      local language_servers = string.format(icons.ui.lsp .. "  %s", unique_client_names)

      return language_servers
    end,
    color = { gui = "bold", bg = "none" },
    cond = conditions.hide_in_width,
  },
  progress = { "progress", cond = conditions.hide_in_width, color = { bg = "none" } },
  platform = {
    "fileformat",
    cond = conditions.hide_in_width,
    color = { bg = "none", fg = colors.violet },
  },
  location = {
    "location",
    color = { bg = "none", fg = colors.cyan },
  },
  -- progress = {
  --   "progress",
  --   fmt = function()
  --     return "%P/%L"
  --   end,
  --   color = { bg = "none" },
  -- },

  spaces = {
    function()
      local shiftwidth = vim.api.nvim_get_option_value("shiftwidth", { buf = 0 })
      return lvim.icons.ui.Tab .. " " .. shiftwidth
    end,
    color = { bg = "none" },
    padding = 1,
  },
  encoding = {
    "o:encoding",
    fmt = string.upper,
    color = { bg = "none" },
    cond = conditions.hide_in_width,
  },
  filetype = {
    "filetype",
    cond = nil,
    color = { bg = "none" },
    padding = { left = 1, right = 1 },
  },
  scrollbar = {
    function()
      local current_line = vim.fn.line "."
      local total_lines = vim.fn.line "$"
      local chars = { "__", "▁▁", "▂▂", "▃▃", "▄▄", "▅▅", "▆▆", "▇▇", "██" }
      local line_ratio = current_line / total_lines
      local index = math.ceil(line_ratio * #chars)
      return chars[index]
    end,
    padding = { left = 1, right = 1 },
    color = { fg = colors.yellow, bg = "none" },
    cond = nil,
  },
}
