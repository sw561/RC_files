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

" Change the colour of active and non-active status lines
highlight StatusLine ctermfg=darkblue ctermbg=white
highlight StatusLineNC ctermfg=black ctermbg=white

" Formatting of the tabline
highlight TabLine cterm=none ctermfg=none ctermbg=black
highlight TabNum cterm=bold ctermbg=black
highlight TabLineSel cterm=reverse ctermbg=white ctermfg=darkblue
highlight TabNumSel cterm=none ctermfg=white ctermbg=darkblue
highlight TabLineFill cterm=none ctermbg=black

highlight VertSplit cterm=none ctermfg=black ctermbg=none
highlight NonText cterm=none ctermfg=black
highlight SpecialKey cterm=none ctermfg=black

" Colours of Pop up menu
highlight Pmenu cterm=none ctermfg=none ctermbg=black
highlight PmenuSel cterm=reverse ctermbg=white ctermfg=darkblue

" Highlighting of overly long lines
highlight OverLength ctermbg=red ctermfg=white

" Highlighting for vimdiff
highlight DiffText term=none ctermbg=0
highlight DiffDelete term=none ctermfg=0 ctermbg=none
highlight DiffChange term=none ctermbg=0
highlight DiffAdd term=none ctermbg=0
