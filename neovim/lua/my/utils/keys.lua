local T = require('my.utils.tables')

local M = {}

local mappings = {}
local buf_mappings = {}

local nvim_allowed_opts = {'noremap', 'silent', 'nowait', 'script', 'expr', 'unique'}
local default_opts = {
  noremap = true,
  silent = true,
}

local function register(mapping)
  local buffer = mapping.opts.buffer
  if buffer then
    buffer = tostring(buffer)
    if buf_mappings[buffer] == nil then
      buf_mappings[buffer] = {}
    end
    table.insert(buf_mappings[buffer], mapping)
  else
    table.insert(mappings, mapping)
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
  opts = vim.tbl_extend('force', {}, default_opts, opts)
  local mapping = {
    modes=modes,
    lhs=lhs,
    rhs=rhs,
    opts=opts,
  }
  register(mapping)
end

function M.flush()
end

function M.clear_buffer(bufnr)
  -- print(vim.fn.bufname(tonumber(bufnr)))
  buf_mappings[tostring(bufnr)] = nil
end

function M.get_all(bufnr)
  -- print(vim.inspect(buf_mappings))
  local m = vim.list_slice(mappings)
  return vim.list_extend(m, buf_mappings[tostring(bufnr)] or {})
end

return M
