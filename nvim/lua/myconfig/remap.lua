-- -- single space should do nothing
vim.keymap.set({ 'n', 'v' }, '<Space>', '<Nop>', { silent = true })

-- Refresh file
vim.keymap.set( "n",  "<leader>r", vim.cmd.checktime, { silent = true } )

-- Tab navigation
vim.keymap.set( "n",  "{",  vim.cmd.tabprev, { silent = true } )
vim.keymap.set( "n",  "}",  vim.cmd.tabnext, { silent = true } )
vim.keymap.set( "n",  "<leader><c-w>", vim.cmd.tabclose, { silent = true } )

-- prevent accidental entering to Ex mode
vim.keymap.set( "n", "Q", "<nop>" )

-- Use space w for saving
vim.keymap.set( "n", "<leader>w", [[:w<cr>]] )

-- Use :W for saving as root
-- vim.cmd( [[command! W :execute ':silent w !sudo tee % > /dev/null' | :edit!]] )

-- alternate between last two files in the same window
vim.keymap.set( "n", '<leader>O', '<C-^>' )

-- -- don't do anything if LSP isn't attached and doesn't provide header/source switch operation
vim.keymap.set( 'n', '<leader>o', '<nop>' )

-- Use J and K to move selected text
vim.keymap.set( "v", "J", ":m '>+1<CR>gv=gv" )
vim.keymap.set( "v", "K", ":m '<-2<CR>gv=gv" )

-- Copy, cut and paste using system clipboard in visual mode
vim.keymap.set( "x", "<leader>Y", '"+y', { silent = true } )
vim.keymap.set( "x", "<leader>y", '"+y', { silent = true } )
vim.keymap.set( "n", "<leader>Y", '"+y', { silent = true } )
vim.keymap.set( "n", "<leader>y", '"+y', { silent = true } )
vim.keymap.set( "x", "<leader>D", '"+d', { silent = true } )
vim.keymap.set( "x", "<leader>p", '"+p', { silent = true } )
vim.keymap.set( "x", "<leader>P", '"+P', { silent = true } )
vim.keymap.set( "n", "<leader>p", '"+p', { silent = true } )
vim.keymap.set( "n", "<leader>P", '"+P', { silent = true } )

-- Center cursor when doing half page jumps / search
vim.keymap.set( "n", "<C-d>", "<C-d>zz" )
vim.keymap.set( "n", "<C-u>", "<C-u>zz" )
vim.keymap.set( "n", "n",     "nzzzv"   )
vim.keymap.set( "n", "N",     "Nzzzv"   )

-- don't replace pastebuffer with selected text when pasting in visual mode
vim.keymap.set( "x", "p", [["_dP]], { silent = true } )

-- turn off search highlights
vim.keymap.set( "n", "<leader>h", vim.cmd.noh, { silent = true } )

-- synchronize syntax engine
vim.keymap.set( "n", "<leader>ss", [[:syntax sync fromstart<cr>]] )

-- j and k should enter wrapped lines
vim.cmd(
    [[
        nnoremap <expr> <silent> j ( v:count == 0 ? 'gj' : 'j' )
        nnoremap <expr> <silent> k ( v:count == 0 ? 'gk' : 'k' )
    ]]
)

-- Select all in normal mode
vim.keymap.set( "n", "<leader><c-a>", "ggVG" )

-- Pretty-print the JSON
vim.keymap.set( "n", "<leader>jp", [[:%!python -m json.tool<cr>]] )

-- Conan update
vim.keymap.set( "n", "<leader>cu", [[:sp term://python3 -m mbconan %<cr>]] )

vim.cmd([[
    " Generic autocommands

    augroup genericautocommands
        au!

        " Triger `autoread` when files changes on disk
        " https://unix.stackexchange.com/questions/149209/refresh-changed-content-of-file-opened-in-vim/383044#383044
        " https://vi.stackexchange.com/questions/13692/prevent-focusgained-autocmd-running-in-command-line-editing-mode
        autocmd FocusGained,CursorHold,CursorHoldI *
        \ if mode() !~ '\v(c|r.?|!|t)' && getcmdwintype() == '' | checktime | endif

        " Notification after file change
        " https://vi.stackexchange.com/questions/13091/autocmd-event-for-autoread
        autocmd FileChangedShellPost *
        \ echohl WarningMsg | echo "File changed on disk. Buffer reloaded." | echohl None

        " Automatically remove all trailing whitespace on file save
        autocmd BufWritePre * %s/\s\+$//e

        " search for errors in qflist
        au BufWinEnter quickfix nmap <buffer> E /error:<CR>

    augroup END

]])
