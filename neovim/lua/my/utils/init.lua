local M = {}

function M.reload_vimrc()
  vim.notify('Reloading init.lua')
  require('plenary.reload').reload_module('user')
  vim.cmd('source $MYVIMRC')
  require('packer').sync()
end

return M

