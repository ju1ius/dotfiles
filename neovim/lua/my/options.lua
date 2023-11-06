-------------------- Text
vim.opt.fileencoding = 'utf-8'
-- show line numbers
vim.opt.number = true
vim.opt.relativenumber = true
-- always show the sign column, otherwise it would shift the text each time
vim.opt.signcolumn = 'yes'
-- no line wrapping
vim.opt.wrap = false
vim.opt.breakindent = true
-- highlight current line
vim.opt.cursorline = true
vim.opt.scrolloff = 8
vim.opt.sidescrolloff = 8
-- Horizontal splits will automatically be below
vim.opt.splitbelow = true
-- Vertical splits will automatically be to the right
vim.opt.splitright = true

-------------------- Search
vim.opt.ignorecase = true
vim.opt.smartcase = true
vim.opt.incsearch = true

-------------------- Tabs, whitespace
-- convert tabs to spaces
vim.opt.expandtab = true
-- insert 2 spaces for a tab
vim.opt.softtabstop = 2
-- change the number of space characters inserted for indentation
vim.opt.shiftwidth = 2
vim.opt.smartindent = true
vim.opt.listchars = { eol = '↴' }

-------------------- Backups
vim.opt.backup = false
vim.opt.swapfile = false
-- persistent undo
if not vim.g.vscode then
  vim.opt.undofile = true
end

-------------------- GUI
vim.opt.cmdheight = 1
-- popup menu height
vim.opt.pumheight = 10
-- vim.opt.guioptions = 'aegimrLt'
-- vim.opt.guifont = 'JetBrains Mono Nerd Font Regular 11'
vim.opt.mouse = 'a'
vim.opt.belloff = 'all'
-- termguicolors doesn't work inside tmux sessions...
if vim.fn.has('termguicolors') and not os.getenv('TMUX') then
  vim.opt.termguicolors = true
end

-- sets a default colorscheme
vim.cmd.colorscheme('default')
vim.opt.background = 'dark'

-- search & replace
if vim.fn.executable('rg') then
  vim.opt.grepprg = [[rg --vimgrep --smart-case]]
end

-- recommended for nvim-tree
vim.g.loaded_netrw = 1
vim.g.loaded_netrwPlugin = 1
