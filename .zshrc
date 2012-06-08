# Oh-my-ZSH
ZSH=$HOME/.oh-my-zsh
ZSH_THEME="blinks"
DISABLE_AUTO_UPDATE="true"
plugins=(git svn nyan vi-mode)
source $ZSH/oh-my-zsh.sh

# Misc options
export EDITOR=vim
export LESS='-RFXS -x4'
export PAGER='less'
export MANPAGER='less'
umask u+rw,go-rwx # 'OFF MY LAWN
mkdir ~/.vim/undo > /dev/null 2>&1
bindkey '^R' history-incremental-search-backward

setopt \
	inc_append_history \
	share_history \
	complete_aliases

source ~/.commonshrc
source ~/.zsh_local

