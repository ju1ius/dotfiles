-- https://github.com/nvim-lualine/lualine.nvim

local lualine = require('lualine')

local function not_utf8()
  return vim.opt.fileencoding:get() ~= 'utf-8'
end

local function format_is_not_unix()
  return vim.bo.fileformat ~= 'unix'
end

local function progress()
  return '%3p%%/%L'
end

lualine.setup({
  options = {
    theme = 'onedark',
    disabled_filetypes = {
      'NvimTree',
    },
  },
  sections = {
    lualine_a = {'mode'},
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

