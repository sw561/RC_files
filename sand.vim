" Check that we have the colors - even if t_Co is 256, they may still not be
" displayed correctly depending on your terminal
if (&t_Co<256)
	echo "Insufficient colors for sand colorscheme"
	finish
endif

" Remove all existing highlighting and set the defaults.
hi clear

" Load the syntax highlighting defaults, if it's enabled.
if exists("syntax_on")
	syntax reset
endif

let colors_name = "sand"

let Blue="4"

let MyOrange="ctermfg=130"
let MyYellow="ctermfg=178"
let MyGreen="ctermfg=72"
let MyBlue="ctermfg=" .Blue

exe "highlight Statement " .MyOrange
exe "highlight Comment " .MyBlue
exe "highlight Special " .MyGreen
exe "highlight PreProc " .MyGreen
exe "highlight Constant " .MyYellow
exe "highlight Identifier cterm=none " .MyGreen
exe "highlight Ignore " .MyGreen
exe "highlight Type " .MyGreen

" Change the colour of active and non-active status lines
highlight StatusLineNC cterm=none ctermfg=7 ctermbg=0
exe "highlight StatusLine cterm=none ctermfg=7 ctermbg=" .Blue

" Tabline
highlight! link TabLine StatusLineNC
highlight! link TabLineSel StatusLine
highlight! link TabLineFill StatusLineNC

highlight OverLength cterm=underline

" Visual selections
highlight! link Visual StatusLine

" Colours of Pop up menu
highlight! link Pmenu StatusLineNC
highlight! link PmenuSel StatusLine

" Other random stuff
highlight VertSplit cterm=none ctermfg=0 ctermbg=none
highlight NonText cterm=none ctermfg=0
highlight SpecialKey ctermfg=0
highlight Question ctermfg=2
highlight! link MoreMsg Question
highlight! link Directory Comment

highlight LineNr ctermfg=8
highlight! link CursorLineNr LineNr

" Eye-catching yellow background highlighting
highlight Search ctermfg=16 ctermbg=3
highlight! link WildMenu Search
highlight! link IncSearch Search

" Dangerous red for errors
highlight ErrorMsg ctermfg=15 ctermbg=9

" Unobtrusive gray-scale highlighting
highlight Todo cterm=none ctermfg=15 ctermbg=8
highlight MatchParen cterm=reverse ctermbg=15 ctermfg=8

" Highlighting for vimdiff
highlight DiffText term=none ctermbg=0
highlight DiffDelete term=none ctermfg=0 ctermbg=none
highlight DiffChange term=none ctermbg=0
highlight DiffAdd term=none ctermbg=0

highlight SpellBad ctermfg=15 ctermbg=9
highlight! link SpellCap SpellBad
highlight! link SpellLocal SpellBad
highlight! link SpellRare SpellBad

highlight Folded term=none ctermbg=8 ctermfg=15
highlight! link FoldColumn Folded
