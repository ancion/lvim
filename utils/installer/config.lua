----------------------------------------------------------------------------------------------------
-- THESE ARE EXAMPLE CONFIGS FEEL FREE TO CHANGE TO WHATEVER YOU WANT
----------------------------------------------------------------------------------------------------

--[[
----------------------------------------------------------------------------------------------------
-- lvim is the global options object
-- Linters should be filled in as strings with either, a global executable or a path to an executable
----------------------------------------------------------------------------------------------------
--]]

if string.match(vim.loop.os_uname().sysname, "Windows") == "Windows" then
  vim.opt.shell = "pwsh.exe -NoLogo"
  vim.opt.shellcmdflag =
  "-NoLogo -NoProfile -ExecutionPolicy RemoteSigned -Command [Console]::InputEncoding=[Console]::OutputEncoding=[System.Text.Encoding]::UTF8;"
  vim.cmd [[
		let &shellredir = '2>&1 | Out-File -Encoding UTF8 %s; exit $LastExitCode'
		let &shellpipe = '2>&1 | Out-File -Encoding UTF8 %s; exit $LastExitCode'
		set shellquote= shellxquote=
  ]]

  -- Set a compatible clipboard manager
  vim.g.clipboard = {
    copy = {
      ["+"] = "win32yank.exe -i --crlf",
      ["*"] = "win32yank.exe -i --crlf",
    },
    paste = {
      ["+"] = "win32yank.exe -o --lf",
      ["*"] = "win32yank.exe -o --lf",
    },
  }
end

-- [[
---------------------------------------------------------------------------------------------------
-- general
---------------------------------------------------------------------------------------------------
-- ]]
--
lvim.log.level = "warn"
lvim.format_on_save = {
  enabled = true,
  -- pattern = "*.lua",
  timeout = 1000,
}
-- lvim.colorscheme = "onedarker"
-- lvim.colorscheme = "tokyonight"
-- lvim.colorscheme = "dracula"
-- lvim.colorscheme = "NeoSolarized"
-- lvim.colorscheme = "catppuccin"
lvim.colorscheme = "deus"
lvim.transparency = true
lvim.builtin.treesitter.rainbow.enable = true

-- [[
---------------------------------------------------------------------------------------------------
-- keymappings (view all the defaults by pressing <leader>Lk)
---------------------------------------------------------------------------------------------------
--]]
lvim.leader = "space"
lvim.use_icons = true

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
--lvim.builtin.notify.active = true
lvim.builtin.terminal.active = true
lvim.builtin.dap.active = true
lvim.builtin.nvimtree.setup.view.side = "left"

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
vim.list_extend(lvim.lsp.automatic_configuration.skipped_servers, { "clangd" })

-- ---@usage setup a server -- see: https://www.lunarvim.org/languages/#overriding-the-default-configuration
-- -- check the lspconfig documentation for a list of all possible options
local opts = {
  capabilities = {
    offsetEncoding = "utf-8",
  },
}
require("lvim.lsp.manager").setup("clangd", opts)

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
local formatters = require "lvim.lsp.null-ls.formatters"
formatters.setup {
  { command = "isort",     filetypes = { "python" } },
  { command = "stylua",    filetypes = { "lua" } },
  { command = "goimports", filetypes = { "go" } },
  { command = "gofumpt",   filetypes = { "go" } },
  {
    -- each formatter accepts a list of options identical to https://github.com/jose-elias-alvarez/null-ls.nvim/blob/main/doc/BUILTINS.md#Configuration
    command = "prettierd",
    ---@usage arguments to pass to the formatter
    -- these cannot contain whitespaces, options such as `--line-width 80` become either `{'--line-width', '80'}` or `{'--line-width=80'}`
    extra_args = { "--print-with", "100" },
    ---@usage specify which filetypes to enable. By default a providers will attach to all the filetypes it supports.
    filetypes = { "typescript", "typescriptreact" },
  },
}

--[[
---------------------------------------------------------------------------------------------------
-- -- set additional linters
---------------------------------------------------------------------------------------------------
---]]

