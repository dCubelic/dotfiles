return
{
    {
        'nvim-telescope/telescope.nvim',
        dependencies = {
            { 'nvim-telescope/telescope-live-grep-args.nvim' },
            { 'nvim-lua/plenary.nvim' }
        },
        lazy = true,
        keys = {
            { '<leader>F' }, { '<leader>f' }, { '<leader>b' }, { '<leader>/' }, { '<leader>so' }, { '<C-f>' },
        },
        config = function()
            local builtin = require( 'telescope.builtin' )

            Mapper.map( 'n', '<leader>F', builtin.git_files , {}, 'Telescope', 'telescope_search_git'  , 'Search git files' )
            Mapper.map( 'n', '<leader>f', builtin.find_files, {}, 'Telescope', 'telescope_search_files', 'Search files'     )
            Mapper.map( 'n', '<leader>b', builtin.buffers   , {}, 'Telescope', 'telescope_buffers'     , 'Search buffers'   )

            -- See `:help telescope.builtin`
            Mapper.map( 'n', '<leader>so', builtin.oldfiles, {}, 'Telescope', 'telescope_open_files', 'Search open files' )
            Mapper.map( 'n', '<leader>/', function()
                builtin.current_buffer_fuzzy_find( require('telescope.themes').get_dropdown {
                    winblend = 10,
                    previewer = false,
                })
            end, {}, 'Telescope', 'telescope_current_buffer', 'Fuzzily search in current buffer' )

            local telescope = require( 'telescope'         )
            local actions   = require( 'telescope.actions' )

            telescope.load_extension( 'fzf'            )
            telescope.load_extension( 'ui-select'      )
            telescope.load_extension( 'live_grep_args' )
            telescope.load_extension( 'mapper'         )

            Mapper.map( 'n', '<C-f>', telescope.extensions.live_grep_args.live_grep_args, {}, 'Telescope', 'telescope_live_grep', 'Live grep with parameters' )

            telescope.setup({
                defaults = {
                    mappings = {
                        n = {
                            ['<C-q>'] = actions.smart_send_to_qflist + actions.open_qflist,
                            ['<C-s>'] = actions.select_all,
                            ['<C-d>'] = actions.drop_all,
                            ['<space>'] = actions.toggle_selection,
                        },
                        i = {
                            ['<C-q>'] = actions.smart_send_to_qflist + actions.open_qflist,
                            ['<C-s>'] = actions.select_all,
                            ['<C-d>'] = actions.drop_all,
                        }
                    }
                }
            })
        end
    },

    -- Native FZF extension, much faster than the default
    {
        'nvim-telescope/telescope-fzf-native.nvim',
        build = 'cmake -GNinja -S. -Bbuild -DCMAKE_BUILD_TYPE=Release && cmake --build build --config Release && cmake --install build --prefix build'
    },

    -- Transform every vim.ui.select popup with fuzzy-find selection list
    { 'nvim-telescope/telescope-ui-select.nvim' },

}
