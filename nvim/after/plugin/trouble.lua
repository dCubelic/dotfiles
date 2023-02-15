require("trouble").setup {}

Mapper = require("nvim-mapper")
Mapper.map( 'n', '<leader>x', '<cmd>TroubleToggle<cr>', { silent = true }, 'Trouble', 'trouble_toggle', 'Toggle Trouble' )
