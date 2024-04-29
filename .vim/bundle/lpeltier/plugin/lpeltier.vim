" General settings
" ============
if has("syntax")
    syntax on
    filetype indent plugin on
endif

" Setting up colorscheme
" ----------------------
set background=dark
set guifont=Inconsolata\ Medium\ 16

" TERM == linux means it's a 8 color TTY
if $TERM != "linux"
    set t_Co=256
    colorscheme wombat256
else
    colorscheme wombat
endif

" Misc options
" ------------
set autoindent          " Use automatic indent
set autoread            " Auto-reload files when changed externally
set clipboard=unnamed   " X clipboard as default yank register
set colorcolumn=80      " Highlight the 80th column
set encoding=utf-8      " Unicode über alles
set expandtab           " tabs will be replaced by spaces
set exrc                " Per-directory .vimrc
set ignorecase          " See smartcase
set incsearch           " Jump to the next search result while still typing
set laststatus=2        " Always show statusline
set lazyredraw          " Mostly for speeding up scrolling
set list                " Show non-breaking spaces
set listchars=tab:\ \ ,nbsp:␣
set nohlsearch          " Don't highlight search results. (nvim default)
set nowrap              " Disable text-wrapping
set nrformats-=octal    " Parse 0\d+ numbers as decimal when using ^A and ^X
set number              " Line numbering for the current line
set pastetoggle=<F2>    " Use F2 to toggle paste mode
set relativenumber      " Relative line numbering
set ruler               " Show the cursor position
set scrolloff=3         " Force-scroll 3 lines before/after the cursor
set secure              " Disallow unsafe commands in per-directory .vimrc files
set shiftwidth=4        " 1 tab = 4 spaces
set showcmd             " Show the command being typed
set showmatch           " Highlight matching opening bracket when inserting '}'
set showmode            " Display the current mode (insert/normal/visual/etc.)
set sidescrolloff=5     " Force-scroll 5 chars before/after the cursor
set smartcase           " Do case-insensitive searches if the pattern is lowercase
set softtabstop=4       " 1 tab = 4 spaces
set spelllang=fr
set spellsuggest=5      " Limit spelling suggestions list to 5 entries
set splitbelow          " Open new horizontal splits on the bottom
set splitright          " Open new vertical splits on the right
set tabstop=4           " 1 tab = 4 spaces
set undodir=~/.vim/undo
set undofile            " Persistant undo across sessions
set backupcopy=yes      " Allow writing to Docker file mounts without breaking them.

" Mappings
" --------
" \ is difficult to type on azerty keyboards
let mapleader=" "

nnoremap <C-P> :GFiles<CR>
" Browse ctags
nnoremap <Leader><C-P> :Tags<CR>
nnoremap <F8> :UndotreeToggle<CR>

" gitsessions.vim
nnoremap <Leader>ls :GitSessionLoad<CR>
nnoremap <Leader>ss :GitSessionSave<CR>
nnoremap <Leader>ds :GitSessionDelete<CR>

" sort current Block
nnoremap <Leader>sb {jv}k:sort<CR>
nnoremap <Leader>si vib:sort<CR>

" Open/create file in same directory (Create Sibling)
nnoremap <Leader>cs :e %:h/

" For consistency
noremap Y y$

" Disable Ex mode
noremap Q <Nop>

" Disable external help
noremap K <Nop>

" Visually select last inserted text
noremap gV `[v`]

" Use arrow keys to navigate in wrapped text
" http://www.reddit.com/r/vim/comments/lrqeb/what_keys_do_you_have_rebound_in_vim/c2v2phl
nnoremap <Up> gk
nnoremap <Down> gj
inoremap <Up> <C-O>gk
inoremap <Down> <C-O>gj

" Copy the current selection in X clipboard, useful when vim is compiled
" without + and * registers support
noremap <Leader>c :!xclip -selection clipboard -i<CR>u

" Align multiple columns of text
vnoremap <Leader>a :!column -t<CR>gv:s/  \([^ ]\)/ \1/g<CR>gv=

" sudo save a file
cnoremap w!! %!sudo tee > /dev/null %<CR>

" Shiny path autocomplete
set wildmode=list:longest,list:full
set wildmenu
set wildignore+=*.o,*.obj,.git,*.rbc,*.class,.svn,vendor/,*.pyc

com! FormatXML :%!python3 -c "import xml.dom.minidom, sys; print(xml.dom.minidom.parse(sys.stdin).toprettyxml())"

" URL encode/decode
vnoremap <leader>enurl :!python -c 'import sys,urllib;print urllib.quote(sys.stdin.read().strip())'<cr>
vnoremap <leader>deurl :!python -c 'import sys,urllib;print urllib.unquote(sys.stdin.read().strip())'<cr>
