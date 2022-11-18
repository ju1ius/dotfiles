-- https://github.com/akinsho/bufferline.nvim#configuration
--
local K = require('my.utils.keys')
local bufferline = require('bufferline')

bufferline.setup({
  options = {
    indicator = {style = 'underline'},
    hover = {
      enabled = true,
    },
  },
})

K.map('n', '<C-tab>', '<Cmd>BufferLineCycleNext<CR>', {
  noremap = true,
  topics = 'bufferline',
  desc = 'go to next tab',
})
K.map('n', '<S-tab>', '<Cmd>BufferLineCyclePrev<CR>', {
  noremap = true,
  topics = 'bufferline',
  desc = 'go to previous tab',
})
