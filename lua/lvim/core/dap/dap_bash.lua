local dap = require('dap')
local join_paths = require("lvim.utils").join_paths
local mason_path = join_paths(vim.fn.stdpath("data"), "mason", "packages")
dap.adapters.bashdb = {
    type = 'executable',
    command = "bash-debug-adapter",
    name = 'bashdb',
}
dap.configurations.sh = {
    {
        type = 'bashdb',
        request = 'launch',
        name = "Launch file",
        showDebugOutput = true,
        pathBashdb = mason_path .. '/bash-debug-adapter/extension/bashdb_dir/bashdb',
        pathBashdbLib = mason_path .. '/bash-debug-adapter/extension/bashdb_dir',
        trace = true,
        file = "${file}",
        program = "${file}",
        cwd = '${workspaceFolder}',
        pathCat = "cat",
        pathBash = "/bin/bash",
        pathMkfifo = "mkfifo",
        pathPkill = "pkill",
        args = {},
        env = {},
        terminalKind = "integrated",
    }
}
