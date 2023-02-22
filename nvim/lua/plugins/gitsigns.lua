return
{
    'lewis6991/gitsigns.nvim',
    event = { 'BufReadPre', 'BufNewFile' },
    opts = {
        current_line_blame = true,
    },
    config = function( _, opts )
        require( 'gitsigns' ).setup( opts )
        require( 'scrollbar.handlers.gitsigns' ).setup()
    end
}
