-- https://github.com/folke/trouble.nvim#%EF%B8%8F-configuration
--
require('trouble').setup({

})

local map = require('my.utils.keys').map
map('n', '<leader>td', ':TroubleToggle<CR>', {
  summary = 'Toggle LSP diagnostics window',
})
