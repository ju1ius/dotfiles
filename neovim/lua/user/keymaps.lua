
local mapkey = vim.api.nvim_set_keymap
local opts = {noremap = true, silent = true}
local term_opts = {silent = true}

-- use space as leader key
mapkey('', '<Space>', '<Nop>', opts)
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

-- insert line after/before
mapkey('n', '<Enter>', 'o<ESC>k', opts)
mapkey('n', '<S-Enter>', 'o<ESC>j', opts)

-- yank & paste to/from clipboard
mapkey('', '<leader>y', '"+y', opts)
mapkey('n', '<leader>yy', '"+yy', opts)
mapkey('', '<leader>p', '"+p', opts)
mapkey('n', '<leader>P', '"+P', opts)

-- window navigation
mapkey('n', '<C-h>', '<C-w>h', opts)
mapkey('n', '<C-j>', '<C-w>j', opts)
mapkey('n', '<C-k>', '<C-w>k', opts)
mapkey('n', '<C-l>', '<C-w>l', opts)
-- buffer navigation
mapkey('n', '<S-l>', ':bnext<CR>', opts)
mapkey('n', '<S-h>', ':bprevious<CR>', opts)
-- resize windows w/ arrow keys
mapkey('n', '<C-Up>', ':resize +2<CR>', opts)
mapkey('n', '<C-Down>', ':resize -2<CR>', opts)
mapkey('n', '<C-Left>', ':vertical resize -2<CR>', opts)
mapkey('n', '<C-Right>', ':vertical resize +2<CR>', opts)


-- Visual --
-- Stay in indent mode
mapkey('v', '<', '<gv', opts)
mapkey('v', '>', '>gv', opts)

-- Move text up and down
mapkey('v', '<A-j>', ':m .+1<CR>==', opts)
mapkey('v', '<A-k>', ':m .-2<CR>==', opts)
mapkey('v', 'p', '"_dP', opts)

-- Visual Block --
-- Move text up and down
mapkey('x', 'J', ":move '>+1<CR>gv-gv", opts)
mapkey('x', 'K', ":move '<-2<CR>gv-gv", opts)
mapkey('x', '<A-j>', ":move '>+1<CR>gv-gv", opts)
mapkey('x', '<A-k>', ":move '<-2<CR>gv-gv", opts)

-- Terminal --
-- window navigation
mapkey('t', '<C-h>', '<C-\\><C-N><C-w>h', term_opts)
mapkey('t', '<C-j>', '<C-\\><C-N><C-w>j', term_opts)
mapkey('t', '<C-k>', '<C-\\><C-N><C-w>k', term_opts)
mapkey('t', '<C-l>', '<C-\\><C-N><C-w>l', term_opts)

-- Plugins -
if not vim.g.vscode then
  -- nvim-tree
  mapkey('n', '<leader>e', ':NvimTreeToggle<cr>', opts)
  mapkey('n', '<leader>f', [[:lua require('telescope.builtin').find_files(require('telescope.themes').get_dropdown({previewer=false}))<cr>]], opts)
  mapkey('n', '<C-t>', ':Telescope live_grep<cr>', opts)
else
  -- https://open-vsx.org/extension/asvetliakov/vscode-neovim
  -- vim-commentary like mappings
  mapkey('x', 'gc', '<Plug>VSCodeCommentary', {})
  mapkey('n', 'gc', '<Plug>VSCodeCommentary', {})
  mapkey('o', 'gc', '<Plug>VSCodeCommentary', {})
  mapkey('n', 'gcc', '<Plug>VSCodeCommentaryLine', {})
end
