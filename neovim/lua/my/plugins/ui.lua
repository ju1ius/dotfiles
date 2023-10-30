local map = require('my.utils.keys').map

local function not_utf8()
  return vim.opt.fileencoding:get() ~= 'utf-8'
end

local function format_is_not_unix()
  return vim.bo.fileformat ~= 'unix'
end

local function progress()
  return '%3p%%/%L'
end

return {
  {
    -- https://github.com/nvim-lualine/lualine.nvim
    'nvim-lualine/lualine.nvim',
    dependencies = {
      {'nvim-tree/nvim-web-devicons'},
    },
    config = function(plugin, opts)
      require('lualine').setup({
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
