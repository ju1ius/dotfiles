-- https://github.com/nvim-telescope/telescope.nvim#getting-started

local function init()
  local map = require('my.utils.keys').map
  map('n', '<leader>ff', nil, {
    desc = 'Find file with Telescope',
    callback = function()
      local theme = require('telescope.themes').get_dropdown({ previewer = false })
      require('telescope.builtin').find_files(theme)
    end,
  })
  map('n', '<leader>fr', ':Telescope oldfiles<CR>', {
    desc = 'Find recent files',
  })
  map('n', '<leader>fgc', ':Telescope git_commits<CR>', {
    desc = 'Find git commit',
  })
  map('n', '<leader>fgcb', ':Telescope git_bcommits<CR>', {
    desc = 'Find git commit for current buffer',
  })
  map('n', '<C-t>', ':Telescope live_grep<CR>', {
    desc = 'Telescope live grep',
  })
  map('n', '<leader>fk', ':Telescope my_keymaps list layout_strategy=center<CR>', {
    desc = 'Find key mapping',
  })
end

local function setup()
  local telescope = require('telescope')
  telescope.setup({
    defaults = {
      -- prompt_prefix = ' ',
      prompt_prefix = ' ',
      selection_caret = ' ',
      path_display = { 'smart' },
      -- defaults
      -- borderchars = { '─', '│', '─', '│', '╭', '╮', '╯', '╰' },
      borderchars = { '─', '│', '─', '│', '┌', '┐', '┘', '└' },
    },
    pickers = {
      -- Default configuration for builtin pickers goes here:
      -- picker_name = {
      --   picker_config_key = value,
      --   ...
      -- }
      -- Now the picker_config_key will be applied every time you call this
      -- builtin picker
    },
    extensions = {
      fzf = {
        fuzzy = true,
        override_generic_sorter = true,
        override_file_sorter = true,
        case_mode = 'smart_case',
      },
      my_keymaps = {},
      -- Your extension configuration goes here:
      -- extension_name = {
      --   extension_config_key = value,
      -- }
      -- please take a look at the readme of the extension you want to configure
    },
  })

  telescope.load_extension('fzf')
  telescope.load_extension('my_keymaps')
end

return {
  {
    'nvim-telescope/telescope.nvim',
    dependencies = {
      { 'nvim-lua/plenary.nvim', cond = true },
      { 'nvim-telescope/telescope-fzf-native.nvim', build = 'make' },
    },
    cmd = 'Telescope',
    keys = {
      { '<leader>tel', ':Telescope<CR>', desc = 'Lanch Telescope', topic = 'telescope,search' },
    },
    init = init,
    config = setup,
  },
}
