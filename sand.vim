" Check that we have the colors - even if t_Co is 256, they may still not be
" displayed correctly
if (&t_Co<=8)
	echo "Greetings young padawan"
	echo "Insufficient colors for sand colorscheme"
	finish
endif

" Vim color file
hi clear Normal
set bg&

" Remove all existing highlighting and set the defaults.
hi clear

" Load the syntax highlighting defaults, if it's enabled.
if exists("syntax_on")
	syntax reset
endif

let colors_name = "sand"

let g:Blue="4"

let MyYellow="ctermfg=222"
let MyRed="ctermfg=178"
let MyGreen="ctermfg=72"
let MyPurple=MyGreen
let MyCyan=MyGreen
let MyBlue="ctermfg=" .Blue

exe "highlight Comment " .MyBlue
exe "highlight Special " .MyPurple
exe "highlight PreProc " .MyPurple
exe "highlight Constant " .MyRed
exe "highlight Identifier " .MyCyan
exe "highlight Ignore " .MyCyan
exe "highlight Type " .MyGreen

source ~/.vim/colors/blueblack_general.vim
