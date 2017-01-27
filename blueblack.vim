" Vim color file
hi clear Normal
set bg&

" Remove all existing highlighting and set the defaults.
hi clear

" Load the syntax highlighting defaults, if it's enabled.
if exists("syntax_on")
	syntax reset
endif

let colors_name = "blueblack"

let g:Blue="4"

let MyYellow="ctermfg=3"
exe "highlight Statement " .MyYellow

source ~/.vim/colors/blueblack_general.vim
