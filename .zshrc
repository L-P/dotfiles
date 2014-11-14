# Misc options.
bindkey -v
bindkey '^R' history-incremental-search-backward
setopt autocd

# Autojump.
source "$HOME/.autojump/bin/autojump.zsh"
autoload -U compinit && compinit -u

# Bind ^Z to fg, allowing to cycle in and out of apps quickly.
function rebind-z() { fg }
zle -N rebind-z
bindkey '^Z' rebind-z

# History
HISTSIZE=1000000
SAVEHIST=$HISTSIZE
HISTFILE="$HOME/.zsh_history"
setopt hist_ignore_all_dups inc_append_history complete_aliases

# Awe-inspiring prompt.
autoload -U colors && colors
autoload -Uz vcs_info

local cmdstatus="[%j:%(?.%{$fg[green]%}.%{$fg[red]%})%B%?%b]"
local userat="%{$fg[green]%}%B%(!.%{$fg[red]%}.%{$fg[green]%})%B@%{$fg[green]%}%m%b"
local pwd="%B%{$fg[blue]%}%c%b"
local userchar="%(!.#.$)"

zstyle ':vcs_info:*' enable git
zstyle ':vcs_info:*' check-for-changes true
setopt prompt_subst
precmd() {
    vcs_info
}

local branch=" %{$fg[green]%}[%b%c%u%{$fg[green]%}]%{$reset_color%}"
zstyle ':vcs_info:*' formats "$branch"
zstyle ':vcs_info:*' actionformats "$branch (%a)"
zstyle ':vcs_info:*' stagedstr "%{$fg[yellow]%}*"
zstyle ':vcs_info:*' unstagedstr "%{$fg[red]%}*"
PROMPT="$cmdstatus$userat:$pwd\${vcs_info_msg_0_}$userchar "

source "$HOME/.commonshrc"
source "$HOME/.zsh_local"
