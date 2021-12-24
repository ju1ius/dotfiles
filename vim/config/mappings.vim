let mapleader="\<Space>"
let maplocalleader=";"
nnoremap <Space> <Nop>

" yank & paste to clipboard
noremap <leader>y "+y
noremap <leader>yy "+yy
noremap <leader>p "+p
noremap <leader>P "+P

" insert line after/before in normal mode
noremap <Enter> o<ESC>k
noremap <S-Enter> O<ESC>j

" Better indenting in visual mode
vnoremap < <gv
vnoremap > >gv

" window navigation
noremap <C-h> <C-w>h
noremap <C-j> <C-w>j
noremap <C-k> <C-w>k
noremap <C-l> <C-w>l
" buffer navigation
noremap <S-l> :bnext<CR>
noremap <S-h> :bprevious<CR>
" resize windows w/ arrow keys
noremap <C-Up> :resize +2<CR>
noremap <C-Down> :resize -2<CR>
noremap <C-Left> :vertical resize -2<CR>
noremap <C-Right> :vertical resize +2<CR>

" ===== Vim help mappings =====
augroup helpMappings
  autocmd!
  " <enter> to follow tag
  autocmd FileType help nnoremap <buffer><cr> <c-]>
  " <backspace> to gi back
  autocmd FileType help nnoremap <buffer><bs> <c-T>
  " <q> to quit
  autocmd FileType help nnoremap <buffer>q :q<CR>
  autocmd FileType help setlocal nonumber
augroup END
