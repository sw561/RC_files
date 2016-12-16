" My custom color scheme - just some minor changes to the default settings
colo blueblack

filetype plugin on

" Settings
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
set wildignore=*.swp,*.png,*.pyc,*.o,*.so,*~,*.pdf,*.db
set wildmenu
set noerrorbells
set vb t_vb=
set exrc " Can put local .vimrc in project directory
set timeout timeoutlen=1000 ttimeoutlen=10
set hlsearch
nohl " Make sure that on reload of vimrc the last search is not highlighted
nnoremap ,/ :nohl<CR>
set listchars=tab:>-,eol:$
nnoremap ,t :set list!<CR>
set formatoptions+=rol
set synmaxcol=300

" Turn on the mouse, for scrolling too
set mouse=a
noremap <ScrollWheelUp> 3<C-Y>
noremap <ScrollWheelDown> 3<C-E>
noremap <C-E> 3<C-E>
noremap <C-Y> 3<C-Y>
imap <C-E> <Esc><C-E>
imap <C-Y> <Esc><C-Y>

" Inspired by http://vi.stackexchange.com/questions/6800/
function! Mycabbrev(lhs,rhs)
	execute printf("cnoreabbrev <expr> %s getcmdtype() ==# ':' ? '%s' : '%s'",
		\ a:lhs, a:rhs, a:lhs)
endfunction

" Make Y behave analogously to D and C
noremap Y y$

" New line with enter - start new paragraph by hitting enter twice
nnoremap <CR> o

" In visual mode, don't include end of line blank characters
vnoremap $ g_

" In visual mode, search for the selected string with //
vnoremap // y/<C-R>0<CR>

" Don't lose the visual selection when adjusting indentation
vnoremap < <gv
vnoremap > >gv

" Don't need exec mode
noremap Q <nop>
" Don't open command line when trying to quit
noremap q: <nop>

" Settings for the command window
autocmd CmdwinEnter * noremap <buffer> <CR> <CR>
autocmd CmdwinEnter * inoremap <buffer> <CR> <CR>
autocmd CmdwinEnter * noremap <buffer> <C-E> <C-E>
autocmd CmdwinEnter * noremap <buffer> <C-Y> <C-Y>
" Note that scrolloff is a global setting, so need to change it back.
" setlocal will not work in this case
autocmd CmdwinEnter * set scrolloff=0
autocmd CmdwinLeave * set scrolloff=2

" Settings for netrw
let g:netrw_liststyle=3
let g:netrw_browse_split=3

autocmd VimEnter,WinEnter * setlocal cursorline
autocmd WinLeave * setlocal nocursorline

" Exclamation mark avoids having to press <CR> twice after the make
nnoremap ,m :!make<CR>

" Turn off spell checking for comments in tex files
let g:tex_comment_nospell=1

" Use :x instead of :wq only write if changes have been made
call Mycabbrev("wq","x")
call Mycabbrev("w","update")

" Set all three of shiftwidth, softtabstop and tabstop
function! SetTab(value)
	let &shiftwidth  = a:value
	let &softtabstop = a:value
	let &tabstop     = a:value
endfunction
call SetTab(4)

" Function for making backspace behave as expected in normal mode
function! MyBackspace()
	if col('.')==col('$')-1
		" If at the end of a non-empty line, delete last character
		startinsert!
	else
		" Otherwise delete character to left of cursor
		startinsert
	endif
endfunction
nnoremap <BS> :call MyBackspace()<Enter><BS>

" Comfortable movement between split windows
noremap <C-J> <C-W>j
noremap <C-K> <C-W>k
noremap <C-L> <C-W>l
noremap <C-H> <C-W>h
inoremap <C-J> <Esc><C-W>j
inoremap <C-K> <Esc><C-W>k
inoremap <C-L> <Esc><C-W>l
inoremap <C-H> <Esc><C-W>h

" Shortcuts for using fuzzy find to open files
nnoremap ,fe :find *
nnoremap ,ft :tabfind *
nnoremap ,fs :sfind *
nnoremap ,fv :vert sfind *

" Shortcuts for using tabs
call Mycabbrev("tn","tabnew")
" Custom function to replace tabmove with 1-based indexed version
function! TabMove(index)
	let val = a:index-1
	if val < 0
		let val = 0
	endif
	execute "tabmove ".val
endfunction
command! -nargs=1 TM call TabMove(<f-args>)
call Mycabbrev("tm","TM")

nnoremap gr gT

" Shortcuts for using buffers
command! MyBufferDelete bp|bd# " :bd will delete buffer without deleting window
call Mycabbrev("bd","MyBufferDelete")
nnoremap ,l :ls<CR>:b<Space>

" Use arrow keys to resize split windows
nnoremap <Right> <C-W>>
nnoremap <Left> <C-W><
nnoremap <Down> <C-W>-
nnoremap <Up> <C-W>+
inoremap <Right> <Esc><C-W>>
inoremap <Left> <Esc><C-W><
inoremap <Down> <Esc><C-W>-
inoremap <Up> <Esc><C-W>+

" Commands for specific filetypes
autocmd FileType tex,rst,markdown
	\ setlocal textwidth=79
	\ spell spelllang=en_gb spellfile=./en.utf-8.add
autocmd FileType haskell setlocal expandtab
autocmd BufRead,BufNewFile *.i setlocal filetype=swig

function! ReadOnly()
	set readonly
	call LongLineHighlightOff()
	let g:tab_warning = 0
endfunction
cabbrev read call ReadOnly()

function! Edit()
	set noreadonly
	call LongLineHighlightOn()
	let g:tab_warning = 1
endfunction
cabbrev edit call Edit()

" Use ,q to show the highlight group under the cursor, allows colourscheme to
" be changed
" http://vim.wikia.com/wiki/Identify_the_syntax_highlighting_group_used_at_the_cursor
map ,q :echo "hi<" . synIDattr(synID(line("."),col("."),1),"name") . '> trans<'
\ . synIDattr(synID(line("."),col("."),0),"name") . "> lo<"
\ . synIDattr(synIDtrans(synID(line("."),col("."),1)),"name") . ">"<CR>
