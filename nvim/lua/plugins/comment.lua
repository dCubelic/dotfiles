return
{
    -- Comment/uncomment support for various languages
    {
        'numToStr/Comment.nvim',
        lazy = true,
        keys = { { '<leader>;' } },
        config = function()
            require( 'Comment' ).setup({
                toggler = {
                    line = '<leader>;'
                },
                opleader = {
                    line = '<leader>;'
                }
            })
        end
    }
}
