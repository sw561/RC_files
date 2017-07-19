cd ~
ln -s RC_files/.vimrc .
ln -s RC_files/.bash_aliases .
ln -s RC_files/.tmux.conf .
ln -s RC_files/.git-prompt.sh .
ln -s RC_files/.Xmodmap .
mkdir -p .vim
mkdir -p .vim/syntax
ln -s ~/RC_files/swig.vim .vim/syntax
mkdir -p .vim/plugin
ln -s ~/RC_files/tabline.vim .vim/plugin
ln -s ~/RC_files/statusline.vim .vim/plugin
ln -s ~/RC_files/trim.vim .vim/plugin
ln -s ~/RC_files/long_lines.vim .vim/plugin
mkdir -p .vim/colors
ln -s ~/RC_files/sand.vim .vim/colors
mkdir -p .vim/ftplugin
ln -s ~/RC_files/python.vim .vim/ftplugin
ln -s ~/RC_files/go.vim .vim/ftplugin
ln -s ~/RC_files/cpp.vim .vim/ftplugin
ln -s ~/RC_files/tmux_move.py bin
ln -s ~/RC_files/move_left bin
ln -s ~/RC_files/move_right bin
cd -
