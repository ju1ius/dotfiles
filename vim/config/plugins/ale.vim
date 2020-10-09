"let g:airline#extensions#ale#enabled = 1
"let g:ale_lint_on_save = 1
"let g:ale_lint_on_text_changed = 0
"let g:ale_fix_on_save = 1

nmap <silent> <C-j> <Plug>(ale_next_wrap)
nmap <silent> <C-k> <Plug>(ale_previous_wrap)

let g:ale_linters = {
\   'javascript': ['eslint'],
\}
let g:ale_fixers = {
\   'javascript': ['prettier'],
\}
let g:ale_javascript_prettier_options = '--no-semi --single-quote --trailing-comma es5 --no-bracket-spacing'
let g:ale_javascript_prettier_use_local_config = 1
