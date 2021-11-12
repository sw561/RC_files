cd ~
ln -s RC_files/.vimrc .
ln -s RC_files/.bash_aliases .
ln -s RC_files/.tmux.conf .
ln -s RC_files/.git-prompt.sh .
ln -s RC_files/.Xmodmap .
ln -s RC_files/.gitconfig .
ln -s RC_files/.gdbinit .
ln -s RC_files/.inputrc .
ln -s RC_files/.ctags .
mkdir -p .vim
ln -s ~/RC_files/vim/syntax/ .vim
ln -s ~/RC_files/vim/plugin/ .vim
ln -s ~/RC_files/vim/colors/ .vim
ln -s ~/RC_files/vim/ftplugin/ .vim
ln -s ~/RC_files/vim/after/ .vim
mkdir -p bin
ln -s ~/RC_files/tmux_move.py bin
cd -
