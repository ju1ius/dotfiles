-- https://github.com/mbbill/undotree
-- options: https://github.com/mbbill/undotree/blob/master/plugin/undotree.vim#L26

local map = require('my.utils.keys').map

map('n', '<leader>tu', ':UndotreeToggle<CR>', {
  topic = 'undo',
  desc = 'Toggles undo tree panel.',
})

-- focus undotree window on open
vim.g.undotree_SetFocusWhenToggle = true
-- Layouts:
-- 1: tree left, diff left
-- 2: tree left, diff below
-- 3: tree right, diff right
-- 4: tree right, diff below
vim.g.undotree_WindowLayout = 3

