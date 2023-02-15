return {
    {
        'folke/tokyonight.nvim',
        lazy = false,
        priority = 1000,
        config = function()
            require( 'tokyonight' ).setup({
                style = 'night'
            })
            vim.cmd([[colorscheme tokyonight-night]])
        end
    },

    {
        'catppuccin/nvim',
        lazy = true,
        -- priority = 1000,
        config = function()
            require('catppuccin').setup({
                flavour = 'macchiato'
            })
            vim.cmd([[colorscheme catppuccin]])
        end
    },

    {
        'DoDoENT/vim-monokai',
        lazy = true,
        config = function()
            require('monokai').setup({})
            vim.cmd([[colorscheme monokai]])
        end
    },
}
