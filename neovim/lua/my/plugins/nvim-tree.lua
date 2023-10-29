-- https://github.com/kyazdani42/nvim-tree.lua
local M = {}
local map = require('my.utils.keys').map

function M.setup()
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
    view = {},
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
    on_attach = function (bufno)
      local api = require 'nvim-tree.api'
      api.config.mappings.default_on_attach(bufno)
      map('n', '+', '', {
        buffer = bufno,
        desc = 'cd',
        topic = 'nvim-tree',
        callback = api.tree.change_root_to_node,
      })
      map('n', '?', '', {
        buffer = bufno,
        desc = 'Toggle help',
        topic = 'nvim-tree',
        callback = api.tree.toggle_help,
      })
      map('n', '$', '', {
        buffer = bufno,
        desc = 'Run file command',
        topic = 'nvim-tree',
        callback = api.tree.run_file_command,
      })
    end
  })
end

return M
