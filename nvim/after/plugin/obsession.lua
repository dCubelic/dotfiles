-----------------------------------------------------
-- Session configuration
-----------------------------------------------------
vim.cmd([[
    set sessionoptions+=globals
]])

vim.keymap.set( "n", "<C-space><C-S>", vim.cmd.Obsession )
vim.keymap.set( "n", "<C-space><C-L>", [[:source Session.vim<cr>]] )
