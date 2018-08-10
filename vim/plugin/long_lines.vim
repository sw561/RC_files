" Plugin to highlight overly long lines

if exists("g:loaded_long") || &cp || v:version < 700
	finish
else
	let g:loaded_long = 1
endif

" Set to zero if you want it off by default
if !exists("g:long_line_match")
	let g:long_line_match = 1
endif

" Highlighting can be overridden in color scheme
highlight OverLength cterm=underline

" Highlight lines that are too long in the active window
autocmd BufEnter,WinEnter,VimEnter * call LongLineHighlightOn()
autocmd BufLeave,WinLeave * call LongLineHighlightOff()

function! LongLineHighlightOff()
	match OverLength //
endfunction

function! LongLineHighlightOn()
	if g:long_line_match && !&readonly && &modifiable && &filetype!="" && !&diff && &filetype!="tags"
		match OverLength '\%>79v.\+'
	endif
endfunction

function! LongLineHighlightToggle()
	if g:long_line_match == 1
		let g:long_line_match = 0
		call LongLineHighlightOff()
		echo "Long line highlighting OFF"
	else
		let g:long_line_match = 1
		call LongLineHighlightOn()
		echo "Long line highlighting ON"
	endif
endfunction

call Mycabbrev("long","call LongLineHighlightToggle()")
