# Oh-my-ZSH
ZSH=$HOME/.oh-my-zsh
ZSH_THEME="blinks"
DISABLE_AUTO_UPDATE="true"
plugins=(svn nyan)
source $ZSH/oh-my-zsh.sh

# Vi bindings
bindkey -v

export EDITOR=vim
export LESS='-RFXS -x4'
export PAGER='less'
export MANPAGER='less'

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

# Handy grep aliases, since ack sucks.
function g()	{ grep --color=always -EHnr	 --exclude='*.dat' --exclude-dir='.svn' --exclude-dir='.git' $@ . | $PAGER ; }
function gi()	{ grep --color=always -EHnri --exclude='*.dat' --exclude-dir='.svn' --exclude-dir='.git' $@ . | $PAGER ; }

# Nice SVN diff.
function sd() {
	arg=''
	if [[ -n $1 ]]; then
		arg="-c $1"
	fi
	svn diff $arg | pygmentize -l diff | $PAGER
}


source ~/.zsh_local
