" Plugin to trim white space before saving

if exists("g:trim") || &cp || v:version < 700
	finish
endif

" Set to zero if you want it off by default
let g:trim = 1
let g:trim_double = 1

" Removes trailing spaces including empty lines at end of file
" Also removes double blank lines
function! TrimWhiteSpace()
	if g:trim == 0
		return
	endif
	let save_cursor = getpos('.')
	" Remove trailing space at end of lines
	%s/\s\+$//e
	if g:trim_double == 1
		" Reduce double blanks to single blank lines
		$put _
		$put _
		%s/\(\n\n\)\n\+/\1/
	endif
	" Remove empty lines at end of file
	$put _
	%s#\($\n\s*\)\+\%$##
	call setpos('.', save_cursor)
endfunction

autocmd BufWritePre,FileWritePre * call TrimWhiteSpace()