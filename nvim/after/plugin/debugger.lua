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
vim.keymap.set( "n", "<F8>" , dap.continue , { silent = true } )
vim.keymap.set( "n", "<F10>", dap.step_over, { silent = true } )
vim.keymap.set( "n", "<F11>", dap.step_into, { silent = true } )
vim.keymap.set( "n", "<F12>", dap.step_out , { silent = true } )
vim.keymap.set( "n", "<F9>" , dap.toggle_breakpoint, { silent = true } )
vim.keymap.set( "n", "<Leader><F9>", function() dap.set_breakpoint(vim.fn.input('Breakpoint condition: ')) end, { silent = true } )
vim.keymap.set( "n", "<Leader><F6>", function() dap.set_breakpoint(nil, nil, vim.fn.input('Log point message: ')) end, { silent = true } )
vim.keymap.set( "n", "<Leader>ve", disconnectAndClose, { silent = true } )
vim.keymap.set( "n", "<leader>vb", dap.list_breakpoints, { silent = true } )
vim.keymap.set( "n", "<leader>vr", dap.restart, { silent = true } )
vim.keymap.set( "n", "<F1>", dap.up, { silent = true } )
vim.keymap.set( "n", "<F2>", dap.down, { silent = true } )
vim.keymap.set( "n", "<Leader><F8>", dap.run_to_cursor, { silent = true } )

vim.fn.sign_define( 'DapBreakpoint', { text = '🛑', texthl = '', linehl = '', numhl = '' } )

local function eval()
    dapui.eval( nil, { enter = true } )
end

vim.keymap.set( "n", "<leader>vi", eval, { silent = true } )

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
vim.keymap.set( "n", "<F5>", startDebugging, { silent = true } )
vim.keymap.set( "n", "<leader><F5>", vimspectorDap.runVimspectorConfigOnDap, { silent = true } )