local linters = require "lvim.lsp.null-ls.linters"
linters.setup {
  { command = "selene", filetypes = { "lua" } },
  { command = "flake8", filetypes = { "python" } },
  {
    -- each linter accepts a list of options identical to https://github.com/jose-elias-alvarez/null-ls.nvim/blob/main/doc/BUILTINS.md#Configuration
    command = "shellcheck",
    ---@usage arguments to pass to the formatter
    -- these cannot contain whitespaces, options such as `--line-width 80` become either `{'--line-width', '80'}` or `{'--line-width=80'}`
    extra_args = { "--severity", "warning" },
  },
  {
    command = "codespell",
    ---@usage specify which filetypes to enable. By default a providers will attach to all the filetypes it supports.
    filetypes = { "javascript", "python" },
  },
}

--[[
---------------------------------------------------------------------------------------------------
-- Additional Plugins
---------------------------------------------------------------------------------------------------
--]]

lvim.plugins = {
  {
    "folke/noice.nvim",
    config = function()
      require("noice").setup {
        messages = {
          enabled = true,
        },
        lsp = {
          override = {
            ["vim.lsp.util.convert_input_to_markdown_lines"] = true,
            ["vim.lsp.util.stylize_markdown"] = true,
            ["com.entry.get_documentation"] = true,
          },
          hover = {
            enabled = false,
          },
          signature = {
            enabled = false,
          },
        },
        presets = {
          bottom_search = false,        -- uses a classic bottom cmdline for search
          command_palette = true,       -- position the cmdline and popupmenu together
          long_message_to_split = true, -- long messages will be sent to a split
          inc_rename = false,           -- enables an input dialog for inc_rename.nvim
          lsp_doc_border = true,        -- add a border to hover docs and signature help
        },
      }
    end,
    dependencies = {
      "MunifTanjim/nui.nvim",
      "rcarriga/nvim-notify",
    },
  },
  {
    "rcarriga/nvim-notify",
    config = function()
      require("notify").setup {
        background_colour = "#000000",
      }
    end,
  },
  {
    "kylechui/nvim-surround",
    version = "*", -- Use for stability; omit to use `main` branch for the latest features
    event = "VeryLazy",
    opts = {},
  },
  -- litee family
  {
    "ldelossa/litee.nvim",
    config = function()
      require("litee.lib").setup {
        panel = {
          orientation = "right",
          panel_size = 50,
        },
      }
    end,
  },
  {
    "ldelossa/litee-calltree.nvim",
    config = function()
      require("litee.calltree").setup {
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
          focus = "f",
        },
      }
    end,
  },
  -- colorscheme
  {
    "Mofiqul/dracula.nvim",
    lazy = false,
  },
  {
    "overcache/NeoSolarized",
    lazy = true,
  },
  {
    "theniceboy/nvim-deus",
    lazy = false,
  },
  {
    "catppuccin/nvim",
    name = "catppuccin",
    lazy = false,
    config = function()
      vim.g.catppuccin_flavour = "mocha"
    end,
  },
  -- colorPanel
  {
    "uga-rosa/ccc.nvim",
    event = { "User AstroFile", "InsertEnter" },
    cmd = { "CccPick", "CccConvert", "CccHighlighterEnable", "CccHighlighterDisable", "CccHighlighterToggle" },
    opts = {
      highlighter = {
        auto_enable = true,
        lsp = true,
      },
    },
    config = function(_, opts) -- #4d4dcb
      require("ccc").setup(opts)
      if opts.highlighter and opts.highlighter.auto_enable then
        vim.cmd.CccHighlighterEnable()
        vim.keymap.set("n", "<M-c>", "<Cmd>CccHighlighterToggle<CR>", { desc = "Toggle colorizer" })
        vim.keymap.set("n", "<M-m>", "<Cmd>CccConvert<CR>", { desc = "Convert color" })
        vim.keymap.set("i", "<M-p>", "<Cmd>CccPick<CR>", { desc = "Pick Color" })
      end
    end,
  },
  {
    "mrjones2014/nvim-ts-rainbow",
    event = "BufRead",
  },
  {
    "vhyrro/luarocks.nvim",
    priority = 1000,
    config = true,
  },
  {
    "nvim-neorg/neorg",
    dependencies = { "luarocks.nvim" },
    version = "*",
    lazy = false,
    config = function()
      require("neorg").setup {
        load = {
          ["core.export"] = {
            config = {
              filetype = "markdown",
              directary = "~/codelib/notes/md/",
            },
          },
          ["core.defaults"] = {},
          ["core.concealer"] = {},
          ["core.dirman"] = {
            config = {
              workspaces = {
                notes = "~/codelib/notes",
              },
              default_workspace = "notes",
            },
          },
        },
      }

      vim.wo.foldlevel = 99
      vim.wo.conceallevel = 2
    end,
  },

  -- todo_comments
  {
    "folke/todo-comments.nvim",
    event = "BufRead",
    lazy = true,
    config = function()
      require("todo-comments").setup {
        keywords = {
          --alt : alise
          FIX = { icon = " ", color = "#DC2626", alt = { "FIXME", "BUG", "FIXIT", "ISSUE", "!" } },
          TODO = { icon = " ", color = "#2563EB" },
          HACK = { icon = " ", color = "#7C3AED" },
          WARN = { icon = " ", color = "#FBBF24", alt = { "WARNING", "XXX" } },
          PERF = { icon = " ", color = "#FC9868", alt = { "OPTIM", "PERFORMANCE", "OPTIMIZE" } },
          NOTE = { icon = " ", color = "#10B981", alt = { "INFO" } },
        },
      }
    end,
  },

  { "github/copilot.vim",   lazy = true },
  {
    "zbirenbaum/copilot.lua",
    lazy = true,
    event = { "VimEnter" },
    config = function()
      vim.defer_fn(function()
        require("copilot").setup()
      end, 100)
    end,
  },
  {
    "zbirenbaum/copilot-cmp",
    lazy = true,
    after = { "copilot.lua", "nvim-cmp" },
  },
  { "nvim-neotest/nvim-nio" },

  -- function signature for lsp
  {
    "ray-x/lsp_signature.nvim",
    event = "BufRead",
    lazy = true,
    config = function()
      require("lsp_signature").on_attach()
    end,
  },
  {
    "ray-x/guihua.lua",
    build = "cd lua/fzy && make",
  },
  {
    "stevearc/dressing.nvim",
    opts = {
      input = { default_prompt = "➤ " },
      select = { backend = { "telescope", "builtin" } },
    },
    event = "VeryLazy",
  },
  {
    "ray-x/navigator.lua",
    config = function()
      require("navigator").setup {
        debug = false, -- log output, set to true and log path: ~/.cache/nvim/gh.log
        width = 0.75, -- max width ratio (number of cols for the floating window) / (window width)
        height = 0.3, -- max list window height, 0.3 by default
        preview_height = 0.35, -- max height of preview windows
        border = { "╭", "─", "╮", "│", "╯", "─", "╰", "│" }, -- border style, can be one of 'none', 'single', 'double',
        -- 'shadow', or a list of chars which defines the border
        on_attach = function(client, bufnr)
          require("illuminate").on_attach(client)
          if client.server_capabilities.documentSymbolProvider then
            require("nvim-navic").attach(client, bufnr)
          end
          -- your hook
        end,
        -- put a on_attach of your own here, e.g
        -- function(client, bufnr)
        --   -- the on_attach will be called at end of navigator on_attach
        -- end,
        -- the attach code will apply to all lsp clients

        ts_fold = {
          enable = false,
          max_lines_scan_comments = 20,                     -- only fold when the fold  level higher than this value
          disable_filetypes = { "help", "guihua", "text" }, -- list of filetypes which doesn't fold using treesitter
        },                                                  -- modified version of treesitter folding

        default_mapping = true,                             -- set to false if you will remap every key
        -- a list of key maps
        -- this kepmap gk will override "gd" mapping function declaration()  in default kepmap
        -- please check mapping.lua for all keymaps
        keymaps = {
          { key = "M",          func = vim.lsp.buf.hover,                           desc = "hover" },
          { key = "<Leader>la", func = require("navigator.codeAction").code_action, desc = "code_action" },
          {
            key = "<Leader>lA",
            func = require("navigator.codeAction").range_code_action,
            desc = "range_code_action",
          },
        },
        treesitter_analysis = true,          -- treesitter variable context
        treesitter_navigation = true,        -- bool false: use lsp to navigator between symbol']r/[r'
        treesitter_analysis_max_num = 100,   -- how many items to run treesitter_analysis
        treesitter_analysis_condense = true, -- condense form form treesitter_analysis
        transparency = 70,                   -- 0 ~ 100 blur the main window, 100: fully transparent, 0: opaque,  set to nil or 100 to disable it
        lsp_signature_help = true,           -- if you would like to hook ray-x/lsp_signature plugin in navigator
        lsp_signature_cfg = nil,
        mason = true,
      }
    end,
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
