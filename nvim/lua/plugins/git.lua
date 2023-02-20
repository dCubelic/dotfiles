return
{
    {
        -- Git integration for Vim
        'tpope/vim-fugitive',
        dependencies = {
            -- Make fugitive work with GitHub
            'tpope/vim-rhubarb',
            -- Make fugitive work with BitBucket
            'tommcdo/vim-fubitive'
        },
        cmd = {
            'Git',
            'GitFF',
        },
        keys = {
            '<leader>t',
            '<leader>g',
        },
        config = function()
            vim.cmd([[
                command! Gitf :Git! fetch
                nnoremap <silent> <leader>dl :diffget //2<CR>
                nnoremap <silent> <leader>dr :diffget //3<CR>

                "---------------------------------------------------
                " Utility command :GitFF that will automatically
                " invoke git checkout dest_branch && git merge origin/current_branch && git remote prune origin && git branch -d current_branch
                " Useful for branch cleanup after it gets merged master/stable.
                " Use as ':GitFF' or ':GitFF stable'
                "---------------------------------------------------
                function! GitFastForward( dest_branch = 'master' ) abort
                    let currentBranch = FugitiveHead()
                    execute 'Git checkout ' . a:dest_branch
                    execute 'Git merge origin/' . a:dest_branch
                    Git remote prune origin
                    execute 'Git branch -d ' . currentBranch
                endfunction

                command! -nargs=? GitFF call GitFastForward(<f-args>)

                "---------------------------------------------------
                " Open Tig in terminal horizontal split
                "---------------------------------------------------
                command! Tig :bo sp term://tig -C %:p:h --all
                nnoremap <leader>t :Tig<cr>

                "---------------------------------------------------
                " Open LazyGit in new tab
                "---------------------------------------------------
                command! LazyGit :tabnew term://lazygit
                nnoremap <leader>g :LazyGit<cr>

                " obtained from here: https://www.reddit.com/r/neovim/comments/cger8p/comment/eupal7q/?utm_source=share&utm_medium=web2x&context=3
                augroup terminal_settings
                    autocmd!

                    " Automatically enter insert mode on entering terminal, except in case of python tools
                    autocmd BufWinEnter,WinEnter term://*
                          \ if (expand('<afile>') !~ "python") |
                          \   startinsert  |
                          \ endif
                    autocmd BufLeave term://* stopinsert

                    " Ignore various filetypes as those will close terminal automatically
                    " Ignore fzf, ranger, coc and python as we want to leave terminal open for python tools such as mbconan
                    autocmd TermClose term://*
                          \ if (expand('<afile>') !~ "fzf") && (expand('<afile>') !~ "ranger") && (expand('<afile>') !~ "python") |
                          \   call nvim_input('<CR>')  |
                          \ endif
                augroup END
            ]])
        end

    }
}
