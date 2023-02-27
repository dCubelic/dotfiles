return
{
    -- UI for notifications, command line, search, ...
    {
        'folke/noice.nvim',
        config = function()
            require('noice').setup({})
            vim.notify = require('notify')
        end,
        dependencies = {
            'MunifTanjim/nui.nvim',
            {
                'rcarriga/nvim-notify',
                config = function()
                    require( 'notify' ).setup({
                        stages = "static",
                        -- max_width = 40,
                        timeout = 3000,
                        render = "minimal"
                    })
                end
            }
        }
    }
}
