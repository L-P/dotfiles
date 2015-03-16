if !has("autocmd")
    finish
endif

" Language-specific config
" ========================
autocmd FileType python set textwidth=79 expandtab
autocmd FileType mail set equalprg=fmt textwidth=72 expandtab
if version >= 703
    autocmd FileType mail      set colorcolumn+=1
    autocmd FileType gitcommit set colorcolumn+=1
endif

" Custom filetypes and options
autocmd BufNewFile,BufRead *.{md,mkd,mkdn,mark*} set filetype=markdown makeprg=markdown\ %\ >\ %<.html
autocmd BufNewFile,BufRead *.php{t,s}            set filetype=php
autocmd BufNewFile,BufRead *.tpl                 set filetype=php
autocmd BufNewFile,BufRead *.as                  set filetype=actionscript
autocmd BufNewFile,BufRead *.js{m,on}            set filetype=json syntax=javascript equalprg=json_reformat
autocmd BufNewFile,BufRead Vagrantfile           set filetype=ruby
autocmd BufNewFile,BufRead *.{mail,txt}          set filetype=mail
autocmd BufNewFile,BufRead *.{asm,s}             set filetype=nasm
autocmd BufNewFile,BufRead *.{yml}               set filetype=ansible


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
    endif
endfunction
autocmd BufWritePost * call ModeChange()
