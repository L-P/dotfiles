# If not running interactively, don't do anything
[ -z "$PS1" ] && return

# Hist options
HISTCONTROL=ignoredups:ignorespace
HISTSIZE=50000
HISTFILESIZE=1000000

# Autocompletion
source /etc/bash_completion

# Less more friendly
[ -x /usr/bin/lesspipe ] && eval "$(SHELL=/bin/sh lesspipe)"

# Color aliases
bldred='\e[1;31m' # Red
bldgrn='\e[1;32m' # Green
bldylw='\e[1;33m' # Yellow
bldblu='\e[1;34m' # Blue
txtrst='\e[0m'    # Text Reset


# Awesome prompt
PROMPT_COMMAND='RET=$?;'
RETVAL='$(echo $RET)'
RETCOL='$(
if [[ $RET = 0 ]]; then
    echo -ne "\[$bldgrn\]"
else
    echo -ne "\[$bldred\]"
fi)'
AROBCOL='$(
if [[ $UID -ge 1000 ]]; then
    echo -ne "\[$bldgrn\]"
elif [[ $UID = 0 ]]; then
    echo -ne "\[$bldred\]"
else
    echo -ne "\[$bldylw\]"
fi)'
PS1="[\!:$RETCOL$RETVAL\[$txtrst\]]$AROBCOL@\[$bldgrn\]\h\[$txtrst\]:\[$bldblu\]\W\[$txtrst\]\$ "
case "$TERM" in
xterm*|rxvt*)
    PS1="\[\e]0;${debian_chroot:+($debian_chroot)}\u@\h: \w\a\]$PS1"
    ;;
*)
    ;;
esac

# Misc bash options
shopt -s cdspell
shopt -s checkwinsize
shopt -s cmdhist
shopt -s dotglob
shopt -s expand_aliases
shopt -s extglob
shopt -s histappend
shopt -s hostcomplete

# vim bindings
set -o vi
bind -m vi-insert "\C-l":clear-screen # Ctrl+L : clear

source ~/.autojump/bin/autojump.bash
source ~/.commonshrc
source ~/.bash_local

complete -C /usr/bin/nomad nomad
