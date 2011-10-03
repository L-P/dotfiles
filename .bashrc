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
txtblk='\e[0;30m' # Black - Regular
txtred='\e[0;31m' # Red
txtgrn='\e[0;32m' # Green
txtylw='\e[0;33m' # Yellow
txtblu='\e[0;34m' # Blue
txtpur='\e[0;35m' # Purple
txtcyn='\e[0;36m' # Cyan
txtwht='\e[0;37m' # White
bldblk='\e[1;30m' # Black - Bold
bldred='\e[1;31m' # Red
bldgrn='\e[1;32m' # Green
bldylw='\e[1;33m' # Yellow
bldblu='\e[1;34m' # Blue
bldpur='\e[1;35m' # Purple
bldcyn='\e[1;36m' # Cyan
bldwht='\e[1;37m' # White
unkblk='\e[4;30m' # Black - Underline
undred='\e[4;31m' # Red
undgrn='\e[4;32m' # Green
undylw='\e[4;33m' # Yellow
undblu='\e[4;34m' # Blue
undpur='\e[4;35m' # Purple
undcyn='\e[4;36m' # Cyan
undwht='\e[4;37m' # White
bakblk='\e[40m'   # Black - Background
bakred='\e[41m'   # Red
badgrn='\e[42m'   # Green
bakylw='\e[43m'   # Yellow
bakblu='\e[44m'   # Blue
bakpur='\e[45m'   # Purple
bakcyn='\e[46m'   # Cyan
bakwht='\e[47m'   # White
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
umask u+rw,go-rwx # 'OFF MY LAWN

# Color aliases
alias ls='ls --color=auto --group-directories-first'
alias grep='grep --color=auto'
alias fgrep='fgrep --color=auto'
alias egrep='egrep --color=auto'
alias tree='tree -C'

# Aliases
alias ll='ls -alF'
alias mysql='mysql --user=root --password=root'
alias mytop='mytop -u root -p root'
alias csd="svn stat | cut -c 9- | grep -v -e '^.$' -e '.dat$' | xargs svn diff | pygmentize -l diff | less -r"

# vim bindings
set -o vi
bind -m vi-insert "\C-l":clear-screen # Ctrl+L : clear
export EDITOR=vim


# Check syntax of all PHP files.
function phpcheck() {
	find . -type f -name '*.php' -exec php -l {} \; | grep -vE '^(No syntax errors|Errors parsing)'
	return 0
}

# Handy grep aliases, since ack sucks.
function g()	{ grep --color=always -EHnr	 --exclude-dir='.svn' $@ . | less -r;  }
function gi()	{ grep --color=always -EHnri --exclude-dir='.svn' $@ . | less -r;  }

# Nice SVN diff.
function sd() {
	arg=''
	if [[ -n $1 ]]; then
		arg="-c $1"
	fi
	svn diff $arg | pygmentize -l diff | less -r
}

source ~/.bash_local

