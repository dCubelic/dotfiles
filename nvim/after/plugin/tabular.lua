Mapper.map( 'x', '<leader>a', [[:Tabularize /]], {}, 'Tabular', 'tabularize', 'Vertical alignment' )

vim.cmd([[
    augroup tabularizeautocommands
        au!

        " Vertical alignment (Tabularize)
        autocmd VimEnter * ++once :AddTabularPattern! first_comma  /^[^,]*\zs,/l0r1
    augroup END
]])
