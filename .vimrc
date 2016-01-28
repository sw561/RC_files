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

set laststatus=2          "statusline displayed always
set statusline=%t         "tail of the filename
set statusline+=%m        "modified flag
set statusline+=%r        "read only flag
set statusline+=%y        "filetype
set statusline+=%=        "left/right separator
set statusline+=%l        "cursor line
set statusline+=/%L,      "total number of lines
set statusline+=%-10.10c  "cursor column

set mouse=a
noremap <ScrollWheelUp> 3<C-Y>
noremap <ScrollWheelDown> 3<C-E>

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
set wildignore=*.swp,*.png,*.pyc,*.o,*.so,*~,*.pdf
set wildmenu

" No annoying beeps or flashes
set noerrorbells
set vb t_vb=

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

autocmd BufRead,BufNewFile *.tex,*.md,*.rst setlocal textwidth=79
	\ spell spelllang=en_gb spellfile=./en.utf-8.add
autocmd BufRead,BufNewFile *.hs setlocal expandtab
autocmd BufRead,BufNewFile *.i setlocal filetype=swig
" Highlight lines that are too long
autocmd BufRead,BufNewFile * match ErrorMsg '\%>79v.\+'

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

" Repurpose the arrow keys for something more useful
function! ReduceGap()
	if line(".") == 1
		return
	endif
	let l:line = getline(line(".") - 1)
	if l:line =~ '^s*$'
		let l:colsave = col(".")
		.-1d
		silent normal! <C-y>
		call cursor(line("."), l:colsave)
	endif
endfunction

function! IncreaseGap()
    let l:scrolloffsave = &scrolloff
    " Avoid jerky scrolling with ^E at top of window
    set scrolloff=0
    call append(line(".") - 1, "")
    if winline() != winheight(0)
        silent normal! <C-e>
    endif
    let &scrolloff = l:scrolloffsave
endfunction

" Arrow key remapping: Up/Dn = move line up/dn; Left/Right = indent/unindent
function! SetArrowKeysAsTextShifters()
	" normal mode
	nmap <Left> <<
	nmap <Right> >>
	nnoremap <Up> <Esc>:call ReduceGap()<CR>
	nnoremap <Down> <Esc>:call IncreaseGap()<CR>

	" insert mode
	imap <Left> <C-D>
	imap <Right> <C-T>
	inoremap <Up> <Esc>:call ReduceGap()<CR>a
	inoremap <Down> <Esc>:call IncreaseGap()<CR>a
endfunction

call SetArrowKeysAsTextShifters()

highlight StatusLine ctermfg=darkblue ctermbg=white
highlight StatusLineNC ctermfg=black ctermbg=white

set cursorline
autocmd VimEnter,WinEnter * setlocal cursorline
autocmd WinLeave * setlocal nocursorline

highlight MatchParen ctermbg=red

cnoremap make !make
