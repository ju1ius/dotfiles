-- https://github.com/lewis6991/gitsigns.nvim

local map = require('my.utils.keys').map

require('gitsigns').setup({
  -- register the keymaps ourselves so we can have nice documentation
  on_attach = function(bufno)
    map('n', ']c', "&diff ? ']c' : '<cmd>Gitsigns next_hunk<CR>'", {
      buffer = bufno,
      expr = true,
      topic = 'git',
      desc = 'Go to next hunk',
    })
    map('n', '[c', "&diff ? '[c' : '<cmd>Gitsigns prev_hunk<CR>'", {
      buffer = bufno,
      expr = true,
      topic = 'git',
      desc = 'Go to previous hunk',
    })
    map({'n', 'v'}, '<leader>ghs', '<cmd>Gitsigns stage_hunk<CR>', {
      buffer = bufno,
      desc = 'Git stage current hunk',
      topic = 'git',
    })
    -- mapV', '<leader>hs', ':Gitsigns stage_hunk<CR>', {
    --   desc = 'Git stage current hunk',
    -- })
    map('n', '<leader>ghu', '<cmd>Gitsigns undo_stage_hunk<CR>', {
      buffer = bufno,
      topic = 'git',
      desc = 'Undo stage hunk',
    })
    map({'n', 'v'}, '<leader>ghr', '<cmd>Gitsigns reset_hunk<CR>', {
      buffer = bufno,
      desc = 'Git reset hunk',
      topic = 'git',
    })
    -- mapV', '<leader>hr', ':Gitsigns reset_hunk<CR>', {
    --   desc = 'Git reset hunk',
    -- })
    map('n', '<leader>ghR', '<cmd>Gitsigns reset_buffer<CR>', {
      buffer = bufno,
      topic = 'git',
      desc = 'Gitsigns reset buffer',
    })
    map('n', '<leader>ghp', '<cmd>Gitsigns preview_hunk<CR>', {
      buffer = bufno,
      topic = 'git',
      desc = 'Preview hunk',
    })
    map('n', '<leader>ghb', '<cmd>lua require"gitsigns".blame_line{full=true}<CR>', {
      buffer = bufno,
      topic = 'git',
      desc = 'Blame line',
    })
    map('n', '<leader>ghS', '<cmd>Gitsigns stage_buffer<CR>', {
      buffer = bufno,
      topic = 'git',
      desc = 'Stage buffer',
    })
    map('n', '<leader>ghU', '<cmd>Gitsigns reset_buffer_index<CR>', {
      buffer = bufno,
      topic = 'git',
      desc = 'Gitsigns reset buffer index',
    })

    -- text objects

    map({'o', 'x'}, 'h', ':<C-U>Gitsigns select_hunk<CR>', {
      buffer = bufno,
      topic = 'git',
      desc = 'Select hunk',
    })

  end
})
