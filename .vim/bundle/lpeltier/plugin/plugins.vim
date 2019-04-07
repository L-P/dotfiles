" Plugins config
" ==============
let g:airline_theme = 'wombat'

let g:ale_lint_on_text_changed='never'

" For markdown
let g:table_mode_corner="|"

" CtrlP params
" ------------
let g:ctrlp_cmd='CtrlPMixed'        " Search in all buffers/files
let g:ctrlp_working_path_mode = 'r' " Use vim working directory as ctrlp root.

" Use git to list repository files.
let g:ctrlp_user_command = ['.git', 'cd %s && git ls-files . -co --exclude-standard | grep -v "^vendor/"', 'find %s -type f']

" Only use cpsm if it's built.
if !empty(glob('~/.vim/bundle/cpsm/build/cpsm_py.so'))
    let g:ctrlp_match_func = {'match': 'cpsm#CtrlPMatch'}
endif

" Disable ALE for go as we already have vim-go
let g:ale_pattern_options = {'.*\.go$': {'ale_enabled': 0}}
