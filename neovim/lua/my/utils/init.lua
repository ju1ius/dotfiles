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

local mappings = {}

function M.mapkey(mode, lhs, rhs, opts, desc)
  table.insert(mappings, {
    mode=mode,
    lhs=lhs,
    rhs=rhs,
    opts=opts or {},
    desc=desc or {},
  })
end

function M.register_mappings()
  local wk_ok, wk = nil, nil--pcall(require, 'which-key')
  for _, mapping in ipairs(mappings) do
    if wk_ok then
      local opts = vim.tbl_deep_extend('keep', {mode = mapping.mode}, mapping.opts, mapping.desc)
      wk.register({
        [mapping.lhs] = {mapping.rhs, mapping.desc.doc},
      }, opts)
    else
      vim.api.nvim_set_keymap(
        mapping.mode,
        mapping.lhs,
        mapping.rhs,
        mapping.opts
      )
    end
  end
end

return M

