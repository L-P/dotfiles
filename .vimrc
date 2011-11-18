set nocompatible
syntax on
set background=dark
set guifont=Inconsolata\ Medium\ 12
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
set ttyfast
set lazyredraw
set spelllang=fr
set spellsuggest=5
set pastetoggle=<F2>
set incsearch
set showmatch
set showmode
set undofile
set undodir=/var/tmp/vim

" Misc
let mapleader=","
au FocusLost * :wa
filetype indent plugin on
nmap <F8> :GundoToggle<CR>
nmap <F9> :w<CR> :make<CR><CR>
nmap <F10> :TagbarToggle<CR>
map <Leader>f :!fmt<CR>

" Use arrow keys to navigate in wrapped text
" http://www.reddit.com/r/vim/comments/lrqeb/what_keys_do_you_have_rebound_in_vim/c2v2phl
nnoremap <Up> gk
nnoremap <Down> gj
inoremap <Up> <C-O>gk
inoremap <Down> <C-O>gj

" Copy the current selection in X clipboard.
map <Leader>c :!xsel -iob<CR>u


" File types
autocmd BufNewFile,BufRead *.{md,mkd,mkdn,mark*}	set filetype=markdown
autocmd BufNewFile,BufRead *.as						set filetype=actionscript
autocmd BufNewFile,BufRead *.json					set filetype=javascript equalprg=json_reformat
autocmd FileType markdown	set makeprg=markdown\ %\ >\ %<.html


" VIM gone wild.
set wildmode=list:longest,list:full
set wildmenu
set wildignore+=*.o,*.obj,.git,*.rbc,*.class,.svn,vendor/gems/,CVS*


" Session save/restore
nmap SQ <ESC>:mksession! .vimsession<CR>:wqa<CR>
function! RestoreSession()
	if argc() == 0 "vim called without arguments
		execute 'source .vimsession'
	end
endfunction

autocmd VimEnter * call RestoreSession()

" Sets +x automatically when writing a shell script.
function ModeChange()
	if getline(1) =~ "^#!"
		if getline(1) =~ "/bin/"
			silent !chmod u+x <afile>
		endif
	endif
endfunction
au BufWritePost * call ModeChange()


" Syntax checking
let g:syntastic_enable_signs=1


" Manual PHP syntax checking via :make
autocmd FileType php set errorformat=%m\ in\ %f\ on\ line\ %l
autocmd FileType php set makeprg=php\ -l\ %

" sudo save a file.
cmap w!! %!sudo tee > /dev/null %<CR>

" Abbreviations
abbr prf protected function%() {<CR>}<CR><ESC>?%<CR>xi
abbr puf public function%() {<CR>}<CR><ESC>?%<CR>xi

