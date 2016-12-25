# Find all files in subtree matching 1st arg and grep for 2nd arg
function grepfiles() { find . -name "$1" | xargs grep -n --color=auto -i "$2"; }
function grepcode() { find . -name "*.[C,H,c,h]" -o -name "*.cpp" -o -name "*.py" | xargs grep -n --color=auto -i "$1"; }
alias grepf='grepfiles'
alias grepc="grepcode"

version=`lsb_release -rs | cut -d. -f1`
if [ $version -ge 14 ]
then
	# Don't use grep alias on ubuntu trust because of bug reported at:
	# http://stackoverflow.com/questions/26932672/broken-tab-completion-on-make-under-linux
	alias grepn='grep -n --color=auto'
else
	alias grep='grep -n --color=auto'
fi
alias ll='ls -ltr'
alias ls='ls -h --color=auto'
alias open="gnome-open"
alias vim="vim -p"
alias view="view -p"
alias unittest='python -m unittest discover -p "*_test.py" -v'
alias gs='git status -sb'
alias gl='git log -n 10 --pretty=oneline --abbrev-commit'
alias gb='git branch -avv'
alias gco='git checkout'
alias gitk='gitk --all'
alias rm='rm -I'

export GIT_PS1_SHOWDIRTYSTATE=1
export GIT_PS1_SHOWUPSTREAM=1
if [ `whoami` = "simon" ]
then
export PS1='\[\033[01;32m\]\u@\h\[\033[00m\]:\W\[\033[38;5;12m\]$(__git_ps1 " (%s)")\[\033[00m\]\$ '
else
export PS1='\[\033[01;33m\]\u@\h\[\033[00m\]:\W\[\033[38;5;12m\]$(__git_ps1 " (%s)")\[\033[00m\]\$ '
fi

# http://unix.stackexchange.com/questions/72086/
stty -ixon
