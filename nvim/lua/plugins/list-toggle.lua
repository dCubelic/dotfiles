return
{
    -- Simple shortcut for toggling visibility of quicklist and location buffers
    {
        'Valloric/ListToggle',
        keys = { { '<leader>l' }, { '<leader>q' } },
        config = function()
            vim.g.lt_location_list_toggle_map = '<leader>l'
            vim.g.lt_quickfix_list_toggle_map = '<leader>q'
            vim.g.lt_height = 15
        end
    }
}
