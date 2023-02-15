return
{
    -- Various configurable async stateful tasks (CMake, Cargo, and NPM support implemented using this)
    {
        'DoDoENT/neovim-additional-tasks',
        dependencies = {
            { 'Shatur/neovim-tasks', dependencies = { 'nvim-lua/plenary.nvim' } },
            'neovim/nvim-lspconfig',
        }
    }
}
