local M = {}

M.load_default_options = function()
  local utils = require "lvim.utils"
  local join_paths = utils.join_paths

  local undodir = join_paths(get_cache_dir(), "undo")

  if not utils.is_directory(undodir) then
    vim.fn.mkdir(undodir, "p")
  end

  local default_options = {
    backup = false,                          -- creates a backup file
    clipboard = "unnamedplus",               -- allows neovim to access the system clipboard
    cmdheight = 1,                           -- more space in the neovim command line for displaying messages
    colorcolumn = "99999",                   -- fixes indentline for now
    cursorline = true,                       -- highlight the current line
    completeopt = { "menuone", "noselect" },
    list = true,
    laststatus = 3,            -- set show one statusline whern split window
    conceallevel = 0, -- so that `` is visible in markdown files
    fileencoding = "utf-8", -- the encoding written to a file
    -- foldmethod = "indent",                   -- folding, set to "expr" for treesitter based folding
    foldmethod = "manual", -- folding, set to "expr" for treesitter based folding
    -- foldexpr = "nvim_treesitter#foldexpr()", -- set to "nvim_treesitter#foldexpr()" for treesitter based folding
    foldexpr = "", -- set to "nvim_treesitter#foldexpr()" for treesitter based folding
    foldenable = true,
    foldlevel = 99,
    hidden = true, -- required to keep multiple buffers and open multiple buffers
    hlsearch = true, -- highlight all matches on previous search pattern
    incsearch = true,
    ignorecase = true, -- ignore case in search patterns
    mouse = "a", -- allow the mouse to be used in neovim
    pumheight = 20, -- pop up menu height
    -- opt.titlestring = "%<%F%=%l/%L - nvim" -- what the title of the window will be set to
    expandtab = true, -- convert tabs to spaces
    number = true, -- set numbered lines
    numberwidth = 4, -- set number column width to 2 {default 4}
    ruler = false,
    relativenumber = true,     -- set relative numbered lines
    showcmd = false,
    showmode = false,          -- we don't need to see things like -- INSERT -- anymore
    showtabline = 2,           -- always show tabs
    smartcase = true,          -- smart case
    smartindent = true,        -- make indenting smarter again
    splitbelow = true,         -- force all horizontal splits to go below current window
    splitright = true,         -- force all vertical splits to go to the right of current window
    swapfile = false,          -- creates a swapfile
    shiftwidth = 2,            -- the number of spaces inserted for each indentation
    signcolumn = "yes",        -- always show the sign column, otherwise it would shift the text each time
    scrolloff = 8,             -- minimal number of screen lines to keep above and below the cursor.
    sidescrolloff = 8,         -- minimal number of screen lines to keep left and right of the cursor.
    spell = false,
    spelllang = "en",
    spellfile = join_paths(get_config_dir(), "spell", "en.utf-8.add"),
    shadafile = join_paths(get_cache_dir(), "lvim.shada"),
    termguicolors = true, -- set term gui colors (most terminals support this)
    timeoutlen = 300,     -- time to wait for a mapped sequence to complete (in milliseconds)
    title = true,         -- set the title of window to the value of the titlestring
    -- opt.titlestring = "%<%F%=%l/%L - nvim" -- what the title of the window will be set to
    tabstop = 2,          -- insert 2 spaces for a tab
    undodir = undodir,    -- set an undo directory
    undofile = true,      -- enable persistent undo
    updatetime = 300,     -- faster completion
    writebackup = false,  -- if a file is being edited by another program (or was written to file while editing with another program), it is not allowed to be edited
    wrap = false,         -- display lines as one long line
  }

  ---  SETTINGS  ---
  vim.opt.spelllang:append "cjk" -- disable spellchecking for asian characters (VIM algorithm does not support it)
  vim.opt.shortmess:append "c"   -- don't show redundant messages from ins-completion-menu
  vim.opt.shortmess:append "I"   -- don't show the default intro message
  vim.opt.whichwrap:append "<,>,[,],h,l"

  for k, v in pairs(default_options) do
    vim.opt[k] = v
  end

  vim.filetype.add {
    extension = {
      tex = "tex",
      zir = "zir",
      cr = "crystal",
    },
    pattern = {
      ["[jt]sconfig.*.json"] = "jsonc",
    },
  }

  local default_diagnostic_config = {
    signs = {
      active = true,
      values = {
        { name = "DiagnosticSignError", text = lvim.icons.diagnostics.Error },
        { name = "DiagnosticSignWarn",  text = lvim.icons.diagnostics.Warning },
        { name = "DiagnosticSignHint",  text = lvim.icons.diagnostics.Hint },
        { name = "DiagnosticSignInfo",  text = lvim.icons.diagnostics.Information },
      },
    },
    virtual_text = true,
    update_in_insert = false,
    underline = true,
    severity_sort = true,
    float = {
      focusable = true,
      style = "minimal",
      border = "rounded",
      source = "always",
      header = "",
      prefix = "",
    },
  }

  vim.diagnostic.config(default_diagnostic_config)
end

-- yank_for_wsl

M.yank_for_wsl = function()
  vim.cmd [[
    let s:clip = '/mnt/c/Windows/System32/clip.exe'
    if executable(s:clip)
      augroup WSLYank
        autocmd!
        autocmd TextYankPost * if v:event.operator ==# 'y' | call system(s:clip, @0) | endif
      augroup END
    endif
  ]]
end

M.load_headless_options = function()
  vim.opt.shortmess = ""   -- try to prevent echom from cutting messages off or prompting
  vim.opt.more = false     -- don't pause listing when screen is filled
  vim.opt.cmdheight = 9999 -- helps avoiding |hit-enter| prompts.
  vim.opt.columns = 9999   -- set the widest screen possible
  vim.opt.swapfile = false -- don't use a swap file
end

M.load_defaults = function()
  if #vim.api.nvim_list_uis() == 0 then
    M.load_headless_options()
    return
  end
  -- M.yank_for_wsl()
  M.load_default_options()
end

return M
