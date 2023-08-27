-- local require = require("lvim.utils.require").require
local core_plugins = {
  { "folke/lazy.nvim",                 tag = "stable" },
  {
    "neovim/nvim-lspconfig",
    lazy = true,
    dependencies = { "mason-lspconfig.nvim", "nlsp-settings.nvim" },
  },
  {
    "williamboman/mason-lspconfig.nvim",
    cmd = { "LspInstall", "LspUninstall" },
    config = function()
      require("mason-lspconfig").setup(lvim.lsp.installer.setup)

      -- automatic_installation is handled by lsp-manager
      local settings = require "mason-lspconfig.settings"
      settings.current.automatic_installation = false
    end,
    lazy = true,
    event = "User FileOpened",
    dependencies = "mason.nvim",
  },
  { "tamago324/nlsp-settings.nvim",    cmd = "LspSettings", lazy = true },
  { "jose-elias-alvarez/null-ls.nvim", lazy = true },
  {
    "williamboman/mason.nvim",
    config = function()
      require("lvim.core.mason").setup()
    end,
    cmd = { "Mason", "MasonInstall", "MasonUninstall", "MasonUninstallAll", "MasonLog" },
    build = function()
      pcall(function()
        require("mason-registry").refresh()
      end)
    end,
    event = "User FileOpened",
    lazy = true,
  },
  {
    "folke/tokyonight.nvim",
    lazy = not vim.startswith(lvim.colorscheme, "tokyonight"),
  },
  {
    "lunarvim/lunar.nvim",
    lazy = lvim.colorscheme ~= "lunar",
  },
  { "Tastyep/structlog.nvim", lazy = true },
  { "nvim-lua/plenary.nvim",  cmd = { "PlenaryBustedFile", "PlenaryBustedDirectory" }, lazy = true },
  -- Telescope
  {
    "nvim-telescope/telescope.nvim",
    branch = "0.1.x",
    config = function()
      require("lvim.core.telescope").setup()
    end,
    dependencies = { "telescope-fzf-native.nvim" },
    lazy = true,
    cmd = "Telescope",
    enabled = lvim.builtin.telescope.active,
  },
  { "nvim-telescope/telescope-ui-select.nvim",  lazy = true },
  { "nvim-telescope/telescope-fzf-native.nvim", build = "make", lazy = true, enabled = lvim.builtin.telescope.active },
  -- Install nvim-cmp, and buffer source as a dependency
  {
    "hrsh7th/nvim-cmp",
    config = function()
      if lvim.builtin.cmp then
        require("lvim.core.cmp").setup()
      end
    end,
    event = { "InsertEnter", "CmdlineEnter" },
    dependencies = {
      "cmp-nvim-lsp",
      "cmp_luasnip",
      "cmp-buffer",
      "cmp-path",
      "cmp-spell",
      "cmp-cmdline",
    },
  },

  { "f3fora/cmp-spell",         lazy = true },
  { "hrsh7th/cmp-nvim-lsp",     lazy = true },
  { "saadparwaiz1/cmp_luasnip", lazy = true },
  { "hrsh7th/cmp-buffer",       lazy = true },
  { "hrsh7th/cmp-path",         lazy = true },
  {
    "hrsh7th/cmp-cmdline",
    lazy = true,
    enabled = lvim.builtin.cmp and lvim.builtin.cmp.cmdline.enable or false,
  },
  {
    "L3MON4D3/LuaSnip",
    config = function()
      local utils = require "lvim.utils"
      local paths = {}
      if lvim.builtin.luasnip.sources.friendly_snippets then
        paths[#paths + 1] = utils.join_paths(get_runtime_dir(), "site", "pack", "lazy", "opt",
          "friendly-snippets")
      end
      local user_snippets = utils.join_paths(get_config_dir(), "snippets")
      if utils.is_directory(user_snippets) then
        paths[#paths + 1] = user_snippets
      end
      require("luasnip.loaders.from_lua").lazy_load()
      require("luasnip.loaders.from_vscode").lazy_load {
        paths = paths,
      }
      require("luasnip.loaders.from_snipmate").lazy_load()
    end,
    event = "InsertEnter",
    dependencies = {
      "friendly-snippets",
    },
  },

  -- snippets
  {
    "rafamadriz/friendly-snippets",
    lazy = true,
    cond = lvim.builtin.luasnip.sources.friendly_snippets
  },
  {
    "folke/neodev.nvim",
    lazy = true,
  },

  -- Autopairs
  {
    "windwp/nvim-autopairs",
    event = "InsertEnter",
    config = function()
      require("lvim.core.autopairs").setup()
    end,
    enabled = lvim.builtin.autopairs.active,
    dependencies = { "nvim-treesitter/nvim-treesitter", "hrsh7th/nvim-cmp" },
  },

  -- Treesitter
  {
    "nvim-treesitter/nvim-treesitter",
    --run = ":TSUpdate",
    config = function()
      local utils = require "lvim.utils"
      local path = utils.join_paths(get_runtime_dir(), "site", "pack", "lazy", "opt", "nvim-treesitter")
      vim.opt.rtp:prepend(path) -- treesitter needs to be before nvim's runtime in rtp
      require("lvim.core.treesitter").setup()
    end,
    cmd = {
      "TSInstall",
      "TSUninstall",
      "TSUpdate",
      "TSUpdateSync",
      "TSInstallInfo",
      "TSInstallSync",
      "TSInstallFromGrammar",
    },
    event = "User FileOpened",
  },
  {
    -- Lazy loaded by Comment.nvim pre_hook
    "JoosepAlviste/nvim-ts-context-commentstring",
    lazy = true,
  },

  -- NvimTree
  {
    "nvim-tree/nvim-tree.lua",
    config = function()
      require("lvim.core.nvimtree").setup()
    end,
    enabled = lvim.builtin.nvimtree.active,
    cmd = { "NvimTreeToggle", "NvimTreeOpen", "NvimTreeFocus", "NvimTreeFindFileToggle" },
    event = "User DirOpened",
  },
  -- Lir
  {
    "tamago324/lir.nvim",
    config = function()
      require("lvim.core.lir").setup()
    end,
    enabled = lvim.builtin.lir.active,
    event = "User DirOpened",
  },
  {
    "lewis6991/gitsigns.nvim",
    config = function()
      require("lvim.core.gitsigns").setup()
    end,
    event = "User FileOpened",
    cmd = "Gitsigns",
    enabled = lvim.builtin.gitsigns.active,
  },

  -- Whichkey
  {
    "folke/which-key.nvim",
    config = function()
      require("lvim.core.which-key").setup()
    end,
    cmd = "WhichKey",
    event = "VeryLazy",
    enabled = lvim.builtin.which_key.active,
  },

  -- Comments
  {
    "numToStr/Comment.nvim",
    config = function()
      require("lvim.core.comment").setup()
    end,
    keys = { { "gc", mode = { "n", "v" } }, { "gb", mode = { "n", "v" } } },
    event = "User FileOpened",
    enabled = lvim.builtin.comment.active,
  },

  -- project.nvim
  {
    "ahmedkhalf/project.nvim",
    config = function()
      require("lvim.core.project").setup()
    end,
    enabled = lvim.builtin.project.active,
    event = "VimEnter",
    cmd = "Telescope projects",
  },

  -- Icons
  {
    "nvim-tree/nvim-web-devicons",
    enabled = lvim.use_icons,
    lazy = true,
  },

  -- Status Line and Bufferline
  {
    -- "hoob3rt/lualine.nvim",
    "nvim-lualine/lualine.nvim",
    -- "Lunarvim/lualine.nvim",
    config = function()
      require("lvim.core.lualine").setup()
    end,
    event = "VimEnter",
    enabled = lvim.builtin.lualine.active,
  },

  -- breadcrumbs
  {
    "SmiteshP/nvim-navic",
    config = function()
      require("lvim.core.breadcrumbs").setup()
    end,
    event = "User FileOpened",
    enabled = lvim.builtin.breadcrumbs.active,
  },

  {
    "akinsho/bufferline.nvim",
    config = function()
      require("lvim.core.bufferline").setup()
    end,
    branch = "main",
    event = "User FileOpened",
    enabled = lvim.builtin.bufferline.active,
  },

  {
    "theHamsta/nvim-dap-virtual-text",
    config = function()
      require("nvim-dap-virtual-text").setup({
        enabled = true, -- enable this plugin (the default)
        -- create commands
        --  > DapVirtualTextEnable,
        --  > DapVirtualTextDisable,
        --  > DapVirtualTextToggle, (DapVirtualTextForceRefresh for refreshing when debug adapter did not notify its termination)
        enabled_commands = true,
        highlight_changed_variables = true, -- highlight changed values with NvimDapVirtualTextChanged, else always NvimDapVirtualText
        highlight_new_as_changed = true,    -- highlight new variables in the same way as changed variables (if highlight_changed_variables)
        show_stop_reason = true,            -- show stop reason when stopped for exceptions
        commented = false,                  -- prefix virtual text with comment string
        only_first_definition = true,       -- only show virtual text at first definition (if there are multiple)
        all_references = false,             -- show virtual text on all all references of the variable (not only definitions)
        --- A callback that determines how a variable is displayed or whether it should be omitted
        --- @param variable Variable https://microsoft.github.io/debug-adapter-protocol/specification#Types_Variable
        --- @param buf number
        --- @param stackframe dap.StackFrame https://microsoft.github.io/debug-adapter-protocol/specification#Types_StackFrame
        --- @param node userdata tree-sitter node identified as variable definition of reference (see `:h tsnode`)
        --- @return string|nil A text how the virtual text should be displayed or nil, if this variable shouldn't be displayed
        display_callback = function(variable, _buf, _stackframe, _node)
          return variable.name .. ' = ' .. variable.value
        end,
        -- experimental features:
        virt_text_pos = 'eol',  -- position of virtual text, see `:h nvim_buf_set_extmark()`
        all_frames = false,     -- show virtual text for all stack frames not only current. Only works for debugpy on my machine.
        virt_lines = false,     -- show virtual lines instead of virtual text (will flicker!)
        virt_text_win_col = nil -- position the virtual text at a fixed window column (starting from the first text column) ,
        -- e.g. 80 to position at column 80, see `:h nvim_buf_set_extmark()`
      })
    end,
  },

  -- Debugging
  {
    "mfussenegger/nvim-dap",
    config = function()
      require("lvim.core.dap").setup()
    end,
    lazy = true,
    dependencies = {
      "rcarriga/nvim-dap-ui",
    },
    enabled = lvim.builtin.dap.active,
  },

  -- Debugger user interface
  {
    "rcarriga/nvim-dap-ui",
    config = function()
      require("lvim.core.dap").setup_ui()
    end,
    lazy = true,
    enabled = lvim.builtin.dap.active,
  },

  -- alpha
  {
    "goolord/alpha-nvim",
    config = function()
      require("lvim.core.alpha").setup()
    end,
    enabled = lvim.builtin.alpha.active,
    event = "VimEnter",
  },

  -- Terminal
  {
    "akinsho/toggleterm.nvim",
    branch = "main",
    init = function()
      require("lvim.core.terminal").init()
    end,
    config = function()
      require("lvim.core.terminal").setup()
    end,
    cmd = {
      "ToggleTerm",
      "TermExec",
      "ToggleTermToggleAll",
      "ToggleTermSendCurrentLine",
      "ToggleTermSendVisualLines",
      "ToggleTermSendVisualSelection",
    },
    keys = lvim.builtin.terminal.open_mapping,
    enabled = lvim.builtin.terminal.active,
  },

  -- SchemaStore
  {
    "b0o/schemastore.nvim",
    lazy = true,
  },

  {
    "RRethy/vim-illuminate",
    config = function()
      require("lvim.core.illuminate").setup()
    end,
    event = "User FileOpened",
    enabled = lvim.builtin.illuminate.active,
  },


  -- indent-blankline
  {
    "lukas-reineke/indent-blankline.nvim",
    config = function()
      require("lvim.core.indentlines").setup()
    end,
    event = "User FileOpened",
    enabled = lvim.builtin.indentlines.active,
  },

  -- onedark
  {
    "lunarvim/onedarker.nvim",
    branch = "freeze",
    config = function()
      pcall(function()
        if lvim and lvim.colorscheme == "onedarker" then
          require("onedarker").setup()
          lvim.builtin.lualine.options.theme = "onedarker"
        end
      end)
    end,
    lazy = lvim.colorscheme ~= "onedarker",
  },

  {
    "lunarvim/bigfile.nvim",
    config = function()
      pcall(function()
        require("bigfile").config(lvim.builtin.bigfile.config)
      end)
    end,
    enabled = lvim.builtin.bigfile.active,
    event = { "FileReadPre", "BufReadPre", "User FileOpened" },
  },

  -- Replace And search
  {
    "nvim-pack/nvim-spectre",
    config = function()
      require("lvim.core.spectre").setup()
    end,
    enabled = lvim.builtin.spectre.active
  },

  -- diffview
  {
    "sindrets/diffview.nvim",
    config = function()
      require("lvim.core.diffview").setup()
    end,
    enabled = lvim.builtin.diffview.active,
  },

  -- outline
  {
    "stevearc/aerial.nvim",
    config = function()
      require("lvim.core.aerial").setup()
    end,
    enabled = lvim.builtin.aerial.active
  },
}

local default_snapshot_path = join_paths(get_lvim_base_dir(), "snapshots", "default.json")
local content = vim.fn.readfile(default_snapshot_path)
local default_sha1 = assert(vim.fn.json_decode(content))

-- taken from <https://github.com/folke/lazy.nvim/blob/c7122d64cdf16766433588486adcee67571de6d0/lua/lazy/core/plugin.lua#L27>
local get_short_name = function(long_name)
  local name = long_name:sub(-4) == ".git" and long_name:sub(1, -5) or long_name
  local slash = name:reverse():find("/", 1, true) --[[@as number?]]
  return slash and name:sub(#name - slash + 2) or long_name:gsub("%W+", "_")
end

local get_default_sha1 = function(spec)
  local short_name = get_short_name(spec[1])
  return default_sha1[short_name] and default_sha1[short_name].commit
end

if not vim.env.LVIM_DEV_MODE then
  --  Manually lock the commit hashes of core plugins
  for _, spec in ipairs(core_plugins) do
    spec["commit"] = get_default_sha1(spec)
  end
end

return core_plugins
