if !has("autocmd")
    finish
endif

" Language-specific config
" ========================
autocmd FileType markdown   setlocal textwidth=79
autocmd FileType python     setlocal textwidth=79
autocmd FileType mail       setlocal equalprg=fmt textwidth=72

if version >= 703
    autocmd FileType mail      setlocal colorcolumn+=1
    autocmd FileType gitcommit setlocal colorcolumn+=1
endif

" Custom filetypes and options
autocmd BufNewFile,BufRead *.md         setlocal filetype=markdown makeprg=markdown\ %\ >\ %<.html
autocmd BufNewFile,BufRead *.php{t,s}   setlocal filetype=php
autocmd BufNewFile,BufRead *.js{m,on}   setlocal filetype=json syntax=javascript equalprg=json_reformat
autocmd BufNewFile,BufRead Vagrantfile  setlocal filetype=ruby
autocmd BufNewFile,BufRead *.{mail,txt} setlocal filetype=mail
autocmd BufNewFile,BufRead *.{asm,s}    setlocal filetype=nasm
autocmd BufNewFile,BufRead .*shrc       setlocal filetype=sh


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
