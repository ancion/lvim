local dap = require('dap')
dap.adapters.python = {
    type = 'executable',
    command = "debugpy-adapter",
}
dap.configurations.python = {
    {
        type = 'python',
        request = 'launch',
        name = "Launch file",
        program = "${file}",
        pythonPath = function()
          return '/usr/bin/python3'
        end,
    },
}
