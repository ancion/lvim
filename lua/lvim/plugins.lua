local core_plugins = {
  -- Packer can manage itself as an optional plugin
  { "wbthomason/packer.nvim" },
  { "Tastyep/structlog.nvim" },
  { "nvim-lua/popup.nvim" },
  { "nvim-lua/plenary.nvim" },

  -- lsp
  { "neovim/nvim-lspconfig" },
  { "tamago324/nlsp-settings.nvim" },
  --{ "williamboman/nvim-lsp-installer" },

  --
  {
    "jose-elias-alvarez/null-ls.nvim",
  },
  { "antoinemadec/FixCursorHold.nvim" }, -- Needed while issue https://github.com/neovim/neovim/issues/12587 is still open

  -- onedark
  { "williamboman/mason-lspconfig.nvim" },
  {
    "williamboman/mason.nvim",
    config = function()
      require("lvim.core.mason").setup()
    end,
  },
  {
    "folke/tokyonight.nvim",
    config = function()
      require("lvim.core.theme").setup()
    end,
    -- disable = not vim.startswith(lvim.colorscheme, "tokyonight"),
  },

  -- Icons
  {
    "kyazdani42/nvim-web-devicons",
    disable = not lvim.use_icons,
  },

  -- indent-blankline
  {
    "lukas-reineke/indent-blankline.nvim",
    config = function()
      require("lvim.core.indentlines").setup()
    end
  },

  -- outline
  {
    "stevearc/aerial.nvim",
    config = function()
      require("lvim.core.aerial").setup()
    end,
    disable = not lvim.builtin.aerial.active
  },

  -- notifycaiton
  {
    "rcarriga/nvim-notify",
    config = function()
      require("lvim.core.notify").setup()
    end,
    requires = { "nvim-telescope/telescope.nvim" },
    disable = not lvim.builtin.notify.active
        or not lvim.builtin.telescope.active,
  },

  -- Replace And search
  {
    "nvim-pack/nvim-spectre",
    config = function()
      require("lvim.core.spectre").setup()
    end,
    diable = not lvim.builtin.spectre.active
  },

  -- diffview
  {
    "sindrets/diffview.nvim",
    config = function()
      require("lvim.core.diffview").setup()
    end,
    --disable = not lvim.builtin.diffview.active,
  },

  -- Telescope
  {
    "nvim-telescope/telescope.nvim",
    branch = "0.1.x",
    config = function()
      require("lvim.core.telescope").setup()
    end,
    disable = not lvim.builtin.telescope.active,
  },
  {
    "nvim-telescope/telescope-fzf-native.nvim",
    requires = { "nvim-telescope/telescope.nvim" },
    run = "make",
    disable = not lvim.builtin.telescope.active,
  },
  { "nvim-telescope/telescope-ui-select.nvim" },

  -- Install nvim-cmp, and buffer source as a dependency
  {
    "hrsh7th/nvim-cmp",
    config = function()
      if lvim.builtin.cmp then
        require("lvim.core.cmp").setup()
      end
    end,
    requires = {
      "L3MON4D3/LuaSnip",
    },
  },

  { "hrsh7th/cmp-nvim-lsp" },
  { "saadparwaiz1/cmp_luasnip" },
  { "hrsh7th/cmp-cmdline" },
  { "hrsh7th/cmp-buffer" },
  { "f3fora/cmp-spell" },
  { "hrsh7th/cmp-path" },

  -- snippets
  {
    "rafamadriz/friendly-snippets",
    disable = not lvim.builtin.luasnip.sources.friendly_snippets,
  },

  {
    "L3MON4D3/LuaSnip",
    config = function()
      local utils = require "lvim.utils"
      local paths = {}
      if lvim.builtin.luasnip.sources.friendly_snippets then
        paths[#paths + 1] = utils.join_paths(
          get_runtime_dir(),
          "site",
          "pack",
          "packer",
          "start",
          "friendly-snippets"
        )
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
  },

  {
    "folke/lua-dev.nvim",
    module = "lua-dev",
  },

  -- Autopairs
  {
    "windwp/nvim-autopairs",
    -- event = "InsertEnter",
    config = function()
      require("lvim.core.autopairs").setup()
    end,
    disable = not lvim.builtin.autopairs.active,
  },

  -- Treesitter
  {
    "nvim-treesitter/nvim-treesitter",
    -- run = ":TSUpdate",
    config = function()
      require("lvim.core.treesitter").setup()
    end,
  },
  {
    "JoosepAlviste/nvim-ts-context-commentstring",
    event = "BufReadPost",
  },

  -- NvimTree
  {
    "kyazdani42/nvim-tree.lua",
    -- event = "BufWinOpen",
    -- cmd = "NvimTreeToggle",
    config = function()
      require("lvim.core.nvimtree").setup()
    end,
    disable = not lvim.builtin.nvimtree.active,
  },
  -- Lir
  {
    "christianchiarulli/lir.nvim",
    config = function()
      require("lvim.core.lir").setup()
    end,
    disable = not lvim.builtin.lir.active,
  },
  {
    "lewis6991/gitsigns.nvim",
    config = function()
      require("lvim.core.gitsigns").setup()
    end,
    event = "BufRead",
    disable = not lvim.builtin.gitsigns.active,
  },

  -- Whichkey
  {
    "folke/which-key.nvim",
    config = function()
      require("lvim.core.which-key").setup()
    end,
    event = "BufWinEnter",
    disable = not lvim.builtin.which_key.active,
  },

  -- Comments
  {
    "numToStr/Comment.nvim",
    event = "BufRead",
    config = function()
      require("lvim.core.comment").setup()
    end,
    disable = not lvim.builtin.comment.active,
  },

  -- project.nvim
  {
    "ahmedkhalf/project.nvim",
    config = function()
      require("lvim.core.project").setup()
    end,
    disable = not lvim.builtin.project.active,
  },

  -- Status Line and Bufferline
  {
    -- "hoob3rt/lualine.nvim",
    "nvim-lualine/lualine.nvim",
    -- "Lunarvim/lualine.nvim",
    config = function()
      require("lvim.core.lualine").setup()
    end,
    disable = not lvim.builtin.lualine.active,
  },

  -- breadcrumbs
  {
    "SmiteshP/nvim-navic",
    config = function()
      require("lvim.core.breadcrumbs").setup()
    end,
    disable = not lvim.builtin.breadcrumbs.active,
  },

  {
    "akinsho/bufferline.nvim",
    config = function()
      require("lvim.core.bufferline").setup()
    end,
    branch = "main",
    event = "BufWinEnter",
    disable = not lvim.builtin.bufferline.active,
  },

  -- Debugger management
  {
    --"Pocco81/DAPInstall.nvim",
    "ravenxrz/DAPInstall.nvim",
    -- event = "BufWinEnter",
    -- event = "BufRead",
    disable = not lvim.builtin.dap.active,
  },
  {
    "theHamsta/nvim-dap-virtual-text",
    config = function()
      require("nvim-dap-virtual-text").setup({
        enabled = true, -- enable this plugin (the default)
        enabled_commands = true, -- create commands DapVirtualTextEnable, DapVirtualTextDisable, DapVirtualTextToggle, (DapVirtualTextForceRefresh for refreshing when debug adapter did not notify its termination)
        highlight_changed_variables = true, -- highlight changed values with NvimDapVirtualTextChanged, else always NvimDapVirtualText
        highlight_new_as_changed = true, -- highlight new variables in the same way as changed variables (if highlight_changed_variables)
        show_stop_reason = true, -- show stop reason when stopped for exceptions
        commented = false, -- prefix virtual text with comment string
        -- experimental features:
        virt_text_pos = 'eol', -- position of virtual text, see `:h nvim_buf_set_extmark()`
        all_frames = false, -- show virtual text for all stack frames not only current. Only works for debugpy on my machine.
        virt_lines = false, -- show virtual lines instead of virtual text (will flicker!)
        virt_text_win_col = nil -- position the virtual text at a fixed window column (starting from the first text column) ,
        -- e.g. 80 to position at column 80, see `:h nvim_buf_set_extmark()`
      })
    end,
  },
  {
    "rcarriga/nvim-dap-ui",
  },

  -- Debugging
  {
    "mfussenegger/nvim-dap",
    -- "ravenxrz/nvim-dap",
    -- event = "BufWinEnter",
    config = function()
      require("lvim.core.dap").setup()
    end,
    disable = not lvim.builtin.dap.active,
  },

  -- alpha
  {
    "goolord/alpha-nvim",
    config = function()
      require("lvim.core.alpha").setup()
    end,
    disable = not lvim.builtin.alpha.active,
  },

  -- Terminal
  {
    "akinsho/toggleterm.nvim",
    event = "BufWinEnter",
    branch = "main",
    config = function()
      require("lvim.core.terminal").setup()
    end,
    disable = not lvim.builtin.terminal.active,
  },

  -- SchemaStore
  {
    "b0o/schemastore.nvim",
  },

  {
    "RRethy/vim-illuminate",
    config = function()
      require("lvim.core.illuminate").setup()
    end,
    disable = not lvim.builtin.illuminate.active,
  },


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
    disable = lvim.colorscheme ~= "onedarker",
  },
}

local default_snapshot_path = join_paths(get_lvim_base_dir(), "snapshots", "default.json")
local content = vim.fn.readfile(default_snapshot_path)
local default_sha1 = vim.fn.json_decode(content)

local get_default_sha1 = function(spec)
  local short_name, _ = require("packer.util").get_plugin_short_name(spec)
  return default_sha1[short_name] and default_sha1[short_name].commit
end

for _, spec in ipairs(core_plugins) do
  if not vim.env.LVIM_DEV_MODE then
    -- Manually lock the commit hash since Packer's snapshots are unreliable in headless mode
    spec["commit"] = get_default_sha1(spec)
  end
end

return core_plugins
