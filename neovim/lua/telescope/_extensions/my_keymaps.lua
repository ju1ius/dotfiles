local telescope = require('telescope')
local actions = require('telescope.actions')
local action_state = require('telescope.actions.state')
local pickers = require('telescope.pickers')
local finders = require('telescope.finders')
local previewers = require('telescope.previewers')
local conf = require('telescope.config').values

local K = require('my.utils.keys')

local function get_preview(entry)
  local lines = {}
  local summary = string.format('" %s', entry.opts.desc)
  table.insert(lines, summary)
  for _, mode in ipairs(entry.modes) do
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
    local m = string.format(
      '%s %s %s',
      prefix,
      entry.lhs,
      entry.rhs
    )
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

local function get_ordinal(mapping)
  if not mapping.opts.desc then
    return nil
  end
  local value = ''
  if mapping.opts.topic then
    value = mapping.opts.topic
  end
  return value .. ' ' .. mapping.opts.desc
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
      end
    }),
    sorter = conf.generic_sorter(opts),
    previewer = previewers.new_buffer_previewer({
      -- setup = function(self)
      --   require('telescope.previewers.utils').highlighter(self.state.bufnr, 'vim')
      -- end,
      define_preview = function(self, entry, status)
        vim.api.nvim_buf_set_option(self.state.bufnr, 'filetype', 'vim')
        local lines = get_preview(entry.value)
        vim.api.nvim_buf_set_lines(self.state.bufnr, 0, -1, false, lines)
      end,
    }),
    attach_mappings = function (prompt_bufnr, map)
      actions.select_default:replace(function()
        local selection = action_state.get_selected_entry()
        actions.close(prompt_bufnr)
        if selection == nil then
          return
        end
        local keys = vim.api.nvim_replace_termcodes(selection.value.lhs, true, false, true)
        vim.api.nvim_feedkeys(keys, 't', true)
      end)
      return true
    end
  })
  p:find()
end

return telescope.register_extension({
  setup = function() end,
  exports = {
    list = pick,
  },
})
