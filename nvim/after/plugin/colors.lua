function DefineColors( color )
    color = color or 'tokyonight-night'
    vim.cmd.colorscheme( color )

    vim.opt.termguicolors = true
end

-- need to be called twice, otherwise completion popups have weird unreadable darkblue color
-- Why?!?
DefineColors()
DefineColors()



