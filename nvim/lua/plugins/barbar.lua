return
{
    -- Tabbars
    {
        'romgrk/barbar.nvim',
        dependencies = 'nvim-tree/nvim-web-devicons',
        config = function()
            require( "bufferline" ).setup {
                exclude_ft = {'qf'},
            }

            Mapper = require("nvim-mapper")

            Mapper.map( 'n', '{', '<cmd>BufferPrevious<cr>'    , { silent = true }, 'Barbar', 'barbar_previous_tab' , 'Move to previous tab' )
            Mapper.map( 'n', '}', '<cmd>BufferNext<cr>'        , { silent = true }, 'Barbar', 'barbar_next_tab'     , 'Move to next tab'     )
            Mapper.map( 'n', '”', '<cmd>BufferMovePrevious<cr>', { silent = true }, 'Barbar', 'barbar_move_previous', 'Reorder to previous'  )
            Mapper.map( 'n', '’', '<cmd>BufferMoveNext<cr>'    , { silent = true }, 'Barbar', 'barbar_move_next'    , 'Reorder to next'      )

            Mapper.map( 'n', '¡', '<Cmd>BufferGoto 1<CR>', { silent = true }, 'Barbar', 'select_tab_1'   , 'Select tab in position 1' )
            Mapper.map( 'n', '™', '<Cmd>BufferGoto 2<CR>', { silent = true }, 'Barbar', 'select_tab_2'   , 'Select tab in position 2' )
            Mapper.map( 'n', '£', '<Cmd>BufferGoto 3<CR>', { silent = true }, 'Barbar', 'select_tab_3'   , 'Select tab in position 3' )
            Mapper.map( 'n', '¢', '<Cmd>BufferGoto 4<CR>', { silent = true }, 'Barbar', 'select_tab_4'   , 'Select tab in position 4' )
            Mapper.map( 'n', '∞', '<Cmd>BufferGoto 5<CR>', { silent = true }, 'Barbar', 'select_tab_5'   , 'Select tab in position 5' )
            Mapper.map( 'n', '§', '<Cmd>BufferGoto 6<CR>', { silent = true }, 'Barbar', 'select_tab_6'   , 'Select tab in position 6' )
            Mapper.map( 'n', '¶', '<Cmd>BufferGoto 7<CR>', { silent = true }, 'Barbar', 'select_tab_7'   , 'Select tab in position 7' )
            Mapper.map( 'n', '•', '<Cmd>BufferGoto 8<CR>', { silent = true }, 'Barbar', 'select_tab_8'   , 'Select tab in position 8' )
            Mapper.map( 'n', 'ª', '<Cmd>BufferGoto 9<CR>', { silent = true }, 'Barbar', 'select_tab_9'   , 'Select tab in position 9' )
            Mapper.map( 'n', 'º', '<Cmd>BufferLast<CR>'  , { silent = true }, 'Barbar', 'select_tab_last', 'Select last tab'          )

            Mapper.map( 'n', 'π', '<Cmd>BufferPin<cr>'     , { silent = true }, 'Barbar', 'pin_buffer'  , 'Pin / unpin buffer' )
            Mapper.map( 'n', '∑', '<Cmd>BufferClose<cr>'   , { silent = true }, 'Barbar', 'close_buffer', 'Close buffer'       )

            Mapper.map( 'n', '<C-p>', '<Cmd>BufferPick<cr>', { silent = true }, 'Barbar', 'buffer_pick_mode', 'Tab buffer picking mode' )

            Mapper.map( 'n', '<leader>bb', '<Cmd>BufferOrderByBufferNumber<CR>', { silent = true }, 'Barbar', 'buffer_order_by_number'       , 'Order buffers by number'        )
            Mapper.map( 'n', '<leader>bd', '<Cmd>BufferOrderByDirectory<CR>'   , { silent = true }, 'Barbar', 'buffer_order_by_directory'    , 'Order buffers by directory'     )
            Mapper.map( 'n', '<leader>bl', '<Cmd>BufferOrderByLanguage<CR>'    , { silent = true }, 'Barbar', 'buffer_order_by_language'     , 'Order buffers by language'      )
            Mapper.map( 'n', '<leader>bw', '<Cmd>BufferOrderByWindowNumber<CR>', { silent = true }, 'Barbar', 'buffer_order_by_window_number', 'Order buffers by window number' )

        end
    }
}
