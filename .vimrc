set autoindent
set copyindent
set noexpandtab
set number
set tabpagemax=20
set splitright
set splitbelow
set ignorecase
set smartcase
set scrolloff=2
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
noremap <ScrollWheelUp> <C-Y>
noremap <ScrollWheelDown> <C-E>

" When in insert mode, Ctrl-V goes to visual block mode
inoremap <C-v> <Esc><C-v>

" Don't want recording mode
noremap q <nop>

" When in normal mode, Q to gq the paragraph - don't need exec mode
nnoremap Q gqip
vnoremap Q gq
inoremap QQ <Esc>gqipA
" When formatting paragraphs of text, use 1 space after periods
set nojoinspaces

" When opening files using wildcards, ignore these files
set wildignore=*.swp,*.png,*.pyc,*.o,*.so,*~
set wildmenu

nnoremap tn :tabnew
nnoremap gr gT

" No annoying beeps or flashes
set noerrorbells
set vb t_vb=

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

autocmd BufRead,BufNewFile *.tex,*.md,*.rst setlocal textwidth=79 spell spelllang=en_gb spellfile=./en.utf-8.add
autocmd BufRead,BufNewFile *.hs setlocal expandtab
autocmd BufRead,BufNewFile *.i setlocal filetype=swig
"highlight lines that are too long
autocmd BufRead,BufNewFile * match ErrorMsg '\%>79v.\+'

" Hard mode - disable arrow keys to break habits
noremap <Up> <NOP>
noremap <Down> <NOP>
noremap <Right> <NOP>
noremap <Left> <NOP>
inoremap <Up> <NOP>
inoremap <Down> <NOP>
inoremap <Right> <NOP>
inoremap <Left> <NOP>

" Comfortable movement between split windows
noremap <C-J> <C-W><C-J>
noremap <C-K> <C-W><C-K>
noremap <C-L> <C-W><C-L>
noremap <C-H> <C-W><C-H>
inoremap <C-J> <Esc><C-W><C-J>
inoremap <C-K> <Esc><C-W><C-K>
inoremap <C-L> <Esc><C-W><C-L>
inoremap <C-H> <Esc><C-W><C-H>
