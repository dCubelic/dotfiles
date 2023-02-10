vim.keymap.set( "x", "<leader>a", [[:Tabularize /]] )
vim.cmd([[
    augroup tabularizeautocommands
        au!

        " Vertical alignment (Tabularize)
        autocmd VimEnter * ++once :AddTabularPattern! first_comma  /^[^,]*\zs,/l0r1
    augroup END
]])
