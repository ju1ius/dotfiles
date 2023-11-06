local telescope = require('telescope')
local actions = require('telescope.actions')
local action_state = require('telescope.actions.state')
local pickers = require('telescope.pickers')
local finders = require('telescope.finders')
local previewers = require('telescope.previewers')
local conf = require('telescope.config').values

local K = require('my.utils.keys')

---@param mapping  Mapping
---@return string
local function repr_rhs(mapping)
  if K.is_virtual(mapping) then
    -- try to get a repr from vim keymap
    for _, mode in ipairs(mapping.modes) do
      local rhs = vim.fn.maparg(mapping.lhs, mode)
      if rhs ~= '' then
        return rhs
      end
    end
    return '<virtual>'
  end
  if K.is_function(mapping) then
    for _, mode in ipairs(mapping.modes) do
      local rhs = vim.fn.maparg(mapping.lhs, mode)
      if rhs ~= '' then
        return rhs
      end
    end
    return '<Lua: unknown>'
  end
  return mapping.rhs
end

---@param mode Mode
---@return string
local function describe_mode(mode)
  local modes = K.get_mode_names(mode)
  local is_plural = #modes > 1
  return table.concat(modes, ', ') .. ' mode' .. (is_plural and 's' or '')
end

---Returns the ordinal form of the mapping description.
---@param desc string
---@return string
local function desc_to_ordinal(desc)
  local s, _ = string.gsub(desc, '^%[([%w%p]-)%]', '%1', 1)
  return s
end

---Removes the topic annotation from the mapping description.
---@param desc string
---@return string
local function strip_topic(desc)
  local s, _ = string.gsub(desc, '^%[([%w%p]-)%]%s*', '', 1)
  return s
end

---@param entry Mapping
---@return string[]
local function get_preview(entry)
  local lines = {}
  local summary = string.format('" %s', strip_topic(entry.opts.desc))
  table.insert(lines, summary)
  for _, mode in ipairs(entry.modes) do
    table.insert(lines, '" ' .. describe_mode(mode))
    local prefix = mode
    if entry.opts.noremap then
      prefix = prefix .. 'nore'
    end
    prefix = prefix .. 'map'
    if entry.opts.buffer then
      prefix = prefix .. ' <buffer>'
    end
    if entry.opts.silent then
      prefix = prefix .. ' <silent>'
    end
    if entry.opts.expr then
      prefix = prefix .. ' <expr>'
    end
    local m = string.format('%s %s %s', prefix, entry.lhs, repr_rhs(entry))
    table.insert(lines, m)
  end
  return lines
end

local function display_entry(entry)
  local mapping = entry.value
  local value = ''
  if mapping.opts.topic then
    value = '[' .. mapping.opts.topic .. '] '
  end
  if mapping.opts.desc then
    value = value .. mapping.opts.desc
  end
  return value
end

---@param mapping Mapping
---@return string|nil
local function get_ordinal(mapping)
  if not mapping.opts.desc then
    return nil
  end
  local value = ''
  if mapping.opts.topic then
    value = mapping.opts.topic .. ' '
  end
  return value .. desc_to_ordinal(mapping.opts.desc)
end

local function pick(opts)
  opts = opts or {}
  local bufnr = vim.fn.bufnr()
  local p = pickers.new(opts, {
    prompt_title = 'My Keymaps',
    finder = finders.new_table({
      results = K.get_all(bufnr),
      entry_maker = function(entry)
        return {
          value = entry,
          display = display_entry,
          ordinal = get_ordinal(entry),
        }
      end,
    }),
    sorter = conf.generic_sorter(opts),
    previewer = previewers.new_buffer_previewer({
      -- setup = function(self)
      --   require('telescope.previewers.utils').highlighter(self.state.bufnr, 'vim')
      -- end,
      define_preview = function(self, entry, status)
        vim.api.nvim_set_option_value('filetype', 'vim', { buf = self.state.bufnr })
        local lines = get_preview(entry.value)
        vim.api.nvim_buf_set_lines(self.state.bufnr, 0, -1, false, lines)
      end,
    }),
    attach_mappings = function(prompt_bufnr, map)
      actions.select_default:replace(function()
        local selection = action_state.get_selected_entry()
        actions.close(prompt_bufnr)
        if selection == nil then
          return
        end
        local mapping = selection.value
        if not K.is_virtual(mapping) then
          local keys = vim.api.nvim_replace_termcodes(selection.value.lhs, true, false, true)
          vim.api.nvim_feedkeys(keys, 't', true)
        end
      end)
      return true
    end,
  })
  p:find()
end

return telescope.register_extension({
  setup = function() end,
  exports = {
    list = pick,
  },
})
