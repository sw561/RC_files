" Plugin to highlight overly long lines

if exists("g:loaded_long") || &cp || v:version < 700
	finish
else
	let g:loaded_long = 1
endif

" Set to zero if you want it off by default
if !exists("g:long_line_match")
	if &readonly
		let g:long_line_match = 0
	else
		let g:long_line_match = 1
	endif
endif

" Highlighting can be overridden in color scheme
highlight OverLength ctermbg=red ctermfg=white

" Highlight lines that are too long in the active window
autocmd WinEnter,VimEnter *
	\ if g:long_line_match==1 |
	\   match OverLength '\%>79v.\+' |
	\ endif
autocmd WinLeave * match OverLength //

function! LongLineHighlightOff()
	match OverLength //
	let g:long_line_match = 0
	echo "Long line highlighting OFF"
endfunction

function! LongLineHighlightOn()
	match OverLength '\%>79v.\+'
	let g:long_line_match = 1
	echo "Long line highlighting ON"
endfunction

function! LongLineHighlightToggle()
	if g:long_line_match == 1
		call LongLineHighlightOff()
	else
		call LongLineHighlightOn()
	endif
endfunction

cabbrev long call LongLineHighlightToggle()
