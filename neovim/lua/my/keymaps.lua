local map = require('my.utils.keys').map
local term_opts = {silent = true}

-- removes help message when pressing <C-c> in normal mode
vim.api.nvim_set_keymap('n', '<C-c>', '<C-c>', {noremap = true, silent = true})

-- use space as leader key
vim.api.nvim_set_keymap('', '<Space>', '<Nop>', {noremap = true, silent = true})
vim.g.mapleader = ' '
vim.g.maplocalleader = ' '

---------- Modes
-- normal mode = 'n'
-- insert mode = 'i'
-- visual mode = 'v'
-- visual block mode = 'x'
-- terminal mode = 't'
-- command mode = 'c'

-- Normal --

map('n', '<Enter>', 'o<ESC>k', {
  summary = 'Insert blank line after current',
})
map('n', '<S-Enter>', 'o<ESC>j', {
  summary = 'Insert blank line before current',
})

map({'n', 'v', 'o'}, '<leader>y', '"+y', {
  summary = 'Yank to clipboard',
})
map('', '<leader>yy', '"+yy', {
  summary = 'Yank line to clipboard',
})
map('', '<leader>p', '"+p', {
  summary = 'Paste from clipboard',
})
map('', '<leader>P', '"+P', {
  summary = 'Paste from clipboard, insert before',
})

-- window navigation
map('n', '<C-h>', '<C-w>h', {
  summary = 'Go to window left',
})
map('n', '<C-j>', '<C-w>j', {
  summary = 'Go to window down',
})
map('n', '<C-k>', '<C-w>k', {
  summary = 'Go to window up',
})
map('n', '<C-l>', '<C-w>l', {
  summary = 'Go to window right',
})
-- buffer navigation
map('n', '<S-l>', ':bnext<CR>', {
  summary = 'Go to next buffer',
})
map('n', '<S-h>', ':bprevious<CR>', {
  summary = 'Go to previous buffer',
})
-- resize windows w/ arrow keys
map('n', '<C-Up>', ':resize +2<CR>', {
  summary = 'Increase window height',
})
map('n', '<C-Down>', ':resize -2<CR>', {
  summary = 'Decrease window height',
})
map('n', '<C-Left>', ':vertical resize -2<CR>', {
  summary = 'Decrease window width',
})
map('n', '<C-Right>', ':vertical resize +2<CR>', {
  summary = 'Increase window width',
})


-- Visual --
-- Stay in indent mode
map('v', '<', '<gv', {
  summary = 'Dedent and stay in visual mode',
})
map('v', '>', '>gv', {
  summary = 'Indent and stay in visual mode',
})

-- Move text up and down
map('v', '<A-j>', ':m .+1<CR>==', {
  summary = 'Move text down',
})
map('v', '<A-k>', ':m .-2<CR>==', {
  summary = 'Move text up',
})
map('v', 'p', '"_dP', {
  summary = 'Paste',
})

-- Visual Block --
-- Move text up and down
map('x', 'J', ":move '>+1<CR>gv-gv", {
  summary = 'Move text down',
})
map('x', 'K', ":move '<-2<CR>gv-gv", {
  summary = 'Move text up',
})
map('x', '<A-j>', ":move '>+1<CR>gv-gv", {
  summary = 'Move text down',
})
map('x', '<A-k>', ":move '<-2<CR>gv-gv", {
  summary = 'Move text up',
})

-- Terminal --
-- window navigation
map('t', '<C-h>', '<C-\\><C-N><C-w>h', term_opts)
map('t', '<C-j>', '<C-\\><C-N><C-w>j', term_opts)
map('t', '<C-k>', '<C-\\><C-N><C-w>k', term_opts)
map('t', '<C-l>', '<C-\\><C-N><C-w>l', term_opts)

-- Plugins -
if vim.g.vscode then
  -- https://open-vsx.org/extension/asvetliakov/vscode-neovim
  -- vim-commentary like mappings
  map('', 'gc', '<Plug>VSCodeCommentary')
  map('n', 'gcc', '<Plug>VSCodeCommentaryLine')
end
