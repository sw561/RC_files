" Plugin to trim white space before saving

if exists("g:loaded_trim") || &cp || v:version < 700
	finish
else
	let g:loaded_trim = 1
endif

" Set to zero if you want it off by default
if !exists("g:trim")
	let g:trim = 0
endif
if !exists("g:trim_double")
	let g:trim_double = 0
endif

" Removes trailing spaces including empty lines at end of file
" Also removes double blank lines
function! TrimWhiteSpace()
	let save_cursor = getpos('.')
	" Remove trailing space at end of lines
	" Remove empty lines at end of file
	keeppatterns %s/\s\+$\|\(\n\s*\)\+\%$//e
	if g:trim_double == 1
		" Reduce double blanks to single blank lines
		keeppatterns %s/\n\{3,}/\r\r/e
	endif
	call setpos('.', save_cursor)
endfunction

function! AutoTrimWhiteSpace()
	if g:trim == 0 || &filetype==""
		return
	endif
	call TrimWhiteSpace()
endfunction

autocmd BufWritePre,FileWritePre * call AutoTrimWhiteSpace()
