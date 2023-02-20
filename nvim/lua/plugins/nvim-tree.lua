return
{
    -- File manager for neovim
    {
        'nvim-tree/nvim-tree.lua',
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

            local mapper = require( 'nvim-mapper' )

            mapper.map( 'n', '<leader>n', vim.cmd.NvimTreeToggle  , {}, 'NvimTree', 'nvim_tree_toggle', 'Toggle NvimTree'            )
            mapper.map( 'n', '<leader>N', vim.cmd.NvimTreeFindFile, {}, 'NvimTree', 'nvim_find_file'  , 'NvimTree find current file' )
        end
    }
}
