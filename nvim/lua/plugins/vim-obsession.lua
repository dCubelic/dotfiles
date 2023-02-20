return
{
    -- Supports vim session saving and restoring
    'tpope/vim-obsession',
    event = { 'VimEnter' },
    config = function()
        vim.cmd([[
        set sessionoptions+=globals
        ]])

        Mapper = require( 'nvim-mapper' )
        Mapper.map( 'n', '<C-space><C-S>', vim.cmd.Obsession, {}, 'Obsession', 'obsession', 'Obsession' )
        Mapper.map( 'n', '<C-space><C-L>', [[:source Session.vim<cr>]], {}, 'Obsession', 'source_session_vim', 'Source Session.vim' )
    end
}
