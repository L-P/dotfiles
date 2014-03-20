if !has("autocmd")
    finish
endif

" Language-specific config
" ========================
autocmd FileType gitcommit set colorcolumn=+1
autocmd FileType python set textwidth=79 expandtab

" Custom filetypes and options
autocmd BufNewFile,BufRead *.{md,mkd,mkdn,mark*} set filetype=markdown makeprg=markdown\ %\ >\ %<.html
autocmd BufNewFile,BufRead *.php{t,s}            set filetype=php
autocmd BufNewFile,BufRead *.as                  set filetype=actionscript
autocmd BufNewFile,BufRead *.js{m,on}            set filetype=json syntax=javascript equalprg=json_reformat
autocmd BufNewFile,BufRead *.mail                set filetype=mail equalprg=fmt textwidth=72 cc=+1 expandtab
autocmd BufNewFile,BufRead *.txt                 set filetype=mail equalprg=fmt textwidth=72 cc=+1 expandtab
autocmd BufNewFile,BufRead Vagrantfile           set filetype=ruby


" Misc functions
" ==============
" Highlight trailing spaces.
" --------------------------
highlight ExtraWhitespace ctermbg=darkred
match ExtraWhitespace /\s\+$/
autocmd BufWinEnter * match ExtraWhitespace /\s\+$/
autocmd InsertEnter * match ExtraWhitespace /\s\+\%#\@<!$/
autocmd InsertLeave * match ExtraWhitespace /\s\+$/
autocmd BufWinLeave * call clearmatches()

" Highlight code over the 110th column (hard-limit)
" -------------------------------------------------
autocmd BufWinEnter * let w:m1=matchadd('ErrorMsg', '\%>110v.\+', -1)

" Set +x automatically when writing a shell script
" ------------------------------------------------
function! ModeChange()
    if getline(1) =~ "^#!" && getline(1) =~ "/bin/"
        silent !chmod u+x <afile>
        e!
    endif
endfunction
autocmd BufWritePost * call ModeChange()
