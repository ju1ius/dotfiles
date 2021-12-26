local mapkey = require('my.utils').mapkey
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

mapkey('n', '<Enter>', 'o<ESC>k', opts, {
  doc = 'Insert blank line after current',
})
mapkey('n', '<S-Enter>', 'o<ESC>j', opts, {
  doc = 'Insert blank line before current',
})

mapkey('', '<leader>y', '"+y', opts, {
  doc = 'Yank to clipboard',
})
mapkey('n', '<leader>yy', '"+yy', opts, {
  doc = 'Yank line to clipboard',
})
mapkey('', '<leader>p', '"+p', opts, {
  doc = 'Paste from clipboard',
})
mapkey('', '<leader>P', '"+P', opts, {
  doc = 'Paste from clipboard, insert before',
})

-- window navigation
mapkey('n', '<C-h>', '<C-w>h', opts, {
  doc = 'Go to window left',
})
mapkey('n', '<C-j>', '<C-w>j', opts, {
  doc = 'Go to window down',
})
mapkey('n', '<C-k>', '<C-w>k', opts, {
  doc = 'Go to window up',
})
mapkey('n', '<C-l>', '<C-w>l', opts, {
  doc = 'Go to window right',
})
-- buffer navigation
mapkey('n', '<S-l>', ':bnext<CR>', opts, {
  doc = 'Go to next buffer',
})
mapkey('n', '<S-h>', ':bprevious<CR>', opts, {
  doc = 'Go to previous buffer',
})
-- resize windows w/ arrow keys
mapkey('n', '<C-Up>', ':resize +2<CR>', opts, {
  doc = 'Increase window height',
})
mapkey('n', '<C-Down>', ':resize -2<CR>', opts, {
  doc = 'Decrease window height',
})
mapkey('n', '<C-Left>', ':vertical resize -2<CR>', opts, {
  doc = 'Decrease window width',
})
mapkey('n', '<C-Right>', ':vertical resize +2<CR>', opts, {
  doc = 'Increase window width',
})


-- Visual --
-- Stay in indent mode
mapkey('v', '<', '<gv', opts, {
  doc = 'Dedent and stay in visual mode',
})
mapkey('v', '>', '>gv', opts, {
  doc = 'Indent and stay in visual mode',
})

-- Move text up and down
mapkey('v', '<A-j>', ':m .+1<CR>==', opts, {
  doc = 'Move text down',
})
mapkey('v', '<A-k>', ':m .-2<CR>==', opts, {
  doc = 'Move text up',
})
mapkey('v', 'p', '"_dP', opts, {
  doc = 'Paste',
})

-- Visual Block --
-- Move text up and down
mapkey('x', 'J', ":move '>+1<CR>gv-gv", opts, {
  doc = 'Move text down',
})
mapkey('x', 'K', ":move '<-2<CR>gv-gv", opts, {
  doc = 'Move text up',
})
mapkey('x', '<A-j>', ":move '>+1<CR>gv-gv", opts, {
  doc = 'Move text down',
})
mapkey('x', '<A-k>', ":move '<-2<CR>gv-gv", opts, {
  doc = 'Move text up',
})

-- Terminal --
-- window navigation
mapkey('t', '<C-h>', '<C-\\><C-N><C-w>h', term_opts)
mapkey('t', '<C-j>', '<C-\\><C-N><C-w>j', term_opts)
mapkey('t', '<C-k>', '<C-\\><C-N><C-w>k', term_opts)
mapkey('t', '<C-l>', '<C-\\><C-N><C-w>l', term_opts)

-- Plugins -
if not vim.g.vscode then
  -- nvim-tree
  mapkey('n', '<leader>e', ':NvimTreeToggle<cr>', opts, {
    doc = 'Toggle file explorer',
  })
  mapkey('n', '<leader>f', [[:lua require('telescope.builtin').find_files(require('telescope.themes').get_dropdown({previewer=false}))<cr>]], opts, {
    doc = 'Find file with Telescope',
  })
  mapkey('n', '<C-t>', ':Telescope live_grep<cr>', opts, {
    doc = 'Telescope live grep',
  })
else
  -- https://open-vsx.org/extension/asvetliakov/vscode-neovim
  -- vim-commentary like mappings
  mapkey('x', 'gc', '<Plug>VSCodeCommentary', opts)
  mapkey('n', 'gc', '<Plug>VSCodeCommentary',opts)
  mapkey('o', 'gc', '<Plug>VSCodeCommentary', opts)
  mapkey('n', 'gcc', '<Plug>VSCodeCommentaryLine', opts)
end
