return
{
    -- Status line written in lua
    {
        'nvim-lualine/lualine.nvim',
        dependencies = {  'nvim-tree/nvim-web-devicons' },
        config = function()
            local Path = require( 'plenary.path' )
            local lualine = require( 'lualine' )
            local ProjectConfig = require( 'tasks.project_config' )

            local function cmakeStatus()
                local cmake_config = ProjectConfig:new()[ 'cmake_kits' ]
                local cmakelists_dir = cmake_config.source_dir and cmake_config.source_dir or vim.loop.cwd()
                if ( Path:new( cmakelists_dir ) / 'CMakeLists.txt' ):exists() then
                    local cmakeBuildType = cmake_config.build_type
                    local cmakeKit = cmake_config.build_kit
                    local cmakeTarget = cmake_config.target and cmake_config.target or 'all'

                    if cmakeBuildType and cmakeKit and cmakeTarget then
                        return 'CMake variant: ' .. cmakeBuildType .. ' kit: ' .. cmakeKit .. ' target: ' .. cmakeTarget
                    else
                        return ''
                    end
                else
                    return ''
                end
            end

            lualine.setup({
                options = {
                    theme = 'tokyonight'
                },
                sections = {
                    lualine_c = { { 'filename', path = 1 } },
                    lualine_x = { 'encoding', 'fileformat', 'filetype', cmakeStatus }
                }
            })
        end
    },
}
