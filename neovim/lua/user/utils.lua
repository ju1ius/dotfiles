local M = {}

function M.source(path)
  return vim.cmd('source ' .. M.config_path(path))
end

function M.config_path(path)
  return vim.fn.stdpath('config') .. path
end

function M.reload_vimrc()
  vim.notify('Reloading init.lua')
  require('plenary.reload').reload_module('user')
  vim.cmd('source $MYVIMRC')
  require('packer').sync()
end

return M

