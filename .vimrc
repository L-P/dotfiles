" Pathogen
" --------
let g:pathogen_disabled = []
if version < 703
    call add(g:pathogen_disabled, 'gitgutter')
    call add(g:pathogen_disabled, 'gundo')
endif
runtime bundle/vim-pathogen/autoload/pathogen.vim
call pathogen#infect()
