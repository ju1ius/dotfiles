local M = {}

function M.dump(...)
  print(vim.inspect(...))
end

function M.write(message)
  local path = vim.fn.stdpath('cache') .. '/ju1ius.log'
  local log_file = io.open(path, 'a')
  if log_file then
    io.output(log_file)
    io.write(message .. '\n')
    io.close(log_file)
  else
    M.warn('Could not open log file: ' .. path, 'ju1ius')
  end
end

function M.info(msg, name)
  vim.notify(msg, vim.log.levels.INFO, { title = name })
end

function M.warn(msg, name)
  vim.notify(msg, vim.log.levels.WARN, { title = name })
end

function M.error(msg, name)
  vim.notify(msg, vim.log.levels.ERROR, { title = name })
end

return M
