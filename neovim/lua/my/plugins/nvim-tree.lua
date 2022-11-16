-- https://github.com/kyazdani42/nvim-tree.lua
local M = {}

function M.setup()
  local map = require('my.utils.keys').map
  map('n', '<leader>te', ':NvimTreeFindFileToggle<CR>', {
    desc = 'Toggle file explorer',
  })
end

function M.configure()
  local nvim_tree = require('nvim-tree')
  nvim_tree.setup({
    diagnostics = {
      enable = true,
    },
    view = {
      mappings = {
        list = {
          {action = 'cd', key = {'+', '<C-Enter>'}},
          {action = 'toggle_help', key = '?'},
          {action = 'run_file_command', key = '$'},
        },
      },
    },
    renderer = {
      highlight_git = true,
      highlight_opened_files = "icon",
      icons = {
        glyphs = {
          -- default = '',
          -- symlink = '',
          -- git = {
          --   unstaged = '',
          --   staged = 'S',
          --   unmerged = '',
          --   renamed = '➜',
          --   deleted = '',
          --   untracked = 'U',
          --   ignored = '◌',
          -- },
          -- folder = {
          --   arrow_open = '',
          --   arrow_closed = '',
          --   default = '',
          --   open = '',
          --   empty = '',
          --   empty_open = '',
          --   symlink = '',
          --   symlink_open = '',
          -- },
        },
      },
    },
  })
end

return M
