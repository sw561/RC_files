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
let g:Yellow="3"
" let g:Red="1"
" let g:Purple="13"
" let g:Cyan="6"

if (&t_Co>8)
	" Vibrant primary colours
	" let Blue="60"
	" let MyYellow="ctermfg=214"
	" let MyRed="ctermfg=203"
	" let MyGreen="ctermfg=58"
	" let MyPurple=MyGreen
	" let MyCyan=MyGreen

	" Fresh and energetic
	" let Blue="30"
	let Blue="4"
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
else
	let MyYellow="ctermfg=" .g:Yellow
endif

exe "highlight Statement " .MyYellow
let MyBlueHighlighting="ctermfg=7 ctermbg=" .Blue

" Change the colour of active and non-active status lines
highlight StatusLineNC cterm=none ctermfg=none ctermbg=0

" Formatting of the tabline
highlight TabLine cterm=none ctermfg=7 ctermbg=0
highlight TabNum cterm=bold ctermfg=none ctermbg=0
highlight TabLineFill cterm=none ctermbg=0

" Principle colour of the theme
exe "highlight StatusLine cterm=none " .MyBlueHighlighting
exe "highlight TabLineSel cterm=none " .MyBlueHighlighting
exe "highlight TabNumSel cterm=bold " .MyBlueHighlighting
exe "highlight Visual " .MyBlueHighlighting

" Other random stuff
highlight VertSplit cterm=none ctermfg=0 ctermbg=none
highlight NonText cterm=none ctermfg=0
highlight SpecialKey ctermfg=0
highlight LineNr ctermfg=8
highlight CursorLineNr ctermfg=8

" Eye-catching yellow background highlighting
highlight Search ctermfg=16 ctermbg=3
highlight WildMenu ctermfg=16 ctermbg=3

" Dangerous red for errors
highlight ErrorMsg ctermfg=15 ctermbg=9

" Unobtrusive gray-scale highlighting
highlight Todo cterm=none ctermfg=15 ctermbg=8
highlight MatchParen cterm=reverse ctermbg=15 ctermfg=8

" Colours of Pop up menu
highlight Pmenu cterm=none ctermfg=none ctermbg=0
exe "highlight PmenuSel cterm=none " .MyBlueHighlighting

" Highlighting for vimdiff
highlight DiffText term=none ctermbg=0
highlight DiffDelete term=none ctermfg=0 ctermbg=none
highlight DiffChange term=none ctermbg=0
highlight DiffAdd term=none ctermbg=0
