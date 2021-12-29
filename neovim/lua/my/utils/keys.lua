local T = require('my.utils.tables')

local M = {}

local mappings = {}
local buf_mappings = {}

local nvim_allowed_opts = {'noremap', 'silent', 'nowait', 'script', 'expr', 'unique'}

local function hash(mapping)
  return string.format('%s|%s', table.concat(mapping.modes, ''), mapping.lhs)
end

local function get_default_options(opts, rhs)
  local defaults = {noremap = true, silent = true}
  if opts.noremap == nil then
    if vim.startswith(rhs:lower(), '<plug>') then
      opts.noremap = false
    end
  end
  return vim.tbl_extend('force', defaults, opts)
end

local function register(mapping)
  local h = hash(mapping)
  local buffer = mapping.opts.buffer
  if buffer then
    buffer = tostring(buffer)
    if buf_mappings[buffer] == nil then
      buf_mappings[buffer] = {}
    end
    buf_mappings[buffer][h] = mapping
  else
    mappings[h] = mapping
  end
  local opts = T.pick(nvim_allowed_opts, mapping.opts)
  for _, mode in ipairs(mapping.modes) do
    if buffer == nil then
      vim.api.nvim_set_keymap(mode, mapping.lhs, mapping.rhs, opts)
    else
      vim.api.nvim_buf_set_keymap(buffer, mode, mapping.lhs, mapping.rhs, opts)
    end
  end
end

function M.map(modes, lhs, rhs, opts)
  if modes == '' then
    modes = {'n', 'v', 'o'}
  elseif type(modes) ~= 'table' then
    modes = {modes}
  end
  local mapping = {
    modes=modes,
    lhs=lhs,
    rhs=rhs,
    opts=get_default_options(opts, rhs),
  }
  register(mapping)
end

function M.unmap(modes, lhs, buffer)
  local h = hash({modes = modes, lhs = lhs})
  if buffer then
    buf_mappings[tostring(buffer)][h] = nil
    for _, mode in ipairs(modes) do
      vim.api.nvim_buf_del_keymap(buffer, mode, lhs)
    end
  else
    mappings[h] = nil
    for _, mode in ipairs(modes) do
      vim.api.nvim_del_keymap(mode, lhs)
    end
  end
end

function M.clear_buffer(bufnr)
  -- print(vim.fn.bufname(tonumber(bufnr)))
  buf_mappings[tostring(bufnr)] = nil
end

function M.get_all(bufnr)
  -- print(vim.inspect(buf_mappings))
  local m = vim.tbl_values(mappings)
  local bm = vim.tbl_values(buf_mappings[tostring(bufnr)] or {})
  return vim.list_extend(m, bm)
end

return M
