----------------------------------------------------------------------------------------------------
-- THESE ARE EXAMPLE CONFIGS FEEL FREE TO CHANGE TO WHATEVER YOU WANT
----------------------------------------------------------------------------------------------------

--[[
----------------------------------------------------------------------------------------------------
-- lvim is the global options object
-- Linters should be filled in as strings with either, a global executable or a path to an executable
----------------------------------------------------------------------------------------------------
--]]


-- [[
---------------------------------------------------------------------------------------------------
-- general
---------------------------------------------------------------------------------------------------
-- ]]
lvim.log.level = "warn"
lvim.format_on_save = true
-- lvim.colorscheme = "onedarker"
-- lvim.colorscheme = "tokyonight"
-- lvim.colorscheme = "dracula"
-- lvim.colorscheme = "NeoSolarized"
lvim.colorscheme = "catppuccin"


-- [[
---------------------------------------------------------------------------------------------------
-- keymappings (view all the defaults by pressing <leader>Lk)
---------------------------------------------------------------------------------------------------
--]]
lvim.leader = "space"
lvim.use_icons = true;

-- add your own keymapping
lvim.keys.normal_mode["<C-s>"] = ":w<cr>"
-- unmap a default keymapping
-- lvim.keys.normal_mode["<C-Up>"] = false
-- edit a default keymapping
-- lvim.keys.normal_mode["<C-q>"] = ":q<cr>"


-- Change Telescope navigation to use j and k for navigation and n and p for history in both input and normal mode.
-- we use protected-mode (pcall) just in case the plugin wasn't loaded yet.
-- local _, actions = pcall(require, "telescope.actions")
-- lvim.builtin.telescope.defaults.mappings = {
--   -- for input mode
--   i = {
--     ["<C-j>"] = actions.move_selection_next,
--     ["<C-k>"] = actions.move_selection_previous,
--     ["<C-n>"] = actions.cycle_history_next,
--     ["<C-p>"] = actions.cycle_history_prev,
--   },
--   -- for normal mode
--   n = {
--     ["<C-j>"] = actions.move_selection_next,
--     ["<C-k>"] = actions.move_selection_previous,
--   },
-- }

-- Use which-key to add extra bindings with the leader-key prefix
-- lvim.builtin.which_key.mappings["P"] = { "<cmd>Telescope projects<CR>", "Projects" }
-- lvim.builtin.which_key.mappings["t"] = {
--   name = "+Trouble",
--   r = { "<cmd>Trouble lsp_references<cr>", "References" },
--   f = { "<cmd>Trouble lsp_definitions<cr>", "Definitions" },
--   d = { "<cmd>Trouble lsp_document_diagnostics<cr>", "Diagnostics" },
--   q = { "<cmd>Trouble quickfix<cr>", "QuickFix" },
--   l = { "<cmd>Trouble loclist<cr>", "LocationList" },
--   w = { "<cmd>Trouble lsp_workspace_diagnostics<cr>", "Diagnostics" },
-- }


-- [[
---------------------------------------------------------------------------------------------------
-- TODO: User Config for predefined plugins
-- After changing plugin config exit and reopen LunarVim, Run :PackerInstall :PackerCompile
---------------------------------------------------------------------------------------------------
--]]
lvim.builtin.alpha.active = true
lvim.builtin.notify.active = true
lvim.builtin.terminal.active = true
lvim.builtin.dap.active = true
lvim.builtin.nvimtree.setup.view.side = "left"
lvim.builtin.nvimtree.show_icons.git = 0

-- [[
---------------------------------------------------------------------------------------------------
-- if you don't want all the parsers change this to a table of the ones you want
---------------------------------------------------------------------------------------------------
--]]
lvim.builtin.treesitter.ensure_installed = {
  "bash",
  "c",
  "javascript",
  "json",
  "lua",
  "python",
  "typescript",
  "tsx",
  "css",
  "java",
  "yaml",
  "dart",
}

lvim.builtin.treesitter.ignore_install = { "haskell" }
lvim.builtin.treesitter.highlight.enabled = true

