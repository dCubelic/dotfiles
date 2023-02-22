Mapper = require("nvim-mapper")

Mapper.map( 'n', '<space>'      , '<nop>'                                , { silent = true }, 'Utils', 'space_nop'            , 'Single space should do nothing'                      )
Mapper.map( 'n', '<leader>r'    , vim.cmd.checktime                      , { silent = true }, 'Utils', 'refresh_file'         , 'Refresh file'                                        )
Mapper.map( 'n', 'Q'            , '<nop>'                                , { silent = true }, 'Utils', 'prevent_ex_mode'      , 'Prevent accidental entering to Ex mode'              )
Mapper.map( 'n', '<leader>w'    , [[:w<cr>]]                             , { silent = true }, 'Utils', 'save_buffer'          , 'Save current buffer'                                 )
Mapper.map( 'n', '<leader>O'    , '<C-^>'                                , { silent = true }, 'Utils', 'alternate_files'      , 'Alternate between last two files in the same window' )
Mapper.map( 'n', '<leader>h'    , vim.cmd.noh                            , { silent = true }, 'Utils', 'search_highlights_off', 'Turn off search highlights'                          )
Mapper.map( 'n', '<leader>ss'   , [[:syntax sync fromstart<cr>]]         , { silent = true }, 'Utils', 'sync_syntax_engine'   , 'Synchronize syntax engine'                           )
Mapper.map( 'n', '<leader><c-a>', 'ggVG'                                 , { silent = true }, 'Utils', 'select_all'           , 'Select all in normal mode'                           )
Mapper.map( 'n', '<leader>jp'   , [[:%!python -m json.tool<cr>]]         , { silent = true }, 'Utils', 'prettify_json'        , 'Pretty-print JSON'                                   )
Mapper.map( 'n', '<leader>cu'   , [[:sp term://python3 -m mbconan %<cr>]], { silent = true }, 'Utils', 'mbconan'              , 'Conan update'                                        )

Mapper.map( 'v', 'J'    , ":m '>+1<CR>gv=gv", { silent = true }, 'Navigation', 'move_selected_text_up'    , 'User J to move selected text down'            )
Mapper.map( 'v', 'K'    , ":m '<-2<CR>gv=gv", { silent = true }, 'Navigation', 'move_selected_text_down'  , 'User K to move selected text up'              )
Mapper.map( 'n', '<C-d>', '<C-d>zz'         , { silent = true }, 'Navigation', 'center_cursor_down'       , 'Center cursor when doing half page jump down' )
Mapper.map( 'n', '<C-u>', '<C-u>zz'         , { silent = true }, 'Navigation', 'center_cursor_up'         , 'Center cursor when doing half page jump up'   )
Mapper.map( 'n', 'n'    , 'nzzzv'           , { silent = true }, 'Navigation', 'center_cursor_search'     , 'Center cursor when searching next'            )
Mapper.map( 'n', 'N'    , 'Nzzzv'           , { silent = true }, 'Navigation', 'center_cursor_search_prev', 'Center cursor when searching previous'        )

Mapper.map( 'x', '<leader>Y', '"+y', { silent = true }, 'Clipboard', 'copy_to_clipboard'    , 'Copy to system clipboard'    )
Mapper.map( 'x', '<leader>y', '"+y', { silent = true }, 'Clipboard', 'copy_to_clipboard2'   , 'Copy to system clipboard'    )
Mapper.map( 'n', '<leader>Y', '"+y', { silent = true }, 'Clipboard', 'copy_to_clipboard3'   , 'Copy to system clipboard'    )
Mapper.map( 'n', '<leader>y', '"+y', { silent = true }, 'Clipboard', 'copy_to_clipboard4'   , 'Copy to system clipboard'    )
Mapper.map( 'x', '<leader>D', '"+d', { silent = true }, 'Clipboard', 'clipboard'            , '"+d"'                        )
Mapper.map( 'x', '<leader>p', '"+p', { silent = true }, 'Clipboard', 'paste_from_clipboard' , 'Paste from system clipboard' )
Mapper.map( 'x', '<leader>P', '"+P', { silent = true }, 'Clipboard', 'paste_from_clipboard2', 'Paste from system clipboard' )
Mapper.map( 'n', '<leader>p', '"+p', { silent = true }, 'Clipboard', 'paste_from_clipboard3', 'Paste from system clipboard' )
Mapper.map( 'n', '<leader>P', '"+p', { silent = true }, 'Clipboard', 'paste_from_clipboard4', 'Paste from system clipboard' )

Mapper.map( 'x', 'p', [["_dP]], { silent = true }, 'Clipboard', 'clipboard_dont_replace_buffer', 'Do not replace pastebuffer with selected text when pasting in visual mode' )

-- j and k should enter wrapped lines
vim.cmd(
    [[
        nnoremap <expr> <silent> j ( v:count == 0 ? 'gj' : 'j' )
        nnoremap <expr> <silent> k ( v:count == 0 ? 'gk' : 'k' )
    ]]
)

-- Use :W for saving as root
vim.cmd( [[command! W :execute ':silent w !sudo tee % > /dev/null' | :edit!]] )

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

        " search for errors and warnings in qflist
        au BufWinEnter quickfix nmap <buffer> E /error:<CR>
        au BufWinEnter quickfix nmap <buffer> W /warning:<CR>

    augroup END

]])
