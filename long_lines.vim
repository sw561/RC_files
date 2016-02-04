" Plugin to highlight overly long lines

if exists("g:long_line_match") || &cp || v:version < 700
	finish
endif

" Set to zero if you want it off by default
let g:long_line_match = 1

" Highlighting can be overridden in color scheme
highlight OverLength ctermbg=red ctermfg=white

" Highlight lines that are too long in the active window
autocmd WinEnter,VimEnter *
	\ if g:long_line_match==1 |
	\   match OverLength '\%>79v.\+' |
	\ endif
autocmd WinLeave * match OverLength //

function! LongLineHighlightToggle()
	if g:long_line_match == 1
		match OverLength //
		let g:long_line_match = 0
		echo "Long line highlighting OFF"
	else
		match OverLength '\%>79v.\+'
		let g:long_line_match = 1
		echo "Long line highlighting ON"
	endif
endfunction

cnoremap long call LongLineHighlightToggle()
cnoremap long? echo g:long_line_match
