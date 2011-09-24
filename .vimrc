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

let mapleader=","
map <Leader>f :!fmt<CR>
map <Leader>c :!xclip -i; xclip -o<CR>

au FocusLost * :wa

filetype indent plugin on
nmap <F9> :w<CR> :make<CR><CR>

autocmd BufNewFile,BufRead *.{md,mkd,mkdn,mark*}	set filetype=markdown
autocmd BufNewFile,BufRead *.as						set filetype=actionscript

autocmd FileType php set errorformat=%m\ in\ %f\ on\ line\ %l
autocmd FileType php set makeprg=php\ -l\ %
autocmd FileType markdown set makeprg=markdown\ %\ >\ %<.html

set wildmode=list:longest,list:full
set wildmenu
set wildignore+=*.o,*.obj,.git,*.rbc,*.class,.svn,vendor/gems/,CVS*

nmap SQ <ESC>:mksession! /home/leo/.vim/Session.vim<CR>:wqa<CR>
function! RestoreSession()
	if argc() == 0 "vim called without arguments
		execute 'source ~/.vim/Session.vim'
	end
endfunction
autocmd VimEnter * call RestoreSession()

function ModeChange()
	if getline(1) =~ "^#!"
		if getline(1) =~ "/bin/"
			silent !chmod u+x <afile>
		endif
	endif
endfunction

au BufWritePost * call ModeChange()

