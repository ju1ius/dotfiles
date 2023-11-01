local map = require('my.utils.keys').map

return {
  {
    -- https://github.com/nvim-lualine/lualine.nvim
    'nvim-lualine/lualine.nvim',
    dependencies = {
      {'nvim-tree/nvim-web-devicons'},
    },
    config = function(plugin, opts)
      require('my.plugins.ui.lualine')()
    end,
  },
  {
    -- https://github.com/akinsho/bufferline.nvim#configuration
    'akinsho/bufferline.nvim',
    dependencies = {
      {'nvim-tree/nvim-web-devicons'},
    },
    config = function(plugin, opts)
      require('bufferline').setup({
        options = {
          indicator = {style = 'underline'},
          hover = {
            enabled = true,
          },
          buffer_close_icon = '✗',
          offsets = {
            {
              filetype = 'NvimTree',
              text = 'Explorer',
              highlight = 'Directory',
              separator = false, -- use a "true" to enable the default, or set your own character
            },
          },
        },
      })
      map('n', '<C-tab>', '<Cmd>BufferLineCycleNext<CR>', {
        noremap = true,
        topics = 'bufferline',
        desc = 'go to next tab',
      })
      map('n', '<S-tab>', '<Cmd>BufferLineCyclePrev<CR>', {
        noremap = true,
        topics = 'bufferline',
        desc = 'go to previous tab',
      })
    end,
  },
  {
    -- https://github.com/nvim-tree/nvim-tree.lua
    'nvim-tree/nvim-tree.lua',
    dependencies = {
      {'nvim-tree/nvim-web-devicons'},
    },
    cmd = {'NvimTreeToggle', 'NvimTreeFindFileToggle'},
    init = function()
      map('n', '<leader>te', ':NvimTreeFindFileToggle<CR>', {
        desc = 'Toggle file explorer',
      })
    end,
    config = function(plugin, opts)
      require('nvim-tree').setup({
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
    end,
  },
  {
    -- https://github.com/mbbill/undotree
    'mbbill/undotree',
    cmd = 'UndotreeToggle',
    init = function()
      -- focus undotree window on open
      vim.g.undotree_SetFocusWhenToggle = true
      -- Layouts:
      -- 1: tree left, diff left
      -- 2: tree left, diff below
      -- 3: tree right, diff right
      -- 4: tree right, diff below
      vim.g.undotree_WindowLayout = 3

      local map = require('my.utils.keys').map
      map('n', '<leader>tu', ':UndotreeToggle<CR>', {
        topic = 'undo',
        desc = 'Toggles undo tree panel.',
      })
    end,
    config = function(plugin, opts) end,
  },
}
