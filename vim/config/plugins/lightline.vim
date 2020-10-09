" No need to show current mode since we have lightline
set noshowmode

let g:lightline = {
\  'colorscheme': 'onedark',
\}
" maximbaz/lightline-ale
let g:lightline#ale#indicator_ok = '✔'
let g:lightline#ale#indicator_warning = '⚠'
let g:lightline#ale#indicator_error = '❌'
let g:lightline.component_expand = {
\  'linter_warnings': 'lightline#ale#warnings',
\  'linter_errors': 'lightline#ale#errors',
\  'linter_ok': 'lightline#ale#ok',
\  'git': 'fugitive#statusline',
\}
let g:lightline.component_type = {
\  'linter_warnings': 'warning',
\  'linter_errors': 'error',
\}
let g:lightline.active = {
\  'left': [
\    [ 'mode', 'paste' ],
\    [ 'git' ],
\    [ 'linter_errors', 'linter_warnings', 'linter_ok' ],
\  ],
\  'right': [
\    [ 'filename' ],
\    [ 'lineinfo' ],
\    [ 'modified', 'readonly', 'filetype' ],
\  ],
\}


