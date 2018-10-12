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
autocmd BufNewFile,BufRead *.js{m,on}         setlocal filetype=json equalprg=json_reformat
autocmd BufNewFile,BufRead *.babelrc          setlocal filetype=json equalprg=json_reformat
autocmd BufNewFile,BufRead *.md               setlocal filetype=markdown makeprg=markdown\ %\ >\ %<.html
autocmd BufNewFile,BufRead *.php{t,s}         setlocal filetype=php
autocmd BufNewFile,BufRead *.twig             setlocal filetype=html.twig
autocmd BufNewFile,BufRead *.{asm,s}          setlocal filetype=nasm
autocmd BufNewFile,BufRead *.{glsl,vert,frag} setlocal filetype=glsl
autocmd BufNewFile,BufRead *.{mail,txt}       setlocal filetype=mail
autocmd BufNewFile,BufRead .*shrc             setlocal filetype=sh
autocmd BufNewFile,BufRead CMakeLists.txt     setlocal filetype=cmake
autocmd BufNewFile,BufRead Vagrantfile        setlocal filetype=ruby

autocmd BufWritePost *.go call CompileGo()
autocmd BufWritePost *.tf silent !terraform fmt

" go build does not compile tests and running both go test and go build at the
" same time results un a disappearing quickfix buffer, select what command to
" run based on the filename.
function! CompileGo()
    if @% =~ "_test.go$"
        call go#test#Test(1, 0)
    else
        call go#cmd#Build(1)
    endif
endfunction


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

" Transparent encryption/decryption for ansible vaults
" ----------------------------------------------------
function! AnsibleVaultDecrypt()
    if getline(1) =~ '^\$ANSIBLE_VAULT;'
        silent :%!ansible-vault --vault-password-file=.vault decrypt - --output -
        let b:is_ansible_vault=1

        " The file is kept encrypted on file so any syntastic check will fail
        let b:syntastic_skip_checks = 1
        SyntasticReset
    else
        let b:is_ansible_vault=0
    endif
endfunction

function! AnsibleVaultEncrypt()
    if exists("b:is_ansible_vault") && b:is_ansible_vault
        silent :%!ansible-vault --vault-password-file=.vault encrypt - --output -
    endif
endfunction

function! AnsibleVaultAfterEncrypt()
    if exists("b:is_ansible_vault") && b:is_ansible_vault
        silent u
    endif
endfunction

autocmd BufNewFile   * call AnsibleVaultDecrypt()
autocmd BufReadPost  * call AnsibleVaultDecrypt()
autocmd BufWritePre  * call AnsibleVaultEncrypt()
autocmd BufWritePost * call AnsibleVaultAfterEncrypt()
