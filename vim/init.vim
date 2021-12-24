
source ~/.vim/config/plugins.vim
source ~/.vim/config/general.vim
source ~/.vim/config/mappings.vim

" plugin configs
source ~/.vim/config/plugins/lightline.vim
source ~/.vim/config/plugins/nerdtree.vim
source ~/.vim/config/plugins/ultisnips.vim
source ~/.vim/config/plugins/ack.vim
source ~/.vim/config/plugins/fzf.vim
source ~/.vim/config/plugins/ale.vim
source ~/.vim/config/plugins/coc.vim
source ~/.vim/config/plugins/which-key.vim

" Emmet
"let g:user_emmet_leader_key = "<c-l>"

" vim-jsx
" .jsx extension shan't be required
let g:jsx_ext_required = 0

" so Emmet.vim will work in JSX
let g:user_emmet_settings = {
\  'javascript.jsx' : {
\      'extends': 'jsx',
\      'quote_char': '"',
\  },
\}