-- [[
---------------------------------------------------------------------------------------------------
--generic LSP settings
---------------------------------------------------------------------------------------------------
-- ]]

-- ---@usage disable automatic installation of servers
-- lvim.lsp.automatic_servers_installation = false

-- ---@usage Select which servers should be configured manually. Requires `:LvimCacheRest` to take effect.
-- See the full default list `:lua print(vim.inspect(lvim.lsp.override))`
-- vim.list_extend(lvim.lsp.override, { "pyright" })

-- ---@usage setup a server -- see: https://www.lunarvim.org/languages/#overriding-the-default-configuration
-- local opts = {} -- check the lspconfig documentation for a list of all possible options
-- require("lvim.lsp.manager").setup("pylsp", opts)

-- -- you can set a custom on_attach function that will be used for all the language servers
-- -- See <https://github.com/neovim/nvim-lspconfig#keybindings-and-completion>
-- lvim.lsp.on_attach_callback = function(client, bufnr)
--   local function buf_set_option(...)
--     vim.api.nvim_buf_set_option(bufnr, ...)
--   end
--   --Enable completion triggered by <c-x><c-o>
--   buf_set_option("omnifunc", "v:lua.vim.lsp.omnifunc")
-- end

---------------------------------------------------------------------------------------------------
-- set a formatter, this will override the language server formatting capabilities (if it exists)
-- ------------------------------------------------------------------------------------------------
-- local formatters = require "lvim.lsp.null-ls.formatters"
-- formatters.setup {
--   { command = "black", filetypes = { "python" } },
--   { command = "isort", filetypes = { "python" } },
--   {
--     -- each formatter accepts a list of options identical to https://github.com/jose-elias-alvarez/null-ls.nvim/blob/main/doc/BUILTINS.md#Configuration
--     command = "prettier",
--     ---@usage arguments to pass to the formatter
--     -- these cannot contain whitespaces, options such as `--line-width 80` become either `{'--line-width', '80'}` or `{'--line-width=80'}`
--     extra_args = { "--print-with", "100" },
--     ---@usage specify which filetypes to enable. By default a providers will attach to all the filetypes it supports.
--     filetypes = { "typescript", "typescriptreact" },
--   },
-- }

---------------------------------------------------------------------------------------------------
-- -- set additional linters
---------------------------------------------------------------------------------------------------
-- local linters = require "lvim.lsp.null-ls.linters"
-- linters.setup {
--   { command = "flake8", filetypes = { "python" } },
--   {
--     -- each linter accepts a list of options identical to https://github.com/jose-elias-alvarez/null-ls.nvim/blob/main/doc/BUILTINS.md#Configuration
--     command = "shellcheck",
--     ---@usage arguments to pass to the formatter
--     -- these cannot contain whitespaces, options such as `--line-width 80` become either `{'--line-width', '80'}` or `{'--line-width=80'}`
--     extra_args = { "--severity", "warning" },
--   },
--   {
--     command = "codespell",
--     ---@usage specify which filetypes to enable. By default a providers will attach to all the filetypes it supports.
--     filetypes = { "javascript", "python" },
--   },
-- }


--[[
---------------------------------------------------------------------------------------------------
-- Additional Plugins
---------------------------------------------------------------------------------------------------
--]]

