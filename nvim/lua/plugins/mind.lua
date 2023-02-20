return
{
    'phaazon/mind.nvim',
    branch = 'v2.2',
    dependencies = { 'nvim-lua/plenary.nvim' },
    config = function()
        require( 'mind' ).setup({
            keymaps = {
                normal = {
                    [ "<leader>ms" ] = "open_data_index"
                }
            }
        })
        Mapper = require( 'nvim-mapper' )

        Mapper.map( 'n', '<leader>ml', '<cmd>MindOpenProject<cr>', {}, 'Mind', 'mind_open_local' , 'Open project mind.' )
        Mapper.map( 'n', '<leader>mg', '<cmd>MindOpenMain<cr>'   , {}, 'Mind', 'mind_open_global', 'Open global mind.'  )

    end
}
