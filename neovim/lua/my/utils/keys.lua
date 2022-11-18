local T = require('my.utils.tables')

local M = {}

---@alias Mode 'n'|'i'|'c'|'v'|'x'|'s'|'o'|'t'|'l'|'!'

---@class Options
---@field desc string
---@field topic string
---@field noremap boolean
---@field remap boolean
---@field silent boolean
---@field buffer integer
---@field callback function
---@field nowait boolean
---@field script boolean
---@field expr boolean
---@field unique boolean
---@field replace_keycodes boolean

---@class Mapping
---@field modes Mode[]
---@field lhs string
---@field rhs string
---@field opts Options

---@type table<string, Mapping>
local mappings = {}

---@type table<string, table<string, Mapping>>
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

---@param mapping Mapping
---@return string
local function hash(mapping)
  return string.format('%s|%s', table.concat(mapping.modes, ''), mapping.lhs)
end

---@param opts Options
---@return Options
local function get_default_options(opts)
  local defaults = {silent = true}
  return vim.tbl_extend('force', defaults, opts or {})
end

---@param modes Mode|Mode[]|''
---@return Mode[]
local function normalize_modes(modes)
  if modes == '' then
    modes = {'n', 'v', 'o'}
  elseif type(modes) ~= 'table' then
    modes = {modes}
  end
  return modes
end

---@param mapping Mapping
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

---Registers a vim key mapping
---@param modes Mode|Mode[]|''
---@param lhs string
---@param rhs string
---@param opts Options
function M.map(modes, lhs, rhs, opts)
  local mapping = {
    modes = normalize_modes(modes),
    lhs = lhs,
    rhs = rhs,
    opts = get_default_options(opts),
  }
  register(mapping)
end

---Unregister a key mapping
---@param modes Mode|Mode[]|''
---@param lhs string
---@param buffer number|nil
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

---Uregisters all registerd mapping for a buffer
---@param bufnr number
function M.clear_buffer(bufnr)
  -- print(vim.fn.bufname(tonumber(bufnr)))
  buf_mappings[tostring(bufnr)] = nil
end

---Returns all registered mappings (optionally restricted to a given buffer)
---@param bufnr number|nil
---@return Mapping[]
function M.get_all(bufnr)
  -- print(vim.inspect(buf_mappings))
  local m = vim.tbl_values(mappings)
  local bm = vim.tbl_values(buf_mappings[tostring(bufnr)] or {})
  return vim.list_extend(m, bm)
end

local augroup = vim.api.nvim_create_augroup('ju1ius_keymaps', {})
vim.api.nvim_create_autocmd('BufUnload', {
  callback = function(args)
    M.clear_buffer(args.buf)
  end,
  group = augroup,
})

return M
