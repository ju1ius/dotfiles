local function not_utf8()
  return vim.opt.fileencoding:get() ~= 'utf-8'
end

local function format_is_not_unix()
  return vim.bo.fileformat ~= 'unix'
end

local function progress()
  return '%3p%%/%L'
end

-- Setting cmdheight=0 hides the macro recording notification,
-- so we display it in the statusbar instead
local function make_macro_component()
  local timer = require("my.utils.timer")
  local lualine = require('lualine')
  local function format()
    local register = vim.fn.reg_recording()
    if register == '' then return end
    return '@' .. register
  end

  local function refresh()
    lualine.refresh{place = {'statusline'}}
  end

  local augroup = vim.api.nvim_create_augroup('lualine_macro_component', {})
  vim.api.nvim_create_autocmd('RecordingEnter', {
    group = augroup,
    callback = refresh,
  })
  vim.api.nvim_create_autocmd('RecordingLeave', {
    group = augroup,
    callback = function()
      -- wait 50ms so that `vim.fn.recording` can catch-up
      timer.delay(50, refresh)
    end,
  })

  return {
    'macro-recording',
    fmt = format,
    cond = function() return vim.o.cmdheight == 0 end,
  }
end

return function()
  require('lualine').setup({
    options = {
      theme = 'onedark',
      disabled_filetypes = {
        'NvimTree',
      },
    },
    sections = {
      lualine_a = {'mode', make_macro_component()},
      lualine_b = {'branch', 'diff', 'diagnostics'},
      lualine_c = {'filename'},
      lualine_x = {
        {'encoding', cond = not_utf8},
        {'fileformat', cond = format_is_not_unix},
        'filetype',
      },
      lualine_y = {progress},
      lualine_z = {'location'}
    },
  })
end
