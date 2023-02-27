
return {
    {
        -- File manager for neovim
        'nvim-neo-tree/neo-tree.nvim',
        dependencies = {
            'nvim-lua/plenary.nvim',
            'MunifTanjim/nui.nvim',
            {
                'nvim-tree/nvim-web-devicons', -- optional, for file icons
                name = 'nvim-tree-web-devicons',
            },
            {
                -- only needed if you want to use the commands with "_with_window_picker" suffix
                's1n7ax/nvim-window-picker',
                config = function()
                    require'window-picker'.setup({
                        autoselect_one = true,
                        include_current = false,
                        filter_rules = {
                            -- filter using buffer options
                            bo = {
                                -- if the file type is one of following, the window will be ignored
                                filetype = { 'neo-tree', "neo-tree-popup", "notify" },

                                -- if the buffer type is one of following, the window will be ignored
                                buftype = { 'terminal', "quickfix" },
                            },
                        },
                        other_win_hl_color = '#e35e4f',
                    })
                end,
            }
        },
        keys = {
            '<leader>n',
            '<leader>N',
        },
        config = function()
            vim.cmd([[ let g:neo_tree_remove_legacy_commands = 1 ]])

            require( 'neo-tree' ).setup({
                window = {
                    mappings = {
                        ['<c-x>'] = 'split_with_window_picker',
                        ['<c-v>'] = 'vsplit_with_window_picker',
                        ['<c-t>'] = 'open_tabnew',
                    }
                },
            })


            local mapper = require( 'nvim-mapper' )

            mapper.map( 'n', '<leader>N', vim.cmd.NeoTreeShowToggle  , {}, 'NeoTree', 'neo_tree_show'  , 'Toggle NeoTree' )
            mapper.map( 'n', '<leader>n', vim.cmd.NeoTreeRevealToggle, {}, 'NeoTree', 'neo_tree_reveal', 'NeoTree reveal' )
        end
    }
}
