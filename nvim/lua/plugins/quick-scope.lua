return
{
    -- Quick navigation within line
    {
        'unblevable/quick-scope',
        event = { "BufReadPost", "BufNewFile" },
        config = function()
            vim.cmd([[
                highlight QuickScopePrimary gui=bold,underline cterm=bold,underline
                highlight QuickScopeSecondary gui=underline,bold,italic cterm=underline,bold,italic

                augroup qs_colors
                    autocmd!
                    autocmd ColorScheme * highlight QuickScopePrimary gui=bold,underline cterm=bold,underline
                    autocmd ColorScheme * highlight QuickScopeSecondary gui=underline,bold,italic  cterm=underline,bold,italic
                augroup END

                let g:qs_max_chars = 400
                let g:qs_buftype_blacklist = ['terminal', 'nofile']
            ]])
        end
    }
}
