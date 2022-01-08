-- https://github.com/kyazdani42/nvim-tree.lua
local M = {}

vim.g.nvim_tree_icons = {
  default = '',
  symlink = '',
  git = {
    unstaged = '',
    staged = 'S',
    unmerged = '',
    renamed = '➜',
    deleted = '',
    untracked = 'U',
    ignored = '◌',
  },
  folder = {
    arrow_open = '',
    arrow_closed = '',
    default = '',
    open = '',
    empty = '',
    empty_open = '',
    symlink = '',
    symlink_open = '',
  },
}

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
  })
end

return M
