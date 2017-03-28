" Rest of custom colour schemes

let MyBlueHighlighting="ctermfg=7 ctermbg=" .g:Blue

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
exe "highlight Visual cterm=none " .MyBlueHighlighting

" Other random stuff
highlight VertSplit cterm=none ctermfg=0 ctermbg=none
highlight NonText cterm=none ctermfg=0
highlight SpecialKey ctermfg=0

if (&t_Co>8)
	highlight LineNr ctermfg=8

	" Eye-catching yellow background highlighting
	highlight Search ctermfg=16 ctermbg=3
	highlight WildMenu ctermfg=16 ctermbg=3

	" Dangerous red for errors
	highlight ErrorMsg ctermfg=15 ctermbg=9

	" Unobtrusive gray-scale highlighting
	highlight Todo cterm=none ctermfg=15 ctermbg=8
	highlight MatchParen cterm=reverse ctermbg=15 ctermfg=8
endif

highlight! link CursorLineNr LineNr

" Colours of Pop up menu
highlight Pmenu cterm=none ctermfg=none ctermbg=0
exe "highlight PmenuSel cterm=none " .MyBlueHighlighting

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
highlight! link FoldedColumn Folded
