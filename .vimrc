if 1 " vim.tiny ignores conditionals, this is a vim.tiny check.
    let g:pathogen_disabled = []
    if version < 703
        call add(g:pathogen_disabled, 'gitgutter')
    endif

    runtime bundle/pathogen/autoload/pathogen.vim
    call pathogen#infect()
endif

" Manual loading of my configuration for vim.tiny.
runtime bundle/lpeltier/plugin/lpeltier.vim
