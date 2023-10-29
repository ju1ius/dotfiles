-- https://github.com/lukas-reineke/indent-blankline.nvim
-- TODO: add keymap for :IndentBlanklineToggle

require('ibl').setup({
  indent = {
    char = '▏',
  },
  scope = {
    enabled = true,
    char = '▏',
  },
  exclude = {
    buftypes = {'terminal', 'no_file'},
    filetypes = {
      "help",
      'startify',
      'dashboard',
      'packer',
      'neogitstatus',
      'NvimTree',
      'Trouble',
    },
  },
})
