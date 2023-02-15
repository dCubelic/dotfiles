return
{
    -- File manager for neovim
    {
        'nvim-tree/nvim-tree.lua',
        lazy = true,
        keys = { { '<leader>n' }, { '<leader>N' } },
        dependencies = {
            'nvim-tree/nvim-web-devicons'
        },
        config = function()
            require( 'nvim-tree' ).setup({
                update_cwd          = false,
                update_focused_file = {
                    enable      = true,
                    update_cwd  = false,
                    ignore_list = {}
                },
            })

            local mapper           = require( 'nvim-mapper'     )
            local nvim_tree_events = require( 'nvim-tree.events' )
            local bufferline_api   = require( 'bufferline.api'   )

            local function get_tree_size()
                return require'nvim-tree.view'.View.width
            end

            nvim_tree_events.subscribe('TreeOpen', function()
                bufferline_api.set_offset(get_tree_size())
            end)

            nvim_tree_events.subscribe('Resize', function()
                bufferline_api.set_offset(get_tree_size())
            end)

            nvim_tree_events.subscribe('TreeClose', function()
                bufferline_api.set_offset(0)
            end)

            mapper.map( 'n', '<leader>n', vim.cmd.NvimTreeToggle  , {}, 'NvimTree', 'nvim_tree_toggle', 'Toggle NvimTree'            )
            mapper.map( 'n', '<leader>N', vim.cmd.NvimTreeFindFile, {}, 'NvimTree', 'nvim_find_file'  , 'NvimTree find current file' )
        end
    }
}
