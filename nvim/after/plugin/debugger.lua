require( 'mason' ).setup()

local mason_dap = require( 'mason-nvim-dap' )

mason_dap.setup({
    ensure_installed = { 'python', 'codelldb' },
    automatic_installation = true,
    automatic_setup = true
})


local setupDap = require( 'mason-nvim-dap.automatic_setup' )

-- for some reason, automatic installation does not work without this
mason_dap.setup_handlers {
    codelldb = setupDap,
    python = setupDap,
}

local dap, dapui = require( 'dap' ), require( 'dapui' )

dapui.setup()

local function disconnectAndClose()
    dap.disconnect()
    dapui.close()
end

-- mappings
Mapper.map( 'n', '<F8>'        , dap.continue         , { silent = true }, 'Debugger', 'debugger_continue'            , 'Debugger continue'             )
Mapper.map( 'n', '<F10>'       , dap.step_over        , { silent = true }, 'Debugger', 'debugger_step_over'           , 'Debugger step over'            )
Mapper.map( 'n', '<F11>'       , dap.step_into        , { silent = true }, 'Debugger', 'debugger_step_into'           , 'Debugger step into'            )
Mapper.map( 'n', '<F12>'       , dap.step_out         , { silent = true }, 'Debugger', 'debugger_step_out'            , 'Debugger step out'             )
Mapper.map( 'n', '<F9>'        , dap.toggle_breakpoint, { silent = true }, 'Debugger', 'debugger_toggle_breakpoint'   , 'Tggle breakpoint'              )
Mapper.map( 'n', '<leader>ve'  , disconnectAndClose   , { silent = true }, 'Debugger', 'debugger_disconnect_and_close', 'Debugger disconnect and close' )
Mapper.map( 'n', '<leader>vb'  , dap.list_breakpoints , { silent = true }, 'Debugger', 'debugger_list_breakpoints'    , 'List breakpoints'              )
Mapper.map( 'n', '<leader>vr'  , dap.restart          , { silent = true }, 'Debugger', 'debugger_restart'             , 'Debugger restart'              )
Mapper.map( 'n', '<F1>'        , dap.up               , { silent = true }, 'Debugger', 'debugger_stack_up'            , 'Debugger stack up'             )
Mapper.map( 'n', '<F2>'        , dap.down             , { silent = true }, 'Debugger', 'debugger_stack_down'          , 'Debugger stack down'           )
Mapper.map( 'n', '<leader><F8>', dap.run_to_cursor    , { silent = true }, 'Debugger', 'debugger_run_to_cursor'       , 'Debugger run to cursor'        )

Mapper.map( 'n', '<leader><F9>', function() dap.set_breakpoint(          vim.fn.input('Breakpoint condition: ')) end, { silent = true }, 'Debugger', 'debugger_breakpoint_cond', 'Debugger breakpoint condition' )
Mapper.map( 'n', '<leader><F6>', function() dap.set_breakpoint(nil, nil, vim.fn.input('Log point message: '   )) end, { silent = true }, 'Debugger', 'debugger_breakpoint_log' , 'Debugger breakpoint log' )

vim.fn.sign_define( 'DapBreakpoint', { text = '🛑', texthl = '', linehl = '', numhl = '' } )

local function eval()
    dapui.eval( nil, { enter = true } )
end

Mapper.map( 'n', '<leader>vi', eval, { silent = true }, 'Debugger', 'debugger_eval', 'Debugger eval' )

-- integration with CMake and vimspector's config file
local vimspectorDap = require( 'vimspector-dap' )
local Path = require('plenary.path')
local ProjectConfig = require( 'tasks.project_config' )

local function startDebugging()
    local cmake_config = ProjectConfig:new()[ 'cmake_kits' ]
    local cmakelists_dir = cmake_config.source_dir and cmake_config.source_dir or vim.loop.cwd()
    if ( Path:new( cmakelists_dir ) / 'CMakeLists.txt' ):exists() then
        local cmakeTarget = cmake_config.target
        if cmakeTarget and cmakeTarget ~= 'all' then
            vimspectorDap.runSelectedVimspectorConfigOnDap( cmakeTarget )
        else
            vimspectorDap.runVimspectorConfigOnDap()
        end
    else
        vimspectorDap.runVimspectorConfigOnDap()
    end

end
Mapper.map( 'n', '<F5>', startDebugging, { silent = true }, 'Debugger', 'start_debugging', 'Debugger start' )
Mapper.map( 'n', '<leader><F5>', vimspectorDap.runVimspectorConfigOnDap, { silent = true }, 'Debugger', 'run_vimspector_config_on_dap', 'Run vimspector config on DAP' )
