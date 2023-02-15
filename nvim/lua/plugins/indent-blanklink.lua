return
{
    -- Displays indentation levels
    'lukas-reineke/indent-blankline.nvim',
    config = function()
        vim.opt.list = true
        require( "indent_blankline" ).setup {
            show_current_context       = true,
            show_current_context_start = false,
            use_treesitter_scope       = true,
            use_treesitter             = true,
        }
    end
}
