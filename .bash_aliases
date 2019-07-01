# Find all files in subtree matching 1st arg and grep for 2nd arg
function grepcode() { find . -name "*.[C,H,c,h,F]" -o -name "*.cpp" -o -name "*.hpp" -o -name "*.py" | xargs grep -n --color=auto -i "$1"; }
alias grepc="grepcode"

alias grepn='grep -I -r -n --color=auto --exclude-dir=.git --exclude=tags'
alias ll='ls -ltr'
alias ls='ls -h --color=auto'
alias lsd='ls -ltrd */'
alias open="xdg-open"
alias vim="vimx -p"
alias view="view -p +'call ReadOnly()'"
alias gv="vimx +GV"
alias gva="vimx +'GV --all'"
alias unittest='python -m unittest discover -p "*_test.py" -v'
alias gs='git status'
alias gl='git log -n 10 --pretty=oneline --abbrev-commit --decorate'
alias gb='git branch -avv'
alias gco='git checkout'
alias gd='git diff'
alias gca='git diff --cached'
alias gitk='gitk --all'
alias rm='rm -I'
alias less='less -x4'
alias remake='make remake'
alias du='du -h'
alias diff='diff -s'
alias gdbh='vim ~/.gdb_history'

tabs -4
clear

export GIT_PS1_SHOWDIRTYSTATE=1
export GIT_PS1_SHOWUPSTREAM=1
export PS1='\[\033[1;35m\]\u@\h\[\033[00m\]:\W\[\033[1;34m\]$(__git_ps1 " (%s)")\[\033[00m\]\$ '

# http://unix.stackexchange.com/questions/72086/
stty -ixon
