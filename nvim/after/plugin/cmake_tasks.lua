local ProjectConfig = require ( 'tasks.project_config'   )
local cmake_utils   = require ( 'tasks.cmake_kits_utils' )
local tasks         = require ( 'tasks'                  )
local utils         = require ( 'tasks.utils'            )
local vimspector    = require ( 'vimspector-dap'         )

tasks.setup( require( 'myconfig.tasks_setup_params' ) )

local function openCCMake()
    local build_dir = tostring( cmake_utils.getBuildDir() )
    vim.cmd( [[bo sp term://ccmake ]] .. build_dir )
end

Mapper.map( 'n', '<leader>cc', openCCMake                                          , { silent = true }, 'CMake', 'open_ccmake'        , 'Open CCMake'              )
Mapper.map( 'n', '<leader>cC', [[:Task start cmake_kits configure<cr>]]            , { silent = true }, 'CMake', 'cmake_configure'    , 'CMake configure'          )
Mapper.map( 'n', '<leader>cP', [[:Task start cmake_kits reconfigure<cr>]]          , { silent = true }, 'CMake', 'cmake_reconfigure'  , 'CMake reconfigure'        )
Mapper.map( 'n', '<leader>cT', [[:Task start cmake_kits ctest<cr>]]                , { silent = true }, 'CMake', 'cmake_test'         , 'CMake CTest'              )
Mapper.map( 'n', '<leader>cv', [[:Task set_module_param cmake_kits build_type<cr>]], { silent = true }, 'CMake', 'cmake_build_type'   , 'Select build type'        )
Mapper.map( 'n', '<leader>ck', [[:Task set_module_param cmake_kits build_kit<cr>]] , { silent = true }, 'CMake', 'cmake_build_kit'    , 'Select build kit'         )
Mapper.map( 'n', '<leader>cK', [[:Task start cmake_kits clean<cr>]]                , { silent = true }, 'CMake', 'cmake_clean'        , 'CMake clean'              )
Mapper.map( 'n', '<leader>ct', [[:Task set_module_param cmake_kits target<cr>]]    , { silent = true }, 'CMake', 'cmake_target'       , 'Select CMake target'      )
Mapper.map( 'n', '<C-c>'     , [[:Task cancel<cr>]]                                , { silent = true }, 'CMake', 'cmake_cancel_task'  , 'Cancel task'              )
Mapper.map( 'n', '<leader>cr', [[:Task start cmake_kits run<cr>]]                  , { silent = true }, 'CMake', 'cmake_run'          , 'CMake run'                )
Mapper.map( 'n', '<F7>'      , [[:Task start cmake_kits debug<cr>]]                , { silent = true }, 'CMake', 'cmake_debug'        , 'CMake debug'              )
Mapper.map( 'n', '<leader>cb', [[:Task start cmake_kits build<cr>]]                , { silent = true }, 'CMake', 'cmake_build'        , 'CMake build'              )
Mapper.map( 'n', '<leader>cB', [[:Task start cmake_kits build_all<cr>]]            , { silent = true }, 'CMake', 'cmake_build_all'    , 'CMake build all'          )
Mapper.map( 'n', '<leader>cf', [[:Task start cmake_kits build_current_file<cr>]]   , { silent = true }, 'CMake', 'cmake_build_current', 'CMake build current file' )

-- set CMake target's run arguments, sync that with .vimspector.json and run the target
function SetCMakeRunArgumentsAndRun( args )
    local project_config = ProjectConfig:new()
    local argsArray = utils.split_args( args )

    local cmake_kits_config = project_config[ 'cmake_kits' ]
    if not cmake_kits_config.args then
        cmake_kits_config.args = {}
    end
    cmake_kits_config.args.run   = argsArray
    cmake_kits_config.args.debug = argsArray
    project_config:write()

    local target, executable = cmake_utils.getCurrentTargetAndExePath()
    vimspector.updateVimspectorCppConfiguration( target, executable, argsArray )

    vim.cmd( [[Task start cmake_kits run]] )
end
vim.cmd( [[command! -nargs=? CMakeSetParamsAndRun lua SetCMakeRunArgumentsAndRun(<f-args>)]] )
Mapper.map( 'n', '<leader>cR', [[:CMakeSetParamsAndRun]], { silent = true }, 'Vimspector', 'cmake_set_params_and_run', "set CMake target's run arguments, sync that with .vimspector.json and run the target" )

-- update path to the current executable in .vimspector.json
local function updateVimspectorExe()
    local target, executable = cmake_utils.getCurrentTargetAndExePath()

    vimspector.updateVimspectorCppExecutablePath( target, executable )

    vim.notify( 'Update vimspector executable path for target ' .. target .. ' to: ' .. vim.inspect( executable ), vim.log.levels.INFO, { title = 'cmake-tasks' } )
end
Mapper.map( 'n', '<leader>cs', updateVimspectorExe, { silent = true }, 'Vimspector', 'cmake_update_vimspector_exe', 'Update path to the current executable in .vimspector.json' )

-- load arguments for current executable target from .vimspector.json file
local function loadVimspectorArgs()
    local project_config = ProjectConfig:new()

    local target = project_config[ 'cmake_kits' ].target
    if target == nil or target == 'all' then
        vim.notify( "Please select a runnable target!", vim.log.levels.ERROR, { title = 'cmake-tasks' } )
        return
    end

    local args = vimspector.getVimspectorConfigurationArgs( target )
    local cmake_kits_config = project_config[ 'cmake_kits' ]
    if not cmake_kits_config.args then
        cmake_kits_config.args = {}
    end
    cmake_kits_config.args.run   = args
    cmake_kits_config.args.debug = args
    project_config:write()

    vim.notify( 'Arguments for target ' .. target .. ' loaded and set to: ' .. vim.inspect( args ), vim.log.levels.INFO, { title = 'cmake-tasks' } )
end
Mapper.map( 'n', '<leader>cl', loadVimspectorArgs, { silent = true }, 'Vimspector', 'cmake_load_vimspector_args', 'Load arguments for current executable target from .vimspector.json file' )

local getBuildDir = cmake_utils.getBuildDir

-- :CTest command that runs CTests with given parameters
vim.cmd( [[command! -nargs=? CTest Task start cmake_kits ctest <args>]] )
Mapper.map( 'n', '<leader>co', function()
        local buildDir = tostring( getBuildDir() )
        vim.fn.system( "cmake --open " .. buildDir )
    end,
    { silent = true },
    'Vimspector', 'run_ctests_with_params', 'Run CTests with given parameters'
)

-- Open build directory in terminal-within-vim split or new tmux pane
if os.getenv( 'TMUX' ) then
    Mapper.map( 'n', '<leader>db', function()
        local buildDir = tostring( getBuildDir() )
        vim.fn.system( 'tmux split-window -c "' .. buildDir .. '" -l30%' )
    end,
    { silent = true },
    'CMake', 'open_build_dir', 'Open build directory in new tmux pane'
    )
else
    -- Ensure .bashrc, .bash_profile and similar files are processed when launching
    -- vim terminal
    vim.cmd([[
        set shell=bash\ -l
        nnoremap <expr> <leader>db ":new\<CR>:lcd "]] .. tostring( getBuildDir() ) .. [["\<CR>:term ++curwin\<CR><C-W>10_"
    ]])
end

-- run current google test
vim.cmd([[
    function! s:RunCurrentGTest() abort
        let l:test_function_signature = substitute( getline( search("^TEST", 'bWn' ) ), '\C\vTEST(_F)?|[ ()]', '', 'g' )
        let l:test_pattern = substitute( l:test_function_signature, ',', '.', '' )
        execute 'CMakeSetParamsAndRun --gtest_filter=' . l:test_pattern
    endfunction
    command! RunCurrentGTest call s:RunCurrentGTest()

    nnoremap <silent> <leader>cg :RunCurrentGTest<cr>
]])

-- start telescope file search in cmake binary directory
local telescopeBuiltin = require( 'telescope.builtin' )

local function findCMakeFiles()
    local build_dir = tostring( getBuildDir() )
    telescopeBuiltin.find_files( { cwd = build_dir } )
end

Mapper.map( 'n', '<leader>dv', findCMakeFiles, { silent = true }, 'CMake', 'find_cmake_files', 'Find files in CMake binary directory' )
