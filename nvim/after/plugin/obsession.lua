-----------------------------------------------------
-- Session configuration
-----------------------------------------------------
vim.cmd([[
    set sessionoptions+=globals
]])

Mapper.map( 'n', '<C-space><C-S>', vim.cmd.Obsession, {}, 'Obsession', 'obsession', 'Obsession' )
Mapper.map( 'n', '<C-space><C-L>', [[:source Session.vim<cr>]], {}, 'Obsession', 'source_session_vim', 'Source Session.vim' )
