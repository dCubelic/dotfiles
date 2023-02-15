return
{
    -- Hex editor
    'fidian/hexmode',
    cmd = 'ToggleHex',
    config = function()
        vim.cmd([[
        let g:hexmode_patterns = '*.bin,*.exe,*.dat,*.o,*.png,*.jpg,*.jpeg,*.ppv,*.yuv,*.jar,*.class,*.zip,*.tf'
        command! ToggleHex call ToggleHex()
        ]])
    end
}
