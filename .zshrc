# Misc options.
bindkey -v
bindkey '^R' history-incremental-search-backward
setopt autocd

# Bits from Oh My ZSH df5b09e20b05a5ba4234599602f7a74934c916db.
ZSH_CACHE_DIR="$HOME/.cache/zsh"
source "$HOME/.zsh/completion.zsh"
source "$HOME/.zsh/history.zsh"
source "$HOME/.zsh/misc.zsh"
source "$HOME/.zsh/vi-mode.plugin.zsh"

# Huge slowdown with the defaults from history.zsh.
HISTSIZE=2000
SAVEHIST=$HISTSIZE

# Autojump.
source "$HOME/.autojump/bin/autojump.zsh"
autoload -U compinit && compinit -u

# Bind ^Z to fg, allowing to cycle in and out of apps quickly.
function rebind-z() { fg }
zle -N rebind-z
bindkey '^Z' rebind-z

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
    print -Pn "\e]0;$(basename "$(pwd)")\a"
}

local branch=" %{$fg[green]%}[%b%c%u%{$fg[green]%}]%{$reset_color%}"
zstyle ':vcs_info:*' formats "$branch"
zstyle ':vcs_info:*' actionformats "$branch (%a)"
zstyle ':vcs_info:*' stagedstr "%{$fg[yellow]%}*"
zstyle ':vcs_info:*' unstagedstr "%{$fg[red]%}*"
PROMPT="$cmdstatus$userat:$pwd\${vcs_info_msg_0_}$userchar "

source "$HOME/.commonshrc"
source "$HOME/.zsh_local"
