local T = require('my.utils.tables')

local M = {}

local mappings = {}
local buf_mappings = {}
-- options accepted by vim.keymap.set()
local nvim_allowed_opts = {
  'noremap',
  'remap',
  'silent',
  'nowait',
  'script',
  'expr',
  'unique',
  'desc',
  'callback',
  'replace_keycodes',
}

local function hash(mapping)
  return string.format('%s|%s', table.concat(mapping.modes, ''), mapping.lhs)
end

local function get_default_options(opts)
  local defaults = {silent = true}
  return vim.tbl_extend('force', defaults, opts or {})
end

local function normalize_modes(modes)
  if modes == '' then
    modes = {'n', 'v', 'o'}
  elseif type(modes) ~= 'table' then
    modes = {modes}
  end
  return modes
end

local function register(mapping)
  local h = hash(mapping)
  local buffer = mapping.opts.buffer
  if buffer then
    local bufkey = tostring(buffer)
    if buf_mappings[bufkey] == nil then
      buf_mappings[bufkey] = {}
    end
    buf_mappings[bufkey][h] = mapping
  else
    mappings[h] = mapping
  end
  local opts = T.pick(nvim_allowed_opts, mapping.opts)
  vim.keymap.set(mapping.modes, mapping.lhs, mapping.rhs, opts)
end

function M.map(modes, lhs, rhs, opts)
  local mapping = {
    modes = normalize_modes(modes),
    lhs = lhs,
    rhs = rhs,
    opts = get_default_options(opts),
  }
  register(mapping)
end

function M.unmap(modes, lhs, buffer)
  modes = normalize_modes(modes)
  local h = hash({modes = modes, lhs = lhs})
  if buffer then
    buf_mappings[tostring(buffer)][h] = nil
  else
    mappings[h] = nil
  end
  vim.keymap.del(modes, lhs, {buffer = buffer})
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
