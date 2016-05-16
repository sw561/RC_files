" Vim color file
hi clear Normal
set bg&

" Remove all existing highlighting and set the defaults.
hi clear

" Load the syntax highlighting defaults, if it's enabled.
if exists("syntax_on")
	syntax reset
endif

runtime colors/blueblack.vim

let colors_name = "tex_scheme"

highlight Special ctermfg=6
highlight PreProc ctermfg=6
highlight MatchParen cterm=none ctermfg=6 ctermbg=white
