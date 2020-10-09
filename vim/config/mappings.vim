let mapleader="\<Space>"
nnoremap <Space> <Nop>

" yank & paste to clipboard
noremap <leader>y "+y
noremap <leader>p "+p
" insert line after/before in normal mode
noremap <Enter> o<ESC>k
noremap <S-Enter> O<ESC>j

" Better indenting in visual mode
vnoremap < <gv
vnoremap > >gv

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
