-- https://github.com/nvim-telescope/telescope.nvim#getting-started

local M = {}

function M.setup()
  local map = require('my.utils.keys').map
  map('n', '<leader>ff', '[lua code]', {
    desc = 'Find file with Telescope',
    callback = function()
      local theme = require('telescope.themes').get_dropdown({previewer=false})
      require('telescope.builtin').find_files(theme)
    end
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

function M.configure()
  local telescope = require('telescope')
  local actions = require('telescope.actions')
  telescope.setup({
    defaults = {

      prompt_prefix = ' ',
      selection_caret = ' ',
      path_display = {'smart'},

      mappings = {
        i = {
          ['<C-n>'] = actions.cycle_history_next,
          ['<C-p>'] = actions.cycle_history_prev,

          ['<C-j>'] = actions.move_selection_next,
          ['<C-k>'] = actions.move_selection_previous,

          ['<C-c>'] = actions.close,

          ['<Down>'] = actions.move_selection_next,
          ['<Up>'] = actions.move_selection_previous,

          ['<CR>'] = actions.select_default,
          ['<C-x>'] = actions.select_horizontal,
          ['<C-v>'] = actions.select_vertical,
          ['<C-t>'] = actions.select_tab,

          ['<C-u>'] = actions.preview_scrolling_up,
          ['<C-d>'] = actions.preview_scrolling_down,

          ['<PageUp>'] = actions.results_scrolling_up,
          ['<PageDown>'] = actions.results_scrolling_down,

          ['<Tab>'] = actions.toggle_selection + actions.move_selection_worse,
          ['<S-Tab>'] = actions.toggle_selection + actions.move_selection_better,
          ['<C-q>'] = actions.send_to_qflist + actions.open_qflist,
          ['<M-q>'] = actions.send_selected_to_qflist + actions.open_qflist,
          ['<C-l>'] = actions.complete_tag,
          ['<C-_>'] = actions.which_key, -- keys from pressing <C-/>
        },

        n = {
          ['<esc>'] = actions.close,
          ['<CR>'] = actions.select_default,
          ['<C-x>'] = actions.select_horizontal,
          ['<C-v>'] = actions.select_vertical,
          ['<C-t>'] = actions.select_tab,

          ['<Tab>'] = actions.toggle_selection + actions.move_selection_worse,
          ['<S-Tab>'] = actions.toggle_selection + actions.move_selection_better,
          ['<C-q>'] = actions.send_to_qflist + actions.open_qflist,
          ['<M-q>'] = actions.send_selected_to_qflist + actions.open_qflist,

          ['j'] = actions.move_selection_next,
          ['k'] = actions.move_selection_previous,
          ['H'] = actions.move_to_top,
          ['M'] = actions.move_to_middle,
          ['L'] = actions.move_to_bottom,

          ['<Down>'] = actions.move_selection_next,
          ['<Up>'] = actions.move_selection_previous,
          ['gg'] = actions.move_to_top,
          ['G'] = actions.move_to_bottom,

          ['<C-u>'] = actions.preview_scrolling_up,
          ['<C-d>'] = actions.preview_scrolling_down,

          ['<PageUp>'] = actions.results_scrolling_up,
          ['<PageDown>'] = actions.results_scrolling_down,

          ['?'] = actions.which_key,
        },
      },
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
      -- media_files = {
      --   -- filetypes whitelist
      --   -- defaults to {"png", "jpg", "mp4", "webm", "pdf"}
      --   filetypes = {'png', 'webp', 'jpg', 'jpeg'},
      --   find_cmd = 'rg' -- find command (defaults to `fd`)
      -- },
      -- Your extension configuration goes here:
      -- extension_name = {
      --   extension_config_key = value,
      -- }
      -- please take a look at the readme of the extension you want to configure
    },
  })

  telescope.load_extension('fzf')
  telescope.load_extension('my_keymaps')
-- telescope.load_extension('media_files')
end

return M

