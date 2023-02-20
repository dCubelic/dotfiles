return
{
    -- Comment/uncomment support for various languages
    {
        'numToStr/Comment.nvim',
        event = { 'BufReadPost', 'BufNewFile' },
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
