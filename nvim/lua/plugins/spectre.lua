return
{
    -- Search and replace
    {
        'windwp/nvim-spectre',
        dependencies = { 'nvim-lua/plenary.nvim' },
        config = function()
            Mapper = require( 'nvim-mapper' )
            Mapper.map( 'n', '<leader>sr', ':Spectre<cr>', {}, 'Spectre', 'spectre_open', '[S]earch and [R]eplace within multiple files' )
        end
    }
}