lvim.plugins = {
  -- litee family
  {
    "ldelossa/litee.nvim",
    config = function()
      require("litee.lib").setup({
        panel = {
          orientation = "right",
          panel_size = 50,
        }
      })
    end
  },
  {
    "ldelossa/litee-calltree.nvim",
    config = function()
      require("litee.calltree").setup({
        -- NOTE: the plugin is in-developing
        on_open = "pannel", -- panel | popout
        hide_cursor = false,
        keymaps = {
          expand = "o",
          collapse = "zc",
          collapse_all = "zM",
          jump = "<CR>",
          jump_split = "s",
          jump_vsplit = "v",
          jump_tab = "t",
          hover = "i",
          details = "d",
          close = "Q",
          close_panel_pop_out = "Q",
          help = "?",
          hide = "H",
          switch = "S",
          focus = "f"
        }
      })
    end
  },
  -- colorscheme
  { "folke/tokyonight.nvim" },
  { "Mofiqul/dracula.nvim" },
  { "overcache/NeoSolarized" },
  { "catppuccin/nvim", as = "catppuccin" },

  -- colorPanel
  {
    'norcalli/nvim-colorizer.lua',
    config = function()
      require("colorizer").setup()
    end
  },

  -- todo_comments
  {
    "folke/todo-comments.nvim",
    config = function()
      require("todo-comments").setup({
        keywords = {
          --alt : alise
          FIX  = { icon = " ", color = "#DC2626", alt = { "FIXME", "BUG", "FIXIT", "ISSUE", "!" } },
          TODO = { icon = " ", color = "#2563EB" },
          HACK = { icon = " ", color = "#7C3AED" },
          WARN = { icon = " ", color = "#FBBF24", alt = { "WARNING", "XXX" } },
          PERF = { icon = " ", color = "#FC9868", alt = { "OPTIM", "PERFORMANCE", "OPTIMIZE" } },
          NOTE = { icon = " ", color = "#10B981", alt = { "INFO" } }
        }
      })
    end
  },

  { 'github/copilot.vim' },
  {
    "zbirenbaum/copilot.lua",
    event = { "VimEnter" },
    config = function()
      vim.defer_fn(function()
        require("copilot").setup()
      end, 100)
    end,
  },
  {
    "zbirenbaum/copilot-cmp",
    after = { 'copilot.lua', 'nvim-cmp' },
  },

  -- function signature for lsp
  {
    "ray-x/lsp_signature.nvim",
    config = function()
      require("lsp_signature").on_attach()
    end,
    event = "BufRead"
  },
  {
    "ray-x/guihua.lua",
    command = "cd lua/fzy && make"
  },
  {
    "ray-x/navigator.lua",
    config = function()
      require 'navigator'.setup({
        debug = false, -- log output, set to true and log path: ~/.cache/nvim/gh.log
        width = 0.75, -- max width ratio (number of cols for the floating window) / (window width)
        height = 0.3, -- max list window height, 0.3 by default
        preview_height = 0.35, -- max height of preview windows
        border = { "╭", "─", "╮", "│", "╯", "─", "╰", "│" }, -- border style, can be one of 'none', 'single', 'double',
        -- 'shadow', or a list of chars which defines the border
        on_attach = function(client, bufnr)
          -- your hook
        end,
        -- put a on_attach of your own here, e.g
        -- function(client, bufnr)
        --   -- the on_attach will be called at end of navigator on_attach
        -- end,
        -- the attach code will apply to all lsp clients

        default_mapping = true, -- set to false if you will remap every key
        keymaps = {
          { key = "gD", func = "declaration()" },
          { key = "M", func = "hover()" },
          { key = "<Leader>la", func = "code_action()" },
          { key = "<Leader>lA", func = "ranger_code_action()" },
          { key = "<Leader>gI", func = "incoming_calls()" },
          { key = "<Leader>gO", func = "outgoing_calls()" },

        }, -- a list of key maps
        -- this kepmap gk will override "gd" mapping function declaration()  in default kepmap
        -- please check mapping.lua for all keymaps
        treesitter_analysis = true, -- treesitter variable context
        transparency = 50, -- 0 ~ 100 blur the main window, 100: fully transparent, 0: opaque,  set to nil or 100 to disable it

        lsp_signature_help = true, -- if you would like to hook ray-x/lsp_signature plugin in navigator
        lsp_installer = true, -- set to true if you would like use the lsp installed by williamboman/nvim-lsp-installer
      })
    end
  },
}

--[[
---------------------------------------------------------------------------------------------------
-- Autocommands (https://neovim.io/doc/user/autocmd.html)
---------------------------------------------------------------------------------------------------
--]]

-- lvim.autocommands.custom_groups = {
--   { "BufWinEnter", "*.lua", "setlocal ts=8 sw=8" },
-- }
