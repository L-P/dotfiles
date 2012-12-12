" General settings
" ============
syntax on
filetype indent plugin on

" Pathogen
" --------
runtime bundle/vim-pathogen/autoload/pathogen.vim
call pathogen#infect()

" Setting up colorscheme
" ----------------------
set t_Co=256
set background=dark
colorscheme wombat256

" Misc options
" ------------
set number              " Line numbering
set showcmd             " Show the command being typed
set ruler               " Show the cursor position
set autoindent          " Use automatic indent
set expandtab           " tabs will be replaced by spaces
set tabstop=4           " 1 tab = 4 spaces
set shiftwidth=4        " 1 tab = 4 spaces
set softtabstop=4       " 1 tab = 4 spaces
set encoding=utf-8      " Unicode über alles
set ignorecase          " See smartcase
set smartcase           " Do case-insensitive searches if the pattern is lowercase
set mouse=a             " Shame on me
set spelllang=fr        " Use French for spellcheck
set spellsuggest=5      " Limit spelling suggestions list to 5 entries
set pastetoggle=<F2>    " Use F2 to toggle paste mode
set incsearch           " Jump to the next search result while still typing
set showmatch           " Highlight matching opening bracket when inserting '}'
set showmode            " Display the current mode (insert/normal/visual/etc.)
set scrolloff=3         " Force-scoll 3 lines before/after the cursor
set laststatus=2        " Always show statusline
set colorcolumn=81      " Highlight the 81th column (code soft-limit of 80 chars)


" Highlight trailing spaces.
highlight ExtraWhitespace ctermbg=darkred
match ExtraWhitespace /\s\+$/
autocmd BufWinEnter * match ExtraWhitespace /\s\+$/
autocmd InsertEnter * match ExtraWhitespace /\s\+\%#\@<!$/
autocmd InsertLeave * match ExtraWhitespace /\s\+$/
autocmd BufWinLeave * call clearmatches()

" Highlight code over the 110th column (hard-limit).
autocmd BufWinEnter * let w:m1=matchadd('ErrorMsg', '\%>110v.\+', -1)

" Persistant undo across sessions
" -------------------------------
set undofile
set undodir=~/.vim/undo


" Mappings
" --------
let mapleader=","                   " \ is difficult to type on azerty keyboards
noremap <F7> :NERDTreeToggle<CR>    " Toggle NERDTreee
noremap <F8> :GundoToggle<CR>       " Toggle Gundo window
noremap <F9> :wa<CR> :make<CR><CR>  " F9 to save and build
noremap <F10> :TagbarToggle<CR>     " Toggle tagbar window
noremap <Leader>f !fmt<CR>          " Sometimes fmt does a better job than vim's 'gqq'
noremap Y y$                        " For consistency
noremap Q                         " Disable Ex mode, <Nop> won't work so I used ^V^V

" Decode quoted-printable encoded mails.
" http://vim.wikia.com/wiki/Quoted_Printable_to_Plain
nnoremap <Leader>Q :%s/=\(\x\x\<BAR>\n\)/\=submatch(1)=='\n'?'':nr2char('0x'.submatch(1))/ge<CR>
vnoremap <Leader>Q :s/=\(\x\x\<BAR>\n\)/\=submatch(1)=='\n'?'':nr2char('0x'.submatch(1))/ge<CR>

" Print serialized PHP data as JSON.
noremap <Leader>s ggdG:r !php -r 'echo json_encode(unserialize(file_get_contents("%")));'<CR>ggdd
            \:set equalprg=json_reformat ft=json syntax=javascript<CR>=G

" Use arrow keys to navigate in wrapped text
" http://www.reddit.com/r/vim/comments/lrqeb/what_keys_do_you_have_rebound_in_vim/c2v2phl
nnoremap <Up> gk
nnoremap <Down> gj
inoremap <Up> <C-O>gk
inoremap <Down> <C-O>gj

" Copy the current selection in X clipboard, useful when vim is compiled
" without + and * registers support.
noremap <Leader>c :!xsel -iob<CR>u
noremap <Leader>t :!ctags -R &<CR> !silent

" sudo save a file.
cnoremap w!! %!sudo tee > /dev/null %<CR>


" Shiny path autocomplete
set wildmode=list:longest,list:full
set wildmenu
set wildignore+=*.o,*.obj,.git,*.rbc,*.class,.svn,vendor/gems/,CVS*,*.pyc

" Per-filetype options
autocmd BufNewFile,BufRead *.{md,mkd,mkdn,mark*} set filetype=markdown textwidth=80 makeprg=markdown\ %\ >\ %<.html
autocmd BufNewFile,BufRead *.php{t,s}            set filetype=php
autocmd BufNewFile,BufRead *.as                  set filetype=actionscript
autocmd BufNewFile,BufRead *.json                set filetype=json syntax=javascript equalprg=json_reformat
autocmd BufNewFile,BufRead *.mail                set filetype=mail equalprg=fmt textwidth=72 cc=+1 expandtab
autocmd BufNewFile,BufRead *.txt                 set filetype=mail equalprg=fmt textwidth=72 cc=+1 expandtab

