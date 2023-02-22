return
{
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
            {
                'L3MON4D3/LuaSnip',
                config = function()
                    require( "luasnip.loaders.from_snipmate" ).load()
                end
            },
            { 'rafamadriz/friendly-snippets' },
        },
        config = function()

            local lsp = require( 'lsp-zero' )
            lsp.preset( 'recommended' )

            lsp.ensure_installed({
                'clangd',
                'tsserver',
                'eslint',
                'lua_ls',
                'rust_analyzer',
                'pylsp',
                'groovyls',
            })

            -- Fix Undefined global 'vim'
            lsp.configure( 'lua_ls', {
                settings = {
                    Lua = {
                        diagnostics = {
                            globals = { 'vim' }
                        },
                        workspace = {
                            -- Make the server aware of Neovim runtime files
                            library = vim.api.nvim_get_runtime_file( "", true ),
                            checkThirdParty = false,
                        },
                    }
                }
            })

            lsp.configure( 'clangd', {
                cmd = require( 'tasks.cmake_kits_utils' ).currentClangdArgs(),
                capabilities = {
                    offsetEncoding = { 'utf-8' },
                },
            })

            lsp.configure( 'pylsp', {
                settings = {
                    pylsp = {
                        plugins = {
                            pycodestyle = {
                                maxLineLength = 120
                            }
                        }
                    }
                }
            })

            lsp.set_preferences({
                set_lsp_keymaps = false,
            })

            local cmp = require('cmp')
            local luasnip = require('luasnip')
            local cmp_mappings = lsp.defaults.cmp_mappings({
                [ "<C-j>" ] = cmp.mapping.confirm( { select = true } ),
                [ "<C-Space>" ] = cmp.mapping.complete(),
                [ "<esc>" ] = nil,
                [ "<Tab>" ] = cmp.mapping( function( fallback )
                    if cmp.visible() then
                        cmp.select_next_item()
                    elseif luasnip.expand_or_jumpable() then
                        luasnip.expand_or_jump()
                    else
                        fallback()
                    end
                end, { 'i', 's' }),
                [ "<S-Tab>" ] = cmp.mapping( function( fallback )
                    if cmp.visible() then
                        cmp.select_prev_item()
                    elseif luasnip.jumpable( -1 ) then
                        luasnip.jump( -1 )
                    else
                        fallback()
                    end
                end, { 'i', 's' }),
            })



            lsp.setup_nvim_cmp({
                mapping = cmp_mappings,
                completion = {
                    completeopt = 'preview,menuone,noselect'
                }
            })

            -- NOTE: sometimes not called
            -- lsp.on_attach( function( client, bufnr )
                -- local opts = { buffer = bufnr, remap = false }
                local opts = {}

                Mapper = require( 'nvim-mapper' )
                Mapper.map( 'n', '\\'         , vim.lsp.buf.definition      , opts, 'LSP', 'lsp_definitions'     , 'Goto definition'      )
                Mapper.map( 'n', 'K'          , vim.lsp.buf.hover           , opts, 'LSP', 'lsp_hover'           , 'LSP help'             )
                Mapper.map( 'n', '<leader>D'  , vim.lsp.buf.type_definition , opts, 'LSP', 'lsp_type_definition' , 'LSP type definitinos' )
                Mapper.map( 'n', '<leader>vws', vim.lsp.buf.workspace_symbol, opts, 'LSP', 'lsp_workspace_symbol', 'LSP workspace symbol' )
                Mapper.map( 'n', '<leader>e'  , vim.diagnostic.open_float   , opts, 'LSP', 'lsp_diagnostic'      , 'Show LSP diadnostic'  )
                Mapper.map( 'n', '[d'         , vim.diagnostic.goto_prev    , opts, 'LSP', 'lsp_goto_prev'       , 'LSP goto previous'    )
                Mapper.map( 'n', ']d'         , vim.diagnostic.goto_next    , opts, 'LSP', 'lsp_goto_next'       , 'LSP goto next'        )
                Mapper.map( 'n', '<leader>yF' , vim.lsp.buf.code_action     , opts, 'LSP', 'lsp_code_action'     , 'LSP code action'      )
                Mapper.map( 'n', '<leader>yf' , vim.lsp.buf.references      , opts, 'LSP', 'lsp_references'      , 'LSP references'       )
                Mapper.map( 'n', '<leader>yr' , vim.lsp.buf.rename          , opts, 'LSP', 'lsp_rename'          , 'LSP rename'           )
                Mapper.map( 'n', '<leader>='  , vim.lsp.buf.format          , opts, 'LSP', 'lsp_format'          , 'LSP format'           )
                Mapper.map( 'v', '<leader>='  , vim.lsp.buf.format          , opts, 'LSP', 'lsp_format_visual'   , 'LSP format'           )

                -- if client.name == 'clangd' then
                Mapper.map( 'n', '<leader>o', [[:ClangdSwitchSourceHeader<cr>]], opts, 'LSP', 'lsp_switch_source_header', 'Switch between source and header file' )
                -- end
                -- end)

                lsp.setup()

                vim.diagnostic.config({
                    virtual_text = true,
                })

                Mapper.map( 'n', '<leader>yy', [[:LspRestart<cr>]], opts, 'LSP', 'lsp_restart', 'Restart LSP' )
            end
        },
    }
