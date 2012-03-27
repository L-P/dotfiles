syntax on

set t_Co=256
set background=dark
colorscheme wombat256mod

set number
set showcmd
set ruler
set modelines=0
set autoindent
set tabstop=4
set shiftwidth=4
set softtabstop=4
set encoding=utf-8
set ignorecase
set smartcase
set mouse=a
set spelllang=fr
set spellsuggest=5
set pastetoggle=<F2>
set incsearch
set showmatch
set showmode
set scrolloff=3
set laststatus=2 " Always show statusline

" Persistant undo file, awesome when used with Gundo
set undofile
set undodir=~/.vim/undo



" Misc
filetype indent plugin on
let mapleader=","



" Mappings
nmap <F8> :GundoToggle<CR>
nmap <F9> :w<CR> :make<CR><CR>
nmap <F10> :TagbarToggle<CR>

" Reformats paragraphs.
map <Leader>f !fmt<CR>

" Color input
map <Leader>a i<CR><ESC>k:r!zenity --color-selection<CR>k3J

" Re-orders and formats the contents of a long array.
map <Leader>o vib:s/ /\r/g<CR>gv<vib:sort<CR>gv,fvib>gv:g/^$/d<CR>

" Use arrow keys to navigate in wrapped text
" http://www.reddit.com/r/vim/comments/lrqeb/what_keys_do_you_have_rebound_in_vim/c2v2phl
nnoremap <Up> gk
nnoremap <Down> gj
inoremap <Up> <C-O>gk
inoremap <Down> <C-O>gj

" Consistency
map Y y$

" Copy the current selection in X clipboard.
map <Leader>c :!xsel -iob<CR>u

" sudo save a file.
cmap w!! %!sudo tee > /dev/null %<CR>



" File types
autocmd BufNewFile,BufRead *.{md,mkd,mkdn,mark*}	set filetype=markdown
autocmd BufNewFile,BufRead *.phpt					set filetype=php
autocmd BufNewFile,BufRead *.as						set filetype=actionscript
autocmd BufNewFile,BufRead *.json					set syntax=javascript equalprg=json_reformat
autocmd FileType markdown	set makeprg=markdown\ %\ >\ %<.html



" VIM gone wild.
set wildmode=list:longest,list:full
set wildmenu
set wildignore+=*.o,*.obj,.git,*.rbc,*.class,.svn,vendor/gems/,CVS*



" Functions and stuff

" Session save/restore
nmap SQ <ESC>:mksession! .vimsession<CR>:wqa<CR>
function! RestoreSession()
	if argc() == 0 "vim called without arguments
		execute 'source .vimsession'
	end
endfunction
autocmd VimEnter * call RestoreSession()


" Sets +x automatically when writing a shell script.
function! ModeChange()
	if getline(1) =~ "^#!"
		if getline(1) =~ "/bin/"
			silent !chmod u+x <afile>
		endif
	endif
endfunction
au BufWritePost * call ModeChange()



" Syntastic params
let g:syntastic_enable_signs=1
let g:syntastic_echo_current_error=1
let g:syntastic_auto_loc_list=2
let g:syntastic_javascript_syntax_checker="jshint"

" Python-specific
autocmd FileType python set textwidth=79 expandtab


" JS Specific

" Only use smartindent to have proper JS semi-auto indenting.
autocmd FileType javascript setl noai nocin inde=
autocmd FileType javascript set smartindent


" PHP sweeteners

" Manual PHP syntax checking via :make
autocmd FileType php set errorformat=%m\ in\ %f\ on\ line\ %l makeprg=php\ -l\ %

" Lazyness
autocmd FileType php abbr prf protected function%() {<CR>}<CR><ESC>?%<CR>xi
autocmd FileType php abbr puf public function%() {<CR>}<CR><ESC>?%<CR>xi

" Dump local PHP variables (names, name=>contents).
autocmd FileType php abbr dlv var_dump(array_keys(get_defined_vars()),
			\ compact(array_keys(get_defined_vars())));<CR>die();

