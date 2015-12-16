set autoindent
set copyindent
set noexpandtab
set number
set tabpagemax=20

set cursorline

set clipboard=unnamedplus

set laststatus=2          "statusline displayed always
set statusline=%t         "tail of the filename
set statusline+=%m        "modified flag
set statusline+=%r        "read only flag
" set statusline+=%y        "filetype
set statusline+=%=        "left/right separator
set statusline+=%l,       "cursor line
set statusline+=%-10.10c  "cursor column

set mouse=a
map <ScrollWheelUp> <C-Y>
map <ScrollWheelDown> <C-E>

imap <c-v> <nop>

set noerrorbells
set vb t_vb=

" Set all three of shiftwidth, softtabstop and tabstop
function! SetTab(value)
	let &shiftwidth  = a:value
	let &softtabstop = a:value
	let &tabstop     = a:value
endfunction
call SetTab(4)

" Removes trailing spaces including empty lines at end of file
function! TrimWhiteSpace()
	let save_cursor = getpos('.')
	%s/\s\+$//e
	$put _
	$put _
	%s/\(\n\n\)\n\+/\1/
	$put _
	%s#\($\n\s*\)\+\%$##
	call setpos('.', save_cursor)
endfunction

autocmd BufWritePre,FileWritePre * call TrimWhiteSpace()

autocmd BufRead,BufNewFile *.tex,*.md set textwidth=79
autocmd BufRead,BufNewFile *.hs set expandtab
autocmd BufRead,BufNewFile *.i set filetype=swig
"highlight lines that are too long
autocmd BufRead,BufNewFile * match ErrorMsg '\%>79v.\+'

" noremap <Up> <NOP>
" noremap <Down> <NOP>
" noremap <Left> <NOP>
" noremap <Right> <NOP>
