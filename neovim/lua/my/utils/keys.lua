local T = require('my.utils.tables')
local log = require("my.utils.log")
local dump = require("my.utils.log").dump

local M = {}

---@alias Mode 'n'|'i'|'c'|'v'|'x'|'s'|'o'|'t'|'l'|'!'

---@as table<Mode, string[]>
local mode_names = {
  ['n'] = {'normal'},
  ['i'] = {'insert'},
  ['v'] = {'visual', 'select'},
  ['x'] = {'visual'},
  ['s'] = {'select'},
  ['c'] = {'command-line'},
  ['o'] = {'operator-pending'},
  ['t'] = {'terminal-job'},
  ['l'] = {'insert', 'command-line', 'lang-arg'},
  ['!'] = {'insert', 'command-line'}
}

---@class Options
---@field desc string?
---@field topic string?
---@field virtual boolean?
---@field noremap boolean?
---@field remap boolean?
---@field silent boolean?
---@field buffer integer?
---@field callback function?
---@field nowait boolean?
---@field script boolean?
---@field expr boolean?
---@field unique boolean?
---@field replace_keycodes boolean?

---@class MappingBase
---@field modes Mode[]
---@field lhs string

---@class Mapping: MappingBase
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

---@param mapping MappingBase
---@return string
local function hash(mapping)
  return string.format('%s|%s', table.concat(mapping.modes, ''), mapping.lhs)
end

---@param opts Options|nil
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
  if not mapping.opts.virtual then
    local opts = T.pick(nvim_allowed_opts, mapping.opts)
    vim.keymap.set(mapping.modes, mapping.lhs, mapping.rhs, opts)
  end
end

---Registers a vim key mapping
---@param modes Mode|Mode[]|''
---@param lhs string
---@param rhs string
---@param opts Options|nil
function M.map(modes, lhs, rhs, opts)
  local mapping = {
    modes = normalize_modes(modes),
    lhs = lhs,
    rhs = rhs,
    opts = get_default_options(opts),
  }
  register(mapping)
end

---Registers a virtual key mapping
---Use this to document mappings not registerable with using `map()`.
---@param modes Mode|Mode[]|''
---@param lhs string
---@param opts Options|nil
function M.virtual(modes, lhs, opts)
  opts = vim.tbl_extend('keep', {virtual = true}, opts or {})
  M.map(modes, lhs, "", opts)
end

---Unregister a key mapping
---@param modes Mode|Mode[]|''
---@param lhs string
---@param buffer number|nil
function M.unmap(modes, lhs, buffer)
  modes = normalize_modes(modes)
  local h = hash({modes = modes, lhs = lhs})
  local mapping = nil
  if buffer then
    local k = tostring(buffer)
    mapping = buf_mappings[k][h]
    if mapping then
      buf_mappings[k][h] = nil
    end
  else
    mapping = mappings[h]
    mappings[h] = nil
  end
  if mapping and not mapping.opts.virtual then
    vim.keymap.del(modes, lhs, {buffer = buffer})
  end
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

---Returns the display names of the given mode
---@param mode Mode
---@return string[]
function M.get_mode_names(mode)
  return mode_names[mode]
end

--Registers virtual mappings for each key entry in lazy.vim plugin specs.
function M.register_lazy_keys()
  local lazy_config = require('lazy.core.config')
  local lazy_allowed = vim.list_slice(nvim_allowed_opts)
  vim.list_extend(lazy_allowed, {1, 2, 'mode', 'lhs', 'ft'})
  for _, plugin in pairs(lazy_config.plugins) do
    -- dump(plugin)
    local keys = vim.tbl_get(plugin or {}, '_', 'handlers', 'keys') or {}
    for _, keymap in pairs(keys) do
      if keymap.desc and #keymap.desc > 0 then
        M.virtual(keymap.mode, keymap.lhs, keymap)
        T.keep(lazy_allowed, keymap)
      end
    end
  end
end

local augroup = vim.api.nvim_create_augroup('ju1ius_keymaps', {})
vim.api.nvim_create_autocmd('BufUnload', {
  callback = function(args)
    M.clear_buffer(args.buf)
  end,
  group = augroup,
})

return M
