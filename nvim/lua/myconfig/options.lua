-- For multi-byte character support (CJK support, for example):
vim.opt.fileencodings = 'utf-8,cp1250,ucs-bom,cp936,big5,euc-jp,euc-kr,gb18030,latin1'

vim.opt.tabstop         = 4    -- Number of spaces that a <Tab> in the file counts for.
vim.opt.softtabstop     = 4    -- columns a tab inserts in insert mode
vim.opt.shiftwidth      = 4    -- Number of spaces to use for each step of (auto)indent.
vim.opt.splitbelow      = true -- horizontal split below
vim.opt.splitright      = true -- vertical split right
vim.opt.expandtab       = true -- always use spaces
vim.opt.wildmenu        = true -- visual autocomplete for the command menu
vim.opt.wildignorecase  = true -- ignore case when autocompleting command menu
vim.opt.smarttab        = true -- When on, a <Tab> in front of a line inserts blanks
                               -- according to 'shiftwidth'. 'tabstop' is used in other
                               -- places. A <BS> will delete a 'shiftwidth' worth of space
                               -- at the start of the line.
vim.opt.laststatus      = 2    -- always display the status line
vim.opt.showcmd         = true -- Show (partial) command in status line.
vim.opt.number          = true -- Show line numbers.
vim.opt.relativenumber  = true -- Show hybrid line numbers
vim.opt.showmatch       = true -- When a bracket is inserted, briefly jump to the matching
                                -- one. The jump is only done if the match can be seen on the
                                -- screen. The time to show the match can be set with
                                -- 'matchtime'.
vim.opt.cursorline = true       -- always highlight current line
vim.opt.incsearch  = true       -- While typing a search command, show immediately where the
                                -- so far typed pattern matches.

vim.opt.ignorecase = true       -- Ignore case in search patterns.

vim.opt.smartcase = true        -- Override the 'ignorecase' option if the search pattern
                                -- contains upper case characters.

vim.opt.autoindent = true       -- Copy indent from current line when starting a new line
                                -- (typing <CR> in Insert mode or when using the --o-- or --O--
                                -- command).

vim.opt.textwidth = 0     	-- Maximum width of text that is being inserted. A longer
                    		-- line will be broken after white space to get this width.
vim.opt.wrapmargin   = 0
vim.opt.smartindent  = true
vim.opt.hlsearch     = true   	-- highlight search terms

vim.opt.formatoptions='cqrtl' 	-- This is a sequence of letters which describes how
                        	-- automatic formatting is to be done.
                        	--
                        	-- letter    meaning when present in 'formatoptions'
                        	-- ------    ---------------------------------------
                        	-- c         Auto-wrap comments using textwidth, inserting
                        	--           the current comment leader automatically.
                        	-- q         Allow formatting of comments with --gq--.
                        	-- r         Automatically insert the current comment leader
                        	--           after hitting <Enter> in Insert mode.
                        	-- t         Auto-wrap text using textwidth (does not apply
                        	--           to comments)

vim.opt.ruler = true        -- Show the line and column number of the cursor position,
                    		-- separated by a comma

vim.opt.scrolloff = 6       -- Start scrolling when top/bottom 6 lines are reached

vim.opt.mouse       = 'a'   -- Enable the use of the mouse.
vim.opt.wrap        = true 	-- Wrap long lines
vim.opt.linebreak   = true 	-- Wrap long lines at word boundary
vim.opt.showcmd     = true 	-- show last line of the last command on the screen
vim.opt.showtabline = 2     -- Always show tabs, even if single tab is open
vim.opt.exrc        = true  -- Enable reading of local, project-level .vimrc files
vim.opt.secure      = true  -- Don't allow --:autocmd--, shell and write commands in .vimrc and .exrc
vim.opt.autoread    = true  -- Automatically reload files modified by others if not modified by vim

vim.opt.ttimeout    = true     -- make vim wait less after e.g. <ESC>0, More info: https://vi.stackexchange.com/questions/24925/usage-of-timeoutlen-and-ttimeoutlen/24938#24938
vim.opt.ttimeoutlen = 100
vim.opt.redrawtime  = 10000  -- Increase the limit for syntax highlight redraw (useful in high load scenarios)

-- saving undo history for each file permanently, so it gets available even after editor restart
vim.opt.undofile   = true
vim.opt.undodir    = os.getenv( "HOME" ) .. "/.cache/nvim/undo"
vim.opt.undolevels = 5000

-- complete options for buffers not managed by LSP
vim.opt.completeopt = 'preview,menuone,noselect'

-- Don't give warning when opening file that is already opened in another vim
-- instance - simply default to "edit anyway"
vim.cmd( [[set shortmess+=A]] )

-- Allows for auto-complete in visual block mode, also allows for visual block
-- selection of section without characters.
vim.cmd( [[set virtualedit+=block]] )

vim.cmd([[
    augroup disable_json_conceal
        au!
        autocmd BufEnter *.json setlocal conceallevel=0
    augroup END
]])
