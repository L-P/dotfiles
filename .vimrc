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

" Misc
let mapleader=","
au FocusLost * :wa
filetype indent plugin on
nmap <F9> :w<CR> :make<CR><CR>
map <Leader>f :!fmt<CR>

" Copy the current selection in X clipboard.
map <Leader>c :!xclip -i; xclip -o<CR>u


" File types
autocmd BufNewFile,BufRead *.{md,mkd,mkdn,mark*}	set filetype=markdown
autocmd BufNewFile,BufRead *.as						set filetype=actionscript
autocmd FileType markdown set makeprg=markdown\ %\ >\ %<.html


" VIM gone wild.
set wildmode=list:longest,list:full
set wildmenu
set wildignore+=*.o,*.obj,.git,*.rbc,*.class,.svn,vendor/gems/,CVS*


" Session save/restore
nmap SQ <ESC>:mksession! /home/leo/.vim/Session.vim<CR>:wqa<CR>
function! RestoreSession()
	if argc() == 0 "vim called without arguments
		execute 'source ~/.vim/Session.vim'
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
cmap w!! %!sudo tee > /dev/null %

