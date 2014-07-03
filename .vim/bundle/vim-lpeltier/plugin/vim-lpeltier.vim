" The file _will_ be loaded twice because of how I handle vim.tiny.
if exists("g:loaded_lpeltier")
    finish
else
    let g:loaded_lpeltier = 1
endif

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

" TERM == linux means it's a 8 color TTY.
if $TERM != "linux"
    set t_Co=256
    colorscheme wombat256
else
    colorscheme wombat
endif

" Misc options
" ------------
set number              " Line numbering for the current line
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
set spelllang=en_us,fr
set spellsuggest=5      " Limit spelling suggestions list to 5 entries
set pastetoggle=<F2>    " Use F2 to toggle paste mode
set incsearch           " Jump to the next search result while still typing
set showmatch           " Highlight matching opening bracket when inserting '}'
set showmode            " Display the current mode (insert/normal/visual/etc.)
set scrolloff=3         " Force-scroll 3 lines before/after the cursor
set laststatus=2        " Always show statusline
set textwidth=79        " Soft-limit of 79 chars
set nowrap              " Disable text-wrapping
set splitright          " Open new splits on the right
set splitbelow          " Open new splits on the bottom
set lazyredraw          " Mostyl for speeding up scrolling.
set exrc                " Per-directory .vimrc.
set secure              " Disallow unsafe commands in per-directory .vimrc files.

if version >= 703
    set relativenumber      " Relative line numbering
    set colorcolumn=80      " Highlight the 80th column
    set undofile            " Persistant undo across sessions
    set undodir=~/.vim/undo
endif

" Mappings
" --------
if 1
    " \ is difficult to type on azerty keyboards
    let mapleader=" "
endif

" Browse ctags
nnoremap <Leader><C-P> :CtrlPTag<CR>

" gitsessions.vim
nnoremap <Leader>ss :GitSessionSave<CR>
nnoremap <Leader>ds :GitSessionDelete<CR>

" Toggle Gundo window
noremap <F8> :GundoToggle<CR>

" For consistency
noremap Y y$

" Disable Ex mode.
noremap Q <Nop>

" Visually select last inserted text.
noremap gV `[v`]

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
