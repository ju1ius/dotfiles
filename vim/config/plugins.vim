" auto-install vim-plug
if empty(glob('~/.vim/autoload/plug.vim'))
  silent !curl -fLo ~/.vim/autoload/plug.vim --create-dirs
    \ https://raw.githubusercontent.com/junegunn/vim-plug/0.11.0/plug.vim
  autocmd VimEnter * PlugInstall --sync | source $MYVIMRC
endif

call plug#begin('~/.vim/plugged')

" ----- Colors
Plug 'joshdick/onedark.vim'
Plug 'ryanoasis/vim-devicons'
" ----- Statusline
Plug 'itchyny/lightline.vim'
" ----- Explorer
Plug 'scrooloose/nerdtree'

Plug 'tpope/vim-sensible'
Plug 'tpope/vim-repeat'
Plug 'tpope/vim-surround'
Plug 'tpope/vim-commentary'
Plug 'christoomey/vim-system-copy'
" ------- Pairs
" Auto closes pairs (see also the lexima plugin for an alternative)
Plug 'jiangmiao/auto-pairs'
" Smart selection inside pairs (vv, then v to expand or Ctrl+Shift+v to reduce)
Plug 'gorkunov/smartpairs.vim'

Plug 'liuchengxu/vim-which-key'
Plug 'junegunn/fzf',  {'dir': '~/bin/fzf', 'do': './install --all'} | Plug 'junegunn/fzf.vim'
Plug 'airblade/vim-rooter'

" ----- VCS
Plug 'tpope/vim-fugitive'
Plug 'Xuyuanp/nerdtree-git-plugin'
if has('signs')
  Plug 'airblade/vim-gitgutter'
endif

" ----- Programming languages related
Plug 'editorconfig/editorconfig-vim'
Plug 'sheerun/vim-polyglot'
if has('nvim') || version >= 800
  Plug 'w0rp/ale'
  Plug 'maximbaz/lightline-ale'
  Plug 'neoclide/coc.nvim', {'branch': 'release'}
endif

if has('python3')
  Plug 'SirVer/ultisnips' | Plug 'honza/vim-snippets'
endif

call plug#end()


" Automatically install missing plugins on startup
autocmd VimEnter *
  \ if len(filter(values(g:plugs), '!isdirectory(v:val.dir)'))
  \|   PlugInstall --sync | q
  \| endif
