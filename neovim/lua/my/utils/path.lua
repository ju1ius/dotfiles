local M = {}

function M.source(path)
  return vim.cmd('source ' .. M.config_path(path))
end

function M.config(path)
  return vim.fn.stdpath('config') .. path
end

return M

