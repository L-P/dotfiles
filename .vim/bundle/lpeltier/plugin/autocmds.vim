if !has("autocmd")
    finish
endif

" Language-specific config
" ========================
autocmd FileType markdown   setlocal textwidth=79
autocmd FileType python     setlocal textwidth=79
autocmd FileType mail       setlocal equalprg=fmt textwidth=72
autocmd FileType yaml       setlocal shiftwidth=2 tabstop=2 softtabstop=2
autocmd FileType html       setlocal cursorcolumn

if version >= 703
    autocmd FileType mail      setlocal colorcolumn+=1
    autocmd FileType gitcommit setlocal colorcolumn+=1
endif

" Custom filetypes and options
autocmd BufNewFile,BufRead *.dockerfile       setlocal filetype=dockerfile
autocmd BufNewFile,BufRead Dockerfile.*       setlocal filetype=dockerfile
autocmd BufNewFile,BufRead *.js{m,on}         setlocal filetype=json equalprg=python\ -m\ json.tool
autocmd BufNewFile,BufRead *.php{t,s}         setlocal filetype=php
autocmd BufNewFile,BufRead *.{asm,s}          setlocal filetype=nasm
autocmd BufNewFile,BufRead *.{glsl,vert,frag} setlocal filetype=glsl
autocmd BufNewFile,BufRead *.{mail,txt}       setlocal filetype=mail
autocmd BufNewFile,BufRead .*shrc             setlocal filetype=sh
autocmd BufNewFile,BufRead CMakeLists.txt     setlocal filetype=cmake

autocmd BufWritePost *.tf silent !terraform fmt % &> /dev/null


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
    if (getline(1) =~ "^#!" || getline(1) =~ "^///") && getline(1) =~ "/bin/"
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
