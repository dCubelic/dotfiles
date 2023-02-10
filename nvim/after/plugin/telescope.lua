local builtin = require( 'telescope.builtin' )

vim.keymap.set( 'n', '<leader>F', builtin.git_files,  { desc = "Search git files" } )
vim.keymap.set( 'n', '<leader>f', builtin.find_files, { desc = "Search files"     } )
vim.keymap.set( 'n', '<leader>b', builtin.buffers,    { desc = "Search buffers"   } )
-- vim.keymap.set( 'n', '<C-f>', builtin.live_grep, { desc = "Live grep" } )
--
-- See `:help telescope.builtin`
vim.keymap.set('n', '<leader>so', builtin.oldfiles, { desc = '[S]earch [O]pen files' })
vim.keymap.set('n', '<leader>sb', builtin.buffers , { desc = '[S]earch [B]uffers'    })
vim.keymap.set('n', '<leader>/', function()
    -- You can pass additional configuration to telescope to change theme, layout, etc.
    builtin.current_buffer_fuzzy_find( require('telescope.themes').get_dropdown {
        winblend = 10,
        previewer = false,
    })
end, { desc = '[/] Fuzzily search in current buffer]' })

vim.keymap.set( 'n', '<leader>sf', builtin.find_files , { desc = '[S]earch [F]iles'        } )
vim.keymap.set( 'n', '<leader>sh', builtin.help_tags  , { desc = '[S]earch [H]elp'         } )
vim.keymap.set( 'n', '<leader>sw', builtin.grep_string, { desc = '[S]earch current [W]ord' } )
-- vim.keymap.set( 'n', '<leader>sg', builtin.live_grep  , { desc = '[S]earch by [G]rep'      } )
vim.keymap.set( 'n', '<leader>sd', builtin.diagnostics, { desc = '[S]earch [D]iagnostics'  } )

vim.keymap.set( 'n', '<leader>ds', builtin.lsp_document_symbols         , { desc = '[D]ocument [S]ymbols'  } )
-- vim.keymap.set( 'n', '<leader>ws', builtin.lsp_dynamic_workspace_symbols, { desc = '[W]orkspace [S]ymbols' } )

local telescope = require( 'telescope' )
local actions   = require( 'telescope.actions' )

telescope.load_extension( 'fzf'            )
telescope.load_extension( 'ui-select'      )
telescope.load_extension( 'live_grep_args' )

vim.keymap.set( 'n', '<C-f>'     , telescope.extensions.live_grep_args.live_grep_args, { desc = "Live grep with parameters" } )
vim.keymap.set( 'n', '<leader>sg', telescope.extensions.live_grep_args.live_grep_args, { desc = '[S]earch by [G]rep'        } )

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


