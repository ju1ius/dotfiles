local map = require('my.utils.keys').map

return {
  {
    -- https://github.com/nvim-lualine/lualine.nvim
    'nvim-lualine/lualine.nvim',
    dependencies = {
      { 'nvim-tree/nvim-web-devicons' },
    },
    config = function(plugin, opts)
      require('my.plugins.ui.lualine')()
    end,
  },
  {
    -- https://github.com/akinsho/bufferline.nvim#configuration
    'akinsho/bufferline.nvim',
    dependencies = {
      { 'nvim-tree/nvim-web-devicons' },
    },
    config = function(plugin, opts)
      require('bufferline').setup({
        options = {
          indicator = { style = 'underline' },
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
      { 'nvim-tree/nvim-web-devicons' },
    },
    cmd = { 'NvimTreeToggle', 'NvimTreeFindFileToggle' },
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
          highlight_opened_files = 'icon',
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
        on_attach = function(bufno)
          local api = require('nvim-tree.api')
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
        end,
      })
    end,
  },
  {
    -- https://github.com/mbbill/undotree
    'mbbill/undotree',
    cmd = { 'UndotreeToggle' },
    keys = {
      { '<leader>tu', ':UndotreeToggle<CR>', desc = 'Toggle undo tree panel' },
    },
    init = function()
      -- focus undotree window on open
      vim.g.undotree_SetFocusWhenToggle = true
      -- Layouts:
      -- 1: tree left, diff left
      -- 2: tree left, diff below
      -- 3: tree right, diff right
      -- 4: tree right, diff below
      vim.g.undotree_WindowLayout = 3
    end,
  },
  {
    "rcarriga/nvim-notify",
    keys = {
      {
        "<leader>dn",
        desc = "Dismiss all Notifications",
        function()
          require("notify").dismiss({ silent = true, pending = true })
        end,
      },
    },
    opts = {
      timeout = 5000,
      max_height = function()
        return math.floor(vim.o.lines * 0.75)
      end,
      max_width = function()
        return math.floor(vim.o.columns * 0.75)
      end,
      on_open = function(win)
        if vim.api.nvim_win_is_valid(win) then
          vim.api.nvim_win_set_config(win, { zindex = 100, border = "single" })
        end
      end,
    },
    init = function()
      vim.notify = require("notify")
      -- -- when noice is not enabled, install notify on VeryLazy
      -- if not Util.has("noice.nvim") then
      --   Util.on_very_lazy(function()
      --     vim.notify = require("notify")
      --   end)
      -- end
    end,
  }
}
