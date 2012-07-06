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
set scrolloff=3         " Force-scoll 3 lines before/after the cursor.
set laststatus=2        " Always show statusline

" Persistant undo across sessions
" -------------------------------
set undofile
set undodir=~/.vim/undo


" Mappings
" --------
let mapleader=","               " \ is difficult to type on azerty keyboards
noremap <F8> :GundoToggle<CR>      " Toggle Gundo window
noremap <F9> :wa<CR> :make<CR><CR> " F9 to save and build
noremap <F10> :TagbarToggle<CR>    " Toggle tagbar window
noremap <Leader>f !fmt<CR>          " Sometimes fmt does a better job than vim's 'gqq'
noremap Y y$						" For consistency
noremap Q 						" Disable Ex mode, <Nop> won't work so I used ^V^V

" Decode quoted-printable encoded mails.
" http://vim.wikia.com/wiki/Quoted_Printable_to_Plain
nnoremap <Leader>Q :%s/=\(\x\x\<BAR>\n\)/\=submatch(1)=='\n'?'':nr2char('0x'.submatch(1))/ge<CR>
vnoremap <Leader>Q :s/=\(\x\x\<BAR>\n\)/\=submatch(1)=='\n'?'':nr2char('0x'.submatch(1))/ge<CR>

" Use arrow keys to navigate in wrapped text
" http://www.reddit.com/r/vim/comments/lrqeb/what_keys_do_you_have_rebound_in_vim/c2v2phl
nnoremap <Up> gk
nnoremap <Down> gj
inoremap <Up> <C-O>gk
inoremap <Down> <C-O>gj

" Copy the current selection in X clipboard, useful when vim is compiled
" without + and * registers support.
noremap <Leader>c :!xsel -iob<CR>u

" sudo save a file.
cnoremap w!! %!sudo tee > /dev/null %<CR>


" Shiny path autocomplete
set wildmode=list:longest,list:full
set wildmenu
set wildignore+=*.o,*.obj,.git,*.rbc,*.class,.svn,vendor/gems/,CVS*

" Per-filetype options
autocmd BufNewFile,BufRead *.{md,mkd,mkdn,mark*} set filetype=markdown makeprg=markdown\ %\ >\ %<.html
autocmd BufNewFile,BufRead *.php{t,s}            set filetype=php
autocmd BufNewFile,BufRead *.as                  set filetype=actionscript
autocmd BufNewFile,BufRead *.json                set filetype=json syntax=javascript equalprg=json_reformat
autocmd BufNewFile,BufRead *.mail                set filetype=mail equalprg=fmt textwidth=75 expandtab


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
let g:syntastic_enable_signs=1						" Use VIM signs to show errors
let g:syntastic_echo_current_error=1				" Display current error in statusline
let g:syntastic_auto_loc_list=2
let g:syntastic_javascript_syntax_checker="jshint"	" Use jshint instead of jslint

" CtrlP params
" ------------
let g:ctrlp_cmd='CtrlPMixed' " Search in all buffers/files
let g:ctrlp_by_filename=1 " Search by filename instad of path


" Language-specific config
" ========================
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
autocmd FileType php noremap <Leader>o vib:s/ /\r/g<CR>gv<vib:sort<CR>gv,fvib>gv:g/^$/d<CR>

" Manual PHP syntax checking via :make
autocmd FileType php set errorformat=%m\ in\ %f\ on\ line\ %l makeprg=php\ -l\ %

" Method declaration abbreviations
autocmd FileType php abbr prf protected function%() {<CR>}<CR><ESC>?%<CR>xi
autocmd FileType php abbr puf public function%() {<CR>}<CR><ESC>?%<CR>xi

" Dump local PHP variables (names, name=>contents).
autocmd FileType php abbr dlv {<CR>ob_end_clean();<CR>
			\var_dump(array_keys(get_defined_vars()),
			\ compact(array_keys(get_defined_vars())));<CR>die();<CR>}

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

