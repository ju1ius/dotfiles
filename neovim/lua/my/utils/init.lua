local log = require('my.utils.log')

local M = {}

function M.reload_vimrc()
  log.info('Reloading init.lua', 'config')
  require('plenary.reload').reload_module('my')
  vim.cmd('source $MYVIMRC')
  require('packer').sync()
end

return M
