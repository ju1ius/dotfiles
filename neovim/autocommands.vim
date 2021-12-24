" ===== Vim help mappings =====
augroup help_mappings
  autocmd!
  " <enter> to follow tag
  autocmd FileType help nnoremap <buffer><cr> <c-]>
  " <backspace> to gi back
  autocmd FileType help nnoremap <buffer><bs> <c-T>
  " <q> to quit
  autocmd FileType help nnoremap <buffer>q :q<CR>
  autocmd FileType help setlocal nonumber
augroup END

" ===== per filetype whitespace settings =====
augroup ft_tab_sizes
  autocmd!
  autocmd FileType php,python setlocal shiftwidth=4 softtabstop=4
  autocmd FileType make setlocal noexpandtab
augroup END

