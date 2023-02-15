return
{
    {
        -- Provides support for vertical alignment of text in table-like manner
        'godlygeek/tabular',
        keys = { { '<leader>a', mode = 'x'  } },
        config = function()
            local mapper = require( 'nvim-mapper' )

            mapper.map( 'x', '<leader>a', [[:Tabularize /]], {}, 'Tabular', 'tabularize', 'Vertical alignment' )

            vim.cmd([[
            augroup tabularizeautocommands
            au!

            " Vertical alignment (Tabularize)
            autocmd VimEnter * ++once :AddTabularPattern! first_comma  /^[^,]*\zs,/l0r1
            augroup END
            ]])
        end

    }
}
