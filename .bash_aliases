# Find all files in subtree matching 1st arg and grep for 2nd arg
function grepcode() { find . -name "*.[C,H,c,h,F]" -o -name "*.cpp" -o -name "*.hpp" -o -name "*.py" | xargs grep -n --color=auto -i "$1"; }
alias grepc="grepcode"

function open_quietly() {
  xdg-open "$1" 2>/dev/null
}

alias grepn='grep -I -r -n --color=auto --exclude-dir=.git --exclude=tags'
alias l='ls -ltr'
alias ll='ls -ltr'
alias ls='ls -h --color=auto'
alias lsd='ls -ltrd */'
alias open="open_quietly"
alias vim="vim -p"
alias unittest='python -m unittest discover -p "*_test.py" -v'
alias gs='git status'
alias gl='git log -n 20 --pretty=oneline --abbrev-commit --decorate --graph'
alias gb='git branch -avv'
alias gco='git checkout'
alias gd='git diff'
alias gca='git diff --cached'
alias gsi='git status --untracked-files=no'
alias gitk='gitk --all'
alias du='du -hsc'
alias top='htop'

tabs -4

export REVIEW_BASE=master
