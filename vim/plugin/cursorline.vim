" Plugin for cursorline in active window only

if exists("g:loaded_cursorline") || &cp || v:version < 700
	finish
else
	let g:loaded_cursorline = 1
endif

" Set to zero if you want it off by default
if !exists("g:cursorline")
	let g:cursorline = 1
endif

autocmd VimEnter,WinEnter,BufEnter * call CursorLineOn()
autocmd WinLeave * setlocal nocursorline

function! CursorLineOn()
	if g:cursorline
		setlocal cursorline
	endif
endfunction

function! CursorLineToggle()
	if g:cursorline == 0
		setlocal cursorline
		let g:cursorline = 1
	else
		setlocal nocursorline
		let g:cursorline = 0
	endif
endfunction

call Mycabbrev("cursorline", "call CursorLineToggle()")
