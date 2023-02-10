require( 'nvim-tree' ).setup({
    update_cwd          = false,
    update_focused_file = {
        enable      = true,
        update_cwd  = false,
        ignore_list = {}
    },
})

vim.keymap.set( "n", "<leader>n", vim.cmd.NvimTreeToggle )
vim.keymap.set( "n", "<leader>N", vim.cmd.NvimTreeFindFile )
