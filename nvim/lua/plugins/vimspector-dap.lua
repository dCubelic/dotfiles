return
{
    -- NVIM debug adapter protocol with support for .vimspector.json
    {
        'DoDoENT/vimspector-dap',
        dependencies = {
            { 'rcarriga/nvim-dap-ui', dependencies = { 'mfussenegger/nvim-dap' } },
            { 'nvim-lua/plenary.nvim' }
        }
    }
}
