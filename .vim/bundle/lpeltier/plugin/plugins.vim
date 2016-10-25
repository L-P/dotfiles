" Plugins config
" ==============
" Misc
" -------
let g:airline_theme = 'wombat'
" For markdown
let g:table_mode_corner="|"

" Syntastic
" ---------
let g:syntastic_enable_signs = 1                      " Use VIM signs to show errors
let g:syntastic_echo_current_error = 1                " Display current error in statusline
let g:syntastic_auto_loc_list = 1                     " lopen/lclose automatically
let g:syntastic_javascript_checkers = ["eslint"]
let g:syntastic_python_checkers = ["python", "pyflakes", "pylint"]
let g:syntastic_yaml_checkers = ["yamllint"]
let g:syntastic_json_checkers = ["jsonlint"]
let g:syntastic_php_phpcs_args='--standard=PSR2'

" CtrlP params
" ------------
let g:ctrlp_cmd='CtrlPMixed'      " Search in all buffers/files
let g:ctrlp_mruf_max = 0          " Disable MRU so CtrlPMixed only searches for buffers and files.
let g:ctrlp_working_path_mode = 0 " Use vim working directory as ctrlp root.
let g:syntastic_filetype_map = { "ansible": "yaml" }

" Use git to list repository files.
let g:ctrlp_user_command = ['.git', 'cd %s && git ls-files . -co --exclude-standard', 'find %s -type f']

" Only use cpsm if it's built.
if !empty(glob('~/.vim/bundle/cpsm/build/cpsm_py.so'))
    let g:ctrlp_match_func = {'match': 'cpsm#CtrlPMatch'}
endif
