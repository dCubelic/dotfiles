local lsp = require( 'lsp-zero' )
lsp.preset( 'recommended' )

lsp.ensure_installed({
    'clangd',
    'tsserver',
    'eslint',
    'sumneko_lua',
    'rust_analyzer',
    'pylsp',
    'groovyls',
})

-- Fix Undefined global 'vim'
lsp.configure( 'sumneko_lua', {
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

-- add this only after adding CMake support, as described in the next chapter
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
    [ "S-<Tab>" ] = cmp.mapping( function( fallback )
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

    vim.keymap.set( "n", "\\", vim.lsp.buf.definition, opts )
    vim.keymap.set( "n", "K", vim.lsp.buf.hover, opts )
    vim.keymap.set( "n", '<leader>D', vim.lsp.buf.type_definition, opts )
    vim.keymap.set( "n", "<leader>vws", vim.lsp.buf.workspace_symbol, opts )
    vim.keymap.set( "n", "<leader>e", vim.diagnostic.open_float, opts )
    vim.keymap.set( "n", "[d", vim.diagnostic.goto_prev, opts )
    vim.keymap.set( "n", "]d", vim.diagnostic.goto_next, opts )
    vim.keymap.set( "n", "<leader>yF", vim.lsp.buf.code_action, opts )
    vim.keymap.set( "n", "<leader>yf", vim.lsp.buf.references, opts )
    vim.keymap.set( "n", "<leader>yr", vim.lsp.buf.rename, opts )
    vim.keymap.set( "n", "<leader>=", vim.lsp.buf.format, opts )
    vim.keymap.set( "v", "<leader>=", vim.lsp.buf.format, opts )

    -- if client.name == 'clangd' then
        vim.keymap.set( "n", "<leader>o", [[:ClangdSwitchSourceHeader<cr>]], opts )
    -- end
-- end)

lsp.setup()

vim.diagnostic.config({
    virtual_text = true,
})

vim.keymap.set( "n", "<leader>yy", [[:LspRestart<cr>]] )
