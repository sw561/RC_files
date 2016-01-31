set autoindent
set copyindent
set noexpandtab
set relativenumber
set tabpagemax=20
set splitright
set splitbelow
set ignorecase
set smartcase
set scrolloff=2
set clipboard=unnamedplus
set confirm
set nojoinspaces

set laststatus=2            "statusline displayed always
set statusline=%t           "tail of the filename
set statusline+=%m          "modified flag
set statusline+=%r          "read only flag
set statusline+=%y          "filetype
set statusline+=%=          "left/right separator
set statusline+=%l          "cursor line
set statusline+=/%L,        "total number of lines
set statusline+=%-10.10c    "cursor column

" Change the colour of active and non-active status lines
highlight StatusLine ctermfg=darkblue ctermbg=white
highlight StatusLineNC ctermfg=black ctermbg=white

" Formatting of the tabline
set showtabline=2
highlight TabLine cterm=none ctermfg=white ctermbg=black
highlight TabLineSel ctermfg=white ctermbg=blue
highlight TabLineFill ctermfg=black ctermbg=black

" Turn on the mouse, for scrolling too
set mouse=a
noremap <ScrollWheelUp> 3<C-Y>
noremap <ScrollWheelDown> 3<C-E>

noremap <C-E> 3<C-E>
noremap <C-Y> 3<C-Y>

" Don't want recording mode
noremap q <nop>
" Don't need exec mode
noremap Q <nop>

" When opening files using wildcards, ignore these files
set wildignore=*.swp,*.png,*.pyc,*.o,*.so,*~,*.pdf
set wildmenu

" No annoying beeps or flashes
set noerrorbells
set vb t_vb=

autocmd VimEnter,WinEnter * setlocal cursorline
autocmd WinLeave * setlocal nocursorline

highlight MatchParen ctermbg=red
highlight VertSplit ctermfg=black

" Visual mode p doesn't replace text in buffer
vnoremap p pgvy`]
" after paste, cursor goes to end of pasted text
nnoremap p p`]

" Avoid having to press <CR> twice after the make
cnoremap make !make

" Turn off spell checking for comments in tex files
let g:tex_comment_nospell=1

" Function for making backspace behave as expected in normal mode
function! MyBackspace()
	if col('.')==col('$')-1
		" If at the end of a non-empty line, delete last character
		execute "normal! x"
	elseif col('.')==1
		" At start of a line, join lines
		execute "normal! kJ"
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

" Highlight lines that are too long in the active window
let g:long_line_match=1
highlight OverLength ctermbg=red ctermfg=white
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

" Comfortable movement between split windows
noremap <C-J> <C-W><C-J>
noremap <C-K> <C-W><C-K>
noremap <C-L> <C-W><C-L>
noremap <C-H> <C-W><C-H>
inoremap <C-J> <Esc><C-W><C-J>
inoremap <C-K> <Esc><C-W><C-K>
inoremap <C-L> <Esc><C-W><C-L>
inoremap <C-H> <Esc><C-W><C-H>

" Shortcuts for using tabs
cnoremap tn tabnew
nnoremap gr gT

" Shortcuts for using buffers
nnoremap gn :bn<Enter>
nnoremap gm :bp<Enter>
command MyBufferDelete bp|bd# " :bd will delete buffer without deleting window
cnoremap bd MyBufferDelete
cnoremap ls ls<Enter>:b
" Avoid accidental capitals
cmap Ls ls
cmap LS ls

" Disable arrow keys
inoremap <Right> <nop>
inoremap <Left> <nop>
inoremap <Down> <nop>
inoremap <Up> <nop>
nnoremap <Right> <nop>
nnoremap <Left> <nop>
nnoremap <Down> <nop>
nnoremap <Up> <nop>

" Commands for specific filetypes
autocmd FileType tex,rst,markdown
	\ setlocal textwidth=79
	\ spell spelllang=en_gb spellfile=./en.utf-8.add
autocmd FileType haskell setlocal expandtab
autocmd BufRead,BufNewFile *.i setlocal filetype=swig
