local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
if not vim.loop.fs_stat(lazypath) then
  vim.fn.system({
    "git",
    "clone",
    "--filter=blob:none",
    "https://github.com/folke/lazy.nvim.git",
    "--branch=stable", -- latest stable release
    lazypath,
  })
end
vim.opt.rtp:prepend(lazypath)

vim.g.mapleader = " " -- define space as <leader>

return require( 'lazy' ).setup(
    {
        {
            'nvim-telescope/telescope.nvim',
            dependencies = {
                { "nvim-telescope/telescope-live-grep-args.nvim" },
                { 'nvim-lua/plenary.nvim' }
            }
        },

        -- Native FZF extension, much faster than the default
        {
            'nvim-telescope/telescope-fzf-native.nvim',
            build = 'cmake -GNinja -S. -Bbuild -DCMAKE_BUILD_TYPE=Release && cmake --build build --config Release && cmake --install build --prefix build'
        },

        -- Transform every vim.ui.select popup with fuzzy-find selection list
        {'nvim-telescope/telescope-ui-select.nvim' },

        -- Sublime-like monokai theme for vim
        'DoDoENT/vim-monokai',

        -- Color theme
        { "catppuccin/nvim", as = "catppuccin" },

        -- Very quick highlighter, much faster than vim's builtin regex-based
        { 'nvim-treesitter/nvim-treesitter', build = ':TSUpdate' },

        -- Git integration for Vim
        'tpope/vim-fugitive',
        -- Make fugitive work with GitHub
        'tpope/vim-rhubarb',
        -- Make fugitive work with BitBucket
        'tommcdo/vim-fubitive',

        -- File manager for neovim
        {
            'nvim-tree/nvim-tree.lua',
            dependencies = {
                'nvim-tree/nvim-web-devicons', -- optional, for file icons
            },
        },

        -- Language Server Protocol helpers
        {
            'VonHeikemen/lsp-zero.nvim',
            dependencies = {
                -- LSP Support
                { 'neovim/nvim-lspconfig' },
                { 'williamboman/mason.nvim' },
                { 'williamboman/mason-lspconfig.nvim' },

                -- Autocompletion
                { 'hrsh7th/nvim-cmp' },
                { 'hrsh7th/cmp-buffer' },
                { 'hrsh7th/cmp-path' },
                { 'saadparwaiz1/cmp_luasnip' },
                { 'hrsh7th/cmp-nvim-lsp' },
                { 'hrsh7th/cmp-nvim-lua' },

                -- Snippets
                { 'L3MON4D3/LuaSnip' },
                { 'rafamadriz/friendly-snippets' },
            }
        },

        -- Supports vim session saving and restoring
        'tpope/vim-obsession',

        -- Syntax highlight for jenkinsfiles
        'martinda/Jenkinsfile-vim-syntax',

        -- Comment/uncomment support for various languages
        'numToStr/Comment.nvim',

        -- Simple shortcut for toggling visibility of quicklist and location buffers
        'Valloric/ListToggle',

        -- Various configurable async stateful tasks (CMake, Cargo, and NPM support implemented using this)
        {
            'DoDoENT/neovim-additional-tasks',
            dependencies = {
                { 'Shatur/neovim-tasks', dependencies = { 'nvim-lua/plenary.nvim' } },
                'neovim/nvim-lspconfig',
            }
        },

        -- Bridge between nvim-dap and mason (LSP and DAP installer, used as LSP-zero dependency above)
        'jayp0521/mason-nvim-dap.nvim',

        -- NVIM debug adapter protocol with support for .vimspector.json
        {
            'DoDoENT/vimspector-dap',
            dependencies = {
                { "rcarriga/nvim-dap-ui", dependencies = { "mfussenegger/nvim-dap" } },
                { 'nvim-lua/plenary.nvim' }
            }
        },

        -- Provides support for vertical alignment of text in table-like manner
        'godlygeek/tabular',

        -- Seamless navigation between vim splits and tmux panes
        'christoomey/vim-tmux-navigator',

        -- Plugin for simple deletion of hidden buffers
        'arithran/vim-delete-hidden-buffers',

        -- Hex editor
        'fidian/hexmode',

        -- Displays indentation levels
        'lukas-reineke/indent-blankline.nvim',

        -- Status line written in lua
        {
            'nvim-lualine/lualine.nvim',
            dependencies = {  'nvim-tree/nvim-web-devicons', opt = true }
        },

        -- Quick navigation within line
        'unblevable/quick-scope',

        -- Auto close brackets
        'jiangmiao/auto-pairs',

        -- LSP renaming
        'smjonas/inc-rename.nvim',
    }
)
