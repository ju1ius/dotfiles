" enables hidden buffers (required to keep multiple buffers open)
set hidden
" set directories for swap files & backups
set directory=~/.local/share/vim/swap//,.
set backupdir=~/.local/share/vim/backup//,.

" ========== Appearance ==========
set guioptions=aegimrLt
set guifont=JetBrains\ Mono\ Nerd\ Font\ 11
set mouse=a
if version >= 800
  set belloff=all
endif

" termguicolors doesn't work inside tmux sessions...
if has("termguicolors") && empty($TMUX)
  set termguicolors
endif

let g:onedark_termcolors=16
colorscheme onedark

" Enable highlighting of the current line
set cursorline


" ========== window management ==========

" Horizontal splits will automatically be below
set splitbelow
" Vertical splits will automatically be to the right
set splitright


" ========== text management ==========

" make search case-insensitive unless uppercase characters are entered
set ignorecase
set smartcase
" make search incremental
set incsearch

" Line numbering
set number
" set relativenumber
" augroup numberToggle
"   autocmd!
"   autocmd BufEnter,FocusGained,InsertLeave * set relativenumber
"   autocmd BufLeave,FocusLost,InsertEnter   * set norelativenumber
" augroup END

" Line wrapping
set nowrap
set breakindent
augroup ftWrap
  autocmd!
  autocmd FileType markdown,text setlocal wrap
  autocmd BufNewFile,BufRead * if empty(&filetype) | setlocal wrap | endif
augroup END


" =========== Tabs & Whitespace ==========

" Converts tabs to spaces
set expandtab
" Insert 2 spaces for a tab
set softtabstop=2
" Change the number of space characters inserted for indentation
set shiftwidth=2
augroup ftTabSizes
  autocmd!
  autocmd FileType php,python setlocal shiftwidth=4 softtabstop=4
  autocmd FileType make setlocal noexpandtab
augroup END

" Custom Commands

" Closes all buffers and reopen the current one
command! CloseBuffers :%bd | exe "normal! \<C-O>"

