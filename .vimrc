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
set scrolloff=3         " Force-scroll 3 lines before/after the cursor
set laststatus=2        " Always show statusline
set textwidth=79        " Soft-limit of 79 chars
set colorcolumn=80      " Highlight the 80th column
set nowrap              " Disable text-wrapping
set splitright          " Open new splits on the right
set splitbelow          " Open new splits on the bottom
set exrc                " Per-directory .vimrc.
set secure              " Disallow unsafe commands in per-directory .vimrc files.


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
let mapleader="," " \ is difficult to type on azerty keyboards

" Browse ctags
nnoremap <Leader><C-P> :CtrlPTag<CR>

" gitsessions.vim
nnoremap <Leader>ss :GitSessionSave<CR>
nnoremap <Leader>ds :GitSessionDelete<CR>

" Toggle Gundo window
noremap <F8> :GundoToggle<CR>

" F9 to save and build
noremap <F9> :wa<CR> :!clear<CR> :make<CR>

" For consistency
noremap Y y$

" Disable Ex mode.
noremap Q <Nop>

" Use arrow keys to navigate in wrapped text
" http://www.reddit.com/r/vim/comments/lrqeb/what_keys_do_you_have_rebound_in_vim/c2v2phl
nnoremap <Up> gk
nnoremap <Down> gj
inoremap <Up> <C-O>gk
inoremap <Down> <C-O>gj

" Copy the current selection in X clipboard, useful when vim is compiled
" without + and * registers support.
noremap <Leader>c :!xsel -iob<CR>u

" Align multiple columns of text, useful for multiple var assignments
vnoremap <Leader>a :!column -t<CR>gv=

" sudo save a file.
cnoremap w!! %!sudo tee > /dev/null %<CR>


" Shiny path autocomplete
set wildmode=list:longest,list:full
set wildmenu
set wildignore+=*.o,*.obj,.git,*.rbc,*.class,.svn,vendor/gems/,CVS*,*.pyc

" Per-filetype options
autocmd BufNewFile,BufRead *.{md,mkd,mkdn,mark*} set filetype=markdown makeprg=markdown\ %\ >\ %<.html
autocmd BufNewFile,BufRead *.php{t,s}            set filetype=php
autocmd BufNewFile,BufRead *.as                  set filetype=actionscript
autocmd BufNewFile,BufRead *.js{m,on}            set filetype=json syntax=javascript equalprg=json_reformat
autocmd BufNewFile,BufRead *.mail                set filetype=mail equalprg=fmt textwidth=72 cc=+1 expandtab
autocmd BufNewFile,BufRead *.txt                 set filetype=mail equalprg=fmt textwidth=72 cc=+1 expandtab
autocmd BufNewFile,BufRead *.{c,h}{,pp}          set equalprg=

" Misc functions
" ==============
" Sets +x automatically when writing a shell script.
function! ModeChange()
    if getline(1) =~ "^#!" && getline(1) =~ "/bin/"
        silent !chmod u+x <afile>
    endif
endfunction
au BufWritePost * call ModeChange()



" Plugins config
" ==============
" Airline
" -------
let g:airline_theme = 'wombat'

" Syntastic
" ---------
let g:syntastic_enable_signs=1                      " Use VIM signs to show errors
let g:syntastic_echo_current_error=1                " Display current error in statusline
let g:syntastic_javascript_checkers=["jshint"]      " Use jshint instead of jslint
let g:syntastic_python_checkers=["python", "pyflakes"]
let g:syntastic_auto_loc_list=1                     " lopen/lclose automatically

" CtrlP params
" ------------
let g:ctrlp_cmd='CtrlPMixed'    " Search in all buffers/files
let g:ctrlp_mruf_max=0          " Disable MRU so CtrlPMixed only searches for buffers and files.
let g:ctrlp_working_path_mode=0 " Use vim working directory as ctrlp root.


" Language-specific config
" ========================
" Git commits
" -----------
" Highlight the right column.
autocmd FileType gitcommit set colorcolumn=+1


" C / C++
" ------
" Documentation via K, see scripts/c_doc.sh
autocmd FileType c   set keywordprg=c_doc
autocmd FileType cpp set keywordprg=c_doc
autocmd FileType c   set nofoldenable
autocmd FileType c   set foldmethod=syntax


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


" PHP
" ---
" Syntax file options
let php_parent_error_close=1
let php_parent_error_open=1

" Documentation via K, see scripts/php_doc.sh
autocmd FileType php set keywordprg=php_doc

" Update control structures to PSR whitespacing.
autocmd FileType php noremap <Leader>p :%s/\(if\\|for\\|foreach\\|while\)(/\1 (/ge<CR>
			\:%s/\(function\\|class\) \(.*\) {/\1 \2\r{/e<CR>

" Re-orders and formats the contents of a long PHP array.
autocmd FileType php noremap <Leader>o vib<gv:s/, /,\r/g<CR>vib:sort<CR>gvJgqq>ibgv:s/ $//<CR>

" Method declaration abbreviations
autocmd FileType php abbr prf protected function%() {<CR>}<CR><ESC>?%<CR>xi
autocmd FileType php abbr puf public function%() {<CR>}<CR><ESC>?%<CR>xi

" Wrap with <?= _('%') ?>
autocmd FileType php vnoremap <Leader>gt A') ?><ESC>gvI<?= _('<ESC>

" Dump local PHP variables (names, name=>contents).
autocmd FileType php abbr dlv {<CR>$locals = get_defined_vars();<CR>
            \$buffers = array(); while(ob_get_level()) $buffers[] = ob_get_clean();<CR>
            \$buffers = array_filter($buffers) ?: null;<CR>
            \header('Content-Type: text/html; charset=UTF-8');<CR>
            \var_dump(array_keys($locals), $locals, compact('buffers'));<CR>
            \function_exists('xdebug_print_function_stack') AND xdebug_print_function_stack();<CR>
            \die();<CR>}<ESC>^v%J^

" Like dlv but dumps JSON.
autocmd FileType php abbr djv {<CR>$locals = get_defined_vars();<CR>
            \(PHP_SAPI === 'cli') OR header('Content-Type: application/json');<CR>
            \echo json_encode(array(array_keys($locals), $locals));<CR>
            \die();<CR>}<ESC>^v%J^
