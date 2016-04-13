alias grep='grep --color=auto'
alias ls='ls --color=auto'
alias open="gnome-open"
alias create_git="source ~/RC_files/create_git.sh"
alias vim="vim -p"
alias unittest='python -m unittest discover -p "*_test.py" -v'
alias gs='git status -sb'
alias gl='git log -n 10 --pretty=oneline --abbrev-commit'
alias gb='git branch -avv'
alias gco='git checkout'
alias gitk='gitk --all'
alias rm='rm -I'

export GIT_PS1_SHOWDIRTYSTATE=1
export GIT_PS1_SHOWUPSTREAM=1
export PS1='\u@\h:\W\[\033[38;5;12m\]$(__git_ps1 " (%s)")\[\033[00m\]\$ '

# http://unix.stackexchange.com/questions/72086/
stty -ixon
