local params = {
    default_params = { -- Default module parameters with which `.tasks.json` will be created.
        cmake_kits = {
            cmd = 'cmake', -- CMake executable to use, can be changed using `:Task set_module_param cmake cmd`.
            build_type = 'release', -- default build type, can be changed using `:Task set_module_param cmake build_type`.
            build_kit = 'clang',  -- default build kit, can be changed using `:Task set_module_param cmake build_kit`.
            dap_name = 'codelldb', -- DAP configuration name from `require('dap').configurations`. If there is no such configuration, a new one with this name as `type` will be created.
            build_dir = '/Users/nb-dcubelic/Work/Microblink/Builds/{project_name}/{build_kit}/{build_type}',
            cmake_kits_file = vim.api.nvim_get_runtime_file( 'cmake_kits.json', false )[ 1 ], -- set path to JSON file containing cmake kits
            cmake_build_types_file = vim.api.nvim_get_runtime_file( 'cmake_build_types.json', false )[ 1 ], -- set path to JSON file containing cmake kits
            clangd_cmdline = { 'clangd', '--background-index', '--clang-tidy', '--header-insertion=never', '--completion-style=detailed', '--offset-encoding=utf-8', '--pch-storage=memory', '--cross-file-rename', '-j=4' }, -- command line for invoking clangd - this array will be extended with --compile-commands-dir and --query-driver after each cmake configure with parameters inferred from build_kit, build_type and build_dir
        },
        cargo = {
            dap_name = 'codelldb',
        },
        npm = {
            working_directory = vim.loop.cwd()
        }
    },
    save_before_run = true, -- If true, all files will be saved before executing a task.
    params_file = '.tasks.json', -- JSON file to store module and task parameters.
    quickfix = {
        pos = 'botright', -- Default quickfix position.
        height = 12, -- Default height.
    },
    dap_open_command = function() return require( 'dapui' ).open() end, -- Command to run after starting DAP session. You can set it to `false` if you don't want to open anything or `require('dapui').open` if you are using https://github.com/rcarriga/nvim-dap-ui
}

return params
