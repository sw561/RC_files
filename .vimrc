set tabstop=4
set softtabstop=4
set shiftwidth=4
set autoindent
set noexpandtab
set number
set tabpagemax=20

set cursorline

set mouse=a
map <ScrollWheelUp> <C-Y>
map <ScrollWheelDown> <C-E>

set noerrorbells
set vb t_vb=

" Removes trailing spaces including empty lines at end of file
function! TrimWhiteSpace()
	let save_cursor = getpos(".")
	%s/\s\+$//e
	$put _
	%s#\($\n\s*\)\+\%$##
	call setpos('.', save_cursor)
endfunction

autocmd BufWritePre,FileWritePre * call TrimWhiteSpace()

autocmd BufRead,BufNewFile *.tex set textwidth=80
autocmd BufRead,BufNewFile *.hs set expandtab
autocmd BufRead,BufNewFile *.py match ErrorMsg '\%>79v.\+'

au BufNewFile,BufRead *.i set filetype=swig
