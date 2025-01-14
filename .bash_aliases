# Find all files in subtree matching 1st arg and grep for 2nd arg
function grepcode() { find . -name "*.[C,H,c,h]" -o -name "*.cpp" -o -name "*.hpp" -o -name "*.py" | xargs grep -n --color=auto -i "$1"; }
alias grepc="grepcode"

alias grepn='grep -I -r -n --color=auto --exclude-dir=.git --exclude=tags --exclude-dir=.svn'
alias ls='exa'
alias ll='exa -l --sort=modified'
alias lsd='exa -1 --only-dirs'
alias tree='exa -aT --git-ignore'
alias open='xdg-open &> /dev/null'
alias vim="vim -p"
alias view="view -p +'call ReadOnly()'"
alias gv="vim +GV"
alias gva="vim +'GV --all'"
alias unittest='python -m unittest discover -p "*_test.py" -v'
alias gs='git status'
alias gsi='git status --untracked-files=no'
alias gl='git log -n 10 --pretty=oneline --abbrev-commit --decorate --graph'
alias gb='git branch -avv'
alias gco='git checkout'
alias gd='git diff'
alias gca='git diff --cached'
alias gitk='gitk --all'
alias rm='rm -I'
alias cp='cp -i'
alias mv='mv -i'
alias less='less -x4'
alias remake='make remake'
alias du='du -h'
alias diff='diff -s'
alias gdbh='vim ~/.gdb_history'
alias hg='history | grep -v "^ \+[0-9]\+ \+vim" | grep'
alias top='htop'
# alias cat='bat --theme ansi-light'

tabs -4
clear

source ~/.git-prompt.sh

GREEN="$(tput setaf 5)" # For light background
# GREEN="$(tput setaf 51)"
BLUE="$(tput setaf 27)"
RESET="$(tput sgr0)"

PS1="${GREEN}my prompt${RESET}> "
export GIT_PS1_SHOWDIRTYSTATE=1
export GIT_PS1_SHOWUPSTREAM=1
export PS1='\[${GREEN}\]\u@\h\[${RESET}\]:\W\[${BLUE}\]$(__git_ps1 " (%s)")\[${RESET}\]$ '

complete -W "\`grep -soE '^[a-zA-Z0-9_.-]+:([^=]|$)' Makefile | sed 's/[^a-zA-Z0-9_.-]*$//'\`" make

# http://unix.stackexchange.com/questions/72086/
stty -ixon
