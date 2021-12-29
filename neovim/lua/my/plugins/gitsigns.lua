-- https://github.com/lewis6991/gitsigns.nvim

require('gitsigns').setup({
  -- register the keymaps ourselves so we can have nice documentation
  keymaps = {},
})

local map = require('my.utils.keys').map

map('n', ']c', "&diff ? ']c' : '<cmd>Gitsigns next_hunk<CR>'", {
  expr = true,
  summary = 'Git go to next hunk',
})
map('n', ']c', "&diff ? '[c' : '<cmd>Gitsigns prev_hunk<CR>'", {
  expr = true,
  summary = 'Git go to previous hunk',
})
map({'n', 'v'}, '<leader>ghs', '<cmd>Gitsigns stage_hunk<CR>', {
  summary = 'Git stage current hunk',
})
-- map('v', '<leader>hs', ':Gitsigns stage_hunk<CR>', {
--   summary = 'Git stage current hunk',
-- })
map('n', '<leader>ghu', '<cmd>Gitsigns undo_stage_hunk<CR>', {
  summary = 'Gut undo stage hunk',
})
map({'n', 'v'}, '<leader>ghr', '<cmd>Gitsigns reset_hunk<CR>', {
  summary = 'Git reset hunk',
})
-- map('v', '<leader>hr', ':Gitsigns reset_hunk<CR>', {
--   summary = 'Git reset hunk',
-- })
map('n', '<leader>ghR', '<cmd>Gitsigns reset_buffer<CR>', {
  summary = 'Gitsigns reset buffer',
})
map('n', '<leader>ghp', '<cmd>Gitsigns preview_hunk<CR>', {
  summary = 'Git preview hunk',
})
map('n', '<leader>ghb', '<cmd>lua require"gitsigns".blame_line{full=true}<CR>', {
  summary = 'Git blame line',
})
map('n', '<leader>ghS', '<cmd>Gitsigns stage_buffer<CR>', {
  summary = 'Git stage buffer',
})
map('n', '<leader>ghU', '<cmd>Gitsigns reset_buffer_index<CR>', {
  summary = 'Gitsigns reset buffer index',
})

-- text objects

map('o', 'h', ':<C-U>Gitsigns select_hunk<CR>', {
  summary = 'Git select hunk',
})
map('x', 'h', ':<C-U>Gitsigns select_hunk<CR>', {
  summary = 'Git select hunk',
})

