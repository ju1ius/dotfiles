-- https://github.com/folke/trouble.nvim#%EF%B8%8F-configuration
--
require('trouble').setup({

})

local map = require('my.utils.keys').map
map('n', '<leader>td', ':TroubleToggle<CR>', {
  topic = 'lsp',
  summary = 'Toggle diagnostics window (trouble.nvim)',
})
