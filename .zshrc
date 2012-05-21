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

# Aliases
alias grep='grep --color=auto'
alias fgrep='fgrep --color=auto'
alias egrep='egrep --color=auto'
alias tree='tree -C'
alias mysql='mysql --user=root --password=root'
alias mysqladmin='mysqladmin --user=root --password=root'
alias mytop='mytop -u root -p root'
alias ls='ls --group-directories-first --color'
alias ll='ls -lh'
alias la='ll -a'
alias mkdir='mkdir -pv'
alias rm='rm --preserve-root'
alias gd='git diff'
alias gds='git diff --staged'
alias gs='git status --short'
alias py='python3'

# Nicer du
function duf {
	du -csh -- "$@" | sort -rh
}

# Check syntax of all PHP files.
function phpcheck() {
	find . -type f -name '*.php' -exec php -l {} \; | grep -vE '^(No syntax errors|Errors parsing)'
	return 0
}

# Handy grep aliases, since ack sucks. Unalias needed because of zsh git module.
unalias g 2> /dev/null
function g() {
	grep --color=always -EHnr	 --exclude='*.dat' --exclude-dir='.svn' --exclude-dir='.git' $@ . | $PAGER ;
}
unalias gi 2> /dev/null
function gi() {
	grep --color=always -EHnri --exclude='*.dat' --exclude-dir='.svn' --exclude-dir='.git' $@ . | $PAGER ;
}

# Nice SVN diff.
function sd() {
	arg=''
	if [[ -n $1 ]]; then
		arg="-c $1"
	fi
	svn diff $arg | pygmentize -l diff | $PAGER
}


source ~/.zsh_local

