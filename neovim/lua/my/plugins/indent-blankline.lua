-- https://github.com/lukas-reineke/indent-blankline.nvim
-- TODO: add keymap for :IndentBlanklineToggle

require('indent_blankline').setup({
  disable_with_nolist = true,
  use_treesitter = true,
  char = '▏',
  -- context_char = '▎',
  context_char = '▏',
  show_current_context = true,
  -- show_current_context_start = true,
  buftype_exclude = {
    'terminal',
    'no_file'
  },
  filetype_exclude = {
    "help",
    'startify',
    'dashboard',
    'packer',
    'neogitstatus',
    'NvimTree',
    'Trouble',
  },
  context_patterns = {
    'class',
    'function',
    'method',
    'if_statement', 'else_clause',
    'try_statement', 'catch_clause',
    'switch_statement',
    'while_statement', 'for_statement',
    'jsx_element',
  },
})
