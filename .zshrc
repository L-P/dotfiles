# Oh-my-ZSH
ZSH=$HOME/.oh-my-zsh
DISABLE_AUTO_UPDATE="true"
plugins=(vi-mode)
source $ZSH/oh-my-zsh.sh

# Autojump
source ~/.autojump/bin/autojump.zsh
autoload -U compinit && compinit

# Misc options
bindkey '^R' history-incremental-search-backward

# Bind ^Z to fg, allowing to cycle in and out of apps quickly.
function rebind-z() { fg }
zle -N rebind-z
bindkey '^Z' rebind-z

SAVEHIST=1000000
setopt inc_append_history complete_aliases

# Awe-inspiring prompt
local cmdstatus="[%!:%j:%(?.%{$fg[green]%}.%{$fg[red]%})%B%?%b]"
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
