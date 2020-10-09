" Use The Silver Searcher if available for ack.vim
if executable('ag')
  let g:ackprg = 'ag --vimgrep'
endif


