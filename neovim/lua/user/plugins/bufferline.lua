-- https://github.com/akinsho/bufferline.nvim#configuration
--
local bufferline = require('bufferline')

bufferline.setup({
  options = {
    -- use vim-bbye commands to properly handle focus on buffer close
    close_command = 'Bdelete! %d',
    right_mouse_command = 'Bdelete! %d',
  },
})

