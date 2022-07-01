local M = {}

-- https://github.com/nvim-pack/nvim-spectre
-- NOTE: spectre 手动安装依赖项 sed 和 ripgrep
-- sed 命令（自行安装，如果已有则忽略）
-- ripgrep： https://github.com/BurntSushi/ripgrep

M.config = function()
  lvim.builtin.spectre = {
    active = true,
    on_config_done = nil,
    opt = {
      mapping = {
        -- delete selecte contents
        ['toggle_line'] = {
          map  = "dd",
          cmd  = "<cmd> lua require('spectre').toggle_line()<CR>",
          desc = "toggle current item",
        },
        -- go to file
        ['enter_file'] = {
          map  = "o",
          cmd  = "<cmd>lua require('spectre.actions').select_entry()<CR>",
          desc = "go to current file",
        },
        -- show_option_menu,(igonore case, ignore dotfile)
        ['show_option_menu'] = {
          map  = "<leader>o",
          cmd  = "<cmd>lua require('spectre').show_options()<CR>",
          desc = "show option"
        },
        -- replace word
        ['run_replace'] = {
          map  = "<leader>R",
          cmd  = "<cmd>lua require('spectre.action').run_replace()<CR>",
          desc = "replace all"
        },
        -- show diff
        ['change_view_mode'] = {
          map  = "<leader>v",
          cmd  = "<cmd>lua require('spectre').change_view()<CR>",
          desc = "change result view mode"
        }
      }
    }
  }
end

M.setup = function()
  local ok, spectre = pcall(require, "spectre")
  if not ok then
    vim.notify_once("spectre not found")
    return
  end
  spectre.setup(lvim.builtin.spectre.opt)

  if lvim.builtin.spectre.on_config_done then
    lvim.builtin.spectre.on_config_done(spectre)
  end
end

return M