" Misc functions
" ==============
" Session save/restore
nnoremap SQ <ESC>:mksession! .vimsession<CR>:wqa<CR>
function! RestoreSession()
    if argc() == 0 && filereadable('.vimsession')
        execute 'source .vimsession'
    end
endfunction
autocmd VimEnter * call RestoreSession()


" Sets +x automatically when writing a shell script.
function! ModeChange()
    if getline(1) =~ "^#!" && getline(1) =~ "/bin/"
        silent !chmod u+x <afile>
    endif
endfunction
au BufWritePost * call ModeChange()



" Plugins config
" ==============
" Syntastic
" ---------
let g:syntastic_enable_signs=1                      " Use VIM signs to show errors
let g:syntastic_echo_current_error=1                " Display current error in statusline
let g:syntastic_auto_loc_list=1                     " Auto open/close the location list for errors
let g:syntastic_javascript_syntax_checker="jshint"  " Use jshint instead of jslint

" CtrlP params
" ------------
let g:ctrlp_cmd='CtrlPMixed'    " Search in all buffers/files
let g:ctrlp_by_filename=1       " Search by filename instad of path
let g:ctrlp_mruf_max=0          " Disable MRU so CtrlPMixed only searches for buffers and files.
let g:ctrlp_working_path_mode=0 " Use vim working directory as ctrlp root.


" Language-specific config
" ========================
" Git commits
" -----------
" Highlight the right column.
autocmd FileType gitcommit set colorcolumn=+1


" Python
" ------
" Follow PEP8 recommandations by using space-indented 79 chars lines.
autocmd FileType python set textwidth=79 expandtab


" Javascript
" ----------
" Only use smartindent to have proper JS semi-auto indenting.
autocmd FileType javascript setl noai nocin inde=
autocmd FileType javascript set smartindent
autocmd FileType javascript abbr clog console.log(%);<CR><ESC>?%<CR>xi


" CSS/LESS
" --------
" Color picker for quick color insertion when working with CSS
autocmd FileType css,less noremap <Leader>a i<CR><ESC>k:r!zenity --color-selection<CR>k3J

" Expand and fold CSS rules (for one-lined CSS files)
autocmd FileType css,less noremap <Leader>ce ^f{lr<CR><ESC>f}hr<CR><ESC>k:s/;/;\r/g<CR>viB=gv:sort<CR>gv:g/^$/d<CR>
autocmd FileType css,less noremap <Leader>cf viBJkVjjJ


" PHP
" ---
" Documentation via K, see scripts/php_doc.sh
autocmd FileType php set keywordprg=php_doc

" Re-orders and formats the contents of a long PHP array.
autocmd FileType php noremap <Leader>o vib<gv:s/, /,\r/g<CR>vib:sort<CR>gvJgqq>ibgv:s/ $//<CR>

" Manual PHP syntax checking via :make
autocmd FileType php set errorformat=%m\ in\ %f\ on\ line\ %l makeprg=php\ -l\ %

" Method declaration abbreviations
autocmd FileType php abbr prf protected function%() {<CR>}<CR><ESC>?%<CR>xi
autocmd FileType php abbr puf public function%() {<CR>}<CR><ESC>?%<CR>xi

" Dump local PHP variables (names, name=>contents).
autocmd FileType php abbr dlv {<CR>$locals = get_defined_vars();<CR>
            \$buffers = array(); while(ob_get_level()) $buffers[] = ob_get_clean();<CR>
            \$buffers = array_filter($buffers) ?: null;<CR>
            \header('Content-Type: text/html; charset=UTF-8');<CR>
            \var_dump(array_keys($locals), compact(array_keys($locals)), compact('buffers'));<CR>
            \function_exists('xdebug_print_function_stack') AND xdebug_print_function_stack();<CR>
            \die();<CR>}<ESC>>aB

autocmd FileType php abbr djv {<CR>$locals = get_defined_vars();<CR>
            \(PHP_SAPI === 'cli') OR header('Content-Type: application/json');<CR>
            \echo json_encode(array(array_keys($locals), compact(array_keys($locals))));<CR>
            \die();<CR>}<ESC>>aB

" Lorem ipsum abbreviation
autocmd FileType php abbr lorem Lorem ipsum dolor sit amet, consectetur adipiscing elit. Nulla
            \scelerisque felis non mauris commodo congue. Mauris eu lobortis erat.
            \ Phasellus varius vulputate convallis. Nam in urna mi. Nulla ligula purus,
            \adipiscing a eleifend at, scelerisque ac lacus. Phasellus ut ipsum ante.
            \ Vivamus eget metus augue. Fusce vel commodo orci. Praesent id ligula eget ante
            \accumsan aliquam. Aliquam varius pulvinar lorem, id accumsan enim ornare quis.
            \ Integer aliquam metus nec sapien mollis et rutrum quam malesuada. Donec in
            \sapien quis eros condimentum placerat vitae ut nisl. Ut ornare varius leo, eu
            \euismod tortor elementum ut. Suspendisse ornare, velit sed blandit faucibus,
            \dui neque elementum justo, sit amet pellentesque tellus lacus quis ante. Donec
            \cursus dapibus sollicitudin.
