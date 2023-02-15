require( 'nvim-tree' ).setup({
    update_cwd          = false,
    update_focused_file = {
        enable      = true,
        update_cwd  = false,
        ignore_list = {}
    },
})

local nvim_tree_events = require('nvim-tree.events')
local bufferline_api = require('bufferline.api')

local function get_tree_size()
    return require'nvim-tree.view'.View.width
end

nvim_tree_events.subscribe('TreeOpen', function()
    bufferline_api.set_offset(get_tree_size())
end)

nvim_tree_events.subscribe('Resize', function()
    bufferline_api.set_offset(get_tree_size())
end)

nvim_tree_events.subscribe('TreeClose', function()
    bufferline_api.set_offset(0)
end)

Mapper.map( 'n', '<leader>n', vim.cmd.NvimTreeToggle, {}, 'NvimTree', 'nvim_tree_toggle', 'Toggle NvimTree' )
Mapper.map( 'n', '<leader>N', vim.cmd.NvimTreeFindFile, {}, 'NvimTree', 'nvim_find_file', 'NvimTree find current file' )
