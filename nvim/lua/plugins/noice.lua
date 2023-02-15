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
            'rcarriga/nvim-notify',
        }
    },

}
