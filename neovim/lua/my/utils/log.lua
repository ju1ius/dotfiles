local M = {}

function M.dump(...)
  print(vim.inspect(...))
end

function M.info(msg, name)
  vim.notify(msg, vim.log.levels.INFO, {title = name})
end

function M.warn(msg, name)
  vim.notify(msg, vim.log.levels.WARN, {title = name})
end

function M.error(msg, name)
  vim.notify(msg, vim.log.levels.ERROR, {title = name})
end

return M


