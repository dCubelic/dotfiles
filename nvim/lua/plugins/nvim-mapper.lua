return
{
    'lazytanuki/nvim-mapper',
    config = function()
        require('nvim-mapper').setup({
            -- Available actions:
            --   * "definition" - Go to keybind definition (default)
            --   * "execute" - Execute the keybind command
            action_on_enter = "execute",
        })
    end
}
