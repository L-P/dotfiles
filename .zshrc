# Oh-my-ZSH
ZSH=$HOME/.oh-my-zsh
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


# Awesome prompt
local cmdstatus="[%!:%(?.%{$fg[green]%}.%{$fg[red]%})%B%?%b]"
local userat="%{$fg[green]%}%B%(!.%{$fg[red]%}.%{$fg[green]%})%B@%{$fg[green]%}%m%b"
local pwd=":%B%{$fg[blue]%}%c%b"
local userchar="%(!.#.$)"
PROMPT='${cmdstatus}${userat}${pwd}$(git_prompt_info)${userchar} '

# Taken from the candy theme.
ZSH_THEME_GIT_PROMPT_PREFIX=" %{$fg[green]%}["
ZSH_THEME_GIT_PROMPT_SUFFIX="]%{$reset_color%}"
ZSH_THEME_GIT_PROMPT_DIRTY=" %{$fg[red]%}*%{$fg[green]%}"
ZSH_THEME_GIT_PROMPT_CLEAN=""

source ~/.commonshrc
source ~/.zsh_local

