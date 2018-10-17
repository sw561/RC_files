# Find all files in subtree matching 1st arg and grep for 2nd arg
function grepfiles() { find . -name "$1" | xargs grep -n --color=auto -i "$2"; }
function grepcode() { find . -name "*.[C,H,c,h]" -o -name "*.cpp" -o -name "*.hpp" -o -name "*.py" | xargs grep -n --color=auto -i "$1"; }
alias grepf='grepfiles'
alias grepc="grepcode"

alias grepn='grep -r -n --color=auto --exclude-dir=.git'
alias ll='ls -ltr'
alias ls='ls -h --color=auto'
alias lsd='ls -ltrd */'
alias open="gnome-open"
alias vim="vim -p"
alias view="view -p"
alias unittest='python -m unittest discover -p "*_test.py" -v'
alias gs='git status'
alias gl='git log -n 10 --pretty=oneline --abbrev-commit'
alias gb='git branch -avv'
alias gco='git checkout'
alias gd='git diff'
alias gca='git diff --cached'
alias gitk='gitk --all'
alias rm='rm -I'
alias less='less -x4'
alias remake='make remake'
alias du='du -h'

tabs -4
clear

export GIT_PS1_SHOWDIRTYSTATE=1
export GIT_PS1_SHOWUPSTREAM=1
if [ `whoami` = "simon" ]
then
export PS1='\[\033[01;32m\]\u@\h\[\033[00m\]:\W\[\033[38;5;12m\]$(__git_ps1 " (%s)")\[\033[00m\]\$ '
else
export PS1='\[\033[1;35m\]\u@\h\[\033[00m\]:\W\[\033[1;34m\]$(__git_ps1 " (%s)")\[\033[00m\]\$ '
fi

# http://unix.stackexchange.com/questions/72086/
stty -ixon

alias data='cd /data/hydra02-2/sw561/ && pwd'
