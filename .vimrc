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

" When in insert mode, Ctrl-V goes to visual block mode
imap <C-v> <Esc><C-v>

" Don't want recording mode
map q <nop>

" When in normal mode, Q to gq the paragraph - don't need exec mode
nmap Q gqip
vmap Q gq

" When opening files using wildcards, ignore these files
set wildignore=*.swp,*.png,*.pyc,*.o,*.so,*~

" Function for making backspace behave as expected in normal mode
function! MyBackspace()
	if col('.')==col('$')-1
		" If at the end of a non-empty line, delete last character
		execute "normal! x"
	elseif col('.')==1
		" At start of a line, go to end of previous line
		execute "normal! k$"
	else
		" Otherwise delete character to the left of the cursor
		" To delete the character under the cursor use x or <Del>
		execute "normal! hx"
	endif
endfunction
nnoremap <BS> :call MyBackspace()<Enter>

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
