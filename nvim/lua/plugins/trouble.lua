return
{
    -- List problems in code
    {
        "folke/trouble.nvim",
        dependencies = "nvim-tree/nvim-web-devicons",
        keys = { '<leader>x' },
        config = function()
            require("trouble").setup {}

            Mapper = require("nvim-mapper")
            Mapper.map( 'n', '<leader>x', '<cmd>TroubleToggle<cr>', { silent = true }, 'Trouble', 'trouble_toggle', 'Toggle Trouble' )
        end
    }
}
