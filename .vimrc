set nocompatible

filetype plugin on

" Inspired by http://vi.stackexchange.com/questions/6800/
function! Mycabbrev(lhs,rhs)
	execute printf("cnoreabbrev <expr> %s getcmdtype() ==# ':' ? '%s' : '%s'",
		\ a:lhs, a:rhs, a:lhs)
endfunction

let g:qs_highlight_on_keys = ['f', 'F', 't', 'T']

augroup gs_colors
	autocmd!
	autocmd ColorScheme * highlight QuickScopePrimary ctermfg=9
	autocmd ColorScheme * highlight QuickScopeSecondary ctermfg=57
augroup END

nnoremap gs :Git<CR><C-W>J
command! Gdall tabnew % | Git! diff
command! Gcached tabnew % | Git! diff --cached
call Mycabbrev("gda", "Gdall")
call Mycabbrev("gca", "Gcached")

call Mycabbrev("gv", "GV")
call Mycabbrev("gva", "GV --all")

" For using a.vim in LSC_AMR
let g:alternateExtensions_cpp_C = "H"

" Using vim-resizewindow for comfort
nmap <C-Up>    <Plug>ResizeWindowUp
nmap <C-Down>  <Plug>ResizeWindowDown
nmap <C-Left>  <Plug>ResizeWindowLeft
nmap <C-Right> <Plug>ResizeWindowRight
" For when term is screen-256color
nmap [A <Plug>ResizeWindowUp
nmap [B <Plug>ResizeWindowDown
nmap [C <Plug>ResizeWindowRight
nmap [D <Plug>ResizeWindowLeft

" Settings
set autoindent
set copyindent
set expandtab
set tabstop=2
set softtabstop=2 " Useful in case where I use expandtab
set shiftwidth=0 " use tabstop value for autoindenting
set number
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
set wildignore=*.swp,*.png,*.pyc,*.o,*.so,*~,*.pdf,*.db,*.eps,*.gz,*.tar
set wildmenu
set noerrorbells
set vb t_vb=
set exrc " Can put local .vimrc in project directory
set nomodeline
set secure
set timeout timeoutlen=1000 ttimeoutlen=10
set hlsearch
nohl " Make sure that on reload of vimrc the last search is not highlighted
nnoremap <silent> ,/ :nohl<CR>
set listchars=tab:>-,eol:$
nnoremap ,t :set list!<CR>
set formatoptions=tcqjroln
set synmaxcol=300
set path=**
set linebreak
set completeopt+=menuone
set commentstring=//\ %s
set diffopt+=vertical
set lazyredraw

" My custom color scheme - just some minor changes to the default settings
colo sand_solarized

nnoremap <F12> :up<CR>:colo sand_light<CR>
imap <F12> <Esc><F12>

" Turn on the mouse, for scrolling too
set mouse=n
noremap <ScrollWheelUp> 3<C-Y>
noremap <ScrollWheelDown> 3<C-E>
noremap <C-E> 3<C-E>
noremap <C-Y> 3<C-Y>
imap <C-E> <C-O><C-E>
imap <C-Y> <C-O><C-Y>
nmap <Down> <C-E>
nmap <Up>   <C-Y>
vmap <Down> <C-E>
vmap <Up>   <C-Y>
imap <Down> <C-O><C-E>
imap <Up>   <C-O><C-Y>

" Make Y behave analogously to D and C
noremap Y y$

" New line with enter - start new paragraph by hitting enter twice
nnoremap <CR> o

" Swap 0 and ^, ^ is more useful, but 0 is easier to press
nnoremap 0 ^
nnoremap ^ 0
vnoremap 0 ^
vnoremap ^ 0

" In visual mode, don't include end of line blank characters
vnoremap $ g_
vnoremap g_ $

" In visual mode, search for the selected string with //
function! SearchSelection()
	let @/ = substitute(@0, '/', '\\/', 'g')
	call search(@/)
endfunction
vnoremap <silent> // y:call SearchSelection()<CR>

" Don't lose the visual selection when adjusting indentation
vnoremap < <gv
vnoremap > >gv

" Don't copy the contents of an overwritten selection.
vnoremap p "_dP

" Don't need exec mode
noremap Q <nop>

" Prefer to use CTRL-F to access history
nnoremap q: <nop>
nnoremap q/ <nop>

" From defaults.vim - Use CTRL-G u to break undo
inoremap <C-U> <C-G>u<C-U>
inoremap <C-W> <C-G>u<C-W>

" Settings for the command window
autocmd CmdwinEnter * noremap <buffer> <CR> <CR>
autocmd CmdwinEnter * inoremap <buffer> <CR> <CR>
autocmd CmdwinEnter * noremap <buffer> <C-F> A<C-X><C-F>
autocmd CmdwinEnter * noremap <buffer> <C-E> <C-E>
autocmd CmdwinEnter * noremap <buffer> <C-Y> <C-Y>
autocmd CmdwinEnter * setlocal nonumber relativenumber
" Note that scrolloff is a global setting, so need to change it back.
" setlocal will not work in this case
autocmd CmdwinEnter * set scrolloff=0
autocmd CmdwinLeave * set scrolloff=2

" Space shortcut for cross line searching in prose
cnoremap <expr> ,<space> getcmdtype()=='/' ? '\_W\+' : ',<space>'

function! RepeatSearch()
	" Modify the contents of the register with last search pattern
	let @/ = substitute(@/, ' ', '\\_W\\+', 'g')
	" Now search for it
	call search(@/)
endfunction

nnoremap ,,/ :call RepeatSearch()<CR>

" Settings for netrw
let g:netrw_liststyle=3

" Jump through the quickfix list
function! Cnext()
	try
		cnext
	catch /^Vim\%((\a\+)\)\=:E553/
		cfirst
	catch /^Vim\%((\a\+)\)\=:E\%(325\|776\|42\):/
	endtry
endfunction

function! Cprev()
	try
		cprev
	catch /^Vim\%((\a\+)\)\=:E553/
		clast
	catch /^Vim\%((\a\+)\)\=:E\%(325\|776\|42\):/
	endtry
endfunction

nnoremap <silent> <C-N> :call Cnext()<CR>
nnoremap <silent> <C-P> :call Cprev()<CR>

function! OpenQFlist()
	let height = max([2, min([10, len(getqflist())])])
	execute "copen " . height
endfunction
nnoremap <silent> ,c :call OpenQFlist()<CR>

" Autocomplete filenames
inoremap <C-F> <C-X><C-F>
" Autocomplete using tag file
inoremap <C-]> <C-X><C-]>

" Quit command window by pressing CTRL-C once only
nnoremap <silent> <C-C> <C-C><C-C>
inoremap <silent> <C-C> <C-C><C-C>

" Use autocomplete in command mode by opening command window
cnoremap <C-N> <C-F>A<C-N>
cnoremap <C-P> <C-F>A<C-P>

" Undo autocomplete using <BS>
" This means if pumvisible() returns true do CTRL-E instead
" :help popupmenu-keys
inoremap <expr> <BS> pumvisible() ? '<C-E>' : '<BS>'
" If pop-up menu is visible, use C-J to go to search subdirectory, else add a
" line below the cursor.
inoremap <expr> <C-J> pumvisible() ? "<C-Y><C-X><C-F>" : "<Esc>m'o<Esc><C-O>a"

" Add a new line below the cursor
" inoremap <C-J> <Esc>m'o<Esc><C-O>a
" Remove line below cursor, opposite of <C-J>
inoremap <C-K> <Esc>m'jdd<Esc><C-O>a

" Use CTRL j to navigate down directories in wildmenu
set wildcharm=<Tab>
cnoremap <C-J> <Down>

" Make tags file for jumping around using <C-]> and back with <C-T>
command! MakeTags !ctags --python-kinds=-i -R .
" Open tags in vertical split rather than horizontal
nnoremap <C-W><C-]> <C-W><C-]><C-W>t<C-W>H<C-W>p
" Open tag in new tab
nnoremap <C-T><C-]> <C-W><C-]><C-W>T
" If preceding with g, use :tselect not :tjump
nnoremap g<C-]> g]
" Make a split for the tag - and go back in old window
nnoremap <C-W><C-T> :vsplit<CR><C-W>h<C-T>

" Exclamation mark avoids having to press <CR> twice after the make
nnoremap ,m :!make<CR>

" Turn off spell checking for comments in tex files
let g:tex_comment_nospell=1

" Use :x instead of :wq only write if changes have been made
call Mycabbrev("wq","x")
call Mycabbrev("w","update")
call Mycabbrev("Q","q")

cnoremap w!! w !sudo tee > /dev/null %

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

" Folding
nnoremap <space> zf
vnoremap <space> zf
nnoremap ,<space> zd

" Comfortable movement between split windows
noremap <C-J> <C-W>j
noremap <C-K> <C-W>k
noremap <C-L> <C-W>l
noremap <C-H> <C-W>h
inoremap <C-L> <Esc><C-W>l
inoremap <C-H> <Esc><C-W>h

" The above mappings overwrite CTRL-L for redrawing the screen
nnoremap <expr> ,d &diff ? '<C-L>:diffupdate<CR>' : '<C-L>'

" For whatever reason, I can never remember :diffthis and :diffoff
call Mycabbrev("diffstart", "windo diffthis")
call Mycabbrev("diffon"   , "windo diffthis")
call Mycabbrev("diffthis" , "windo diffthis")
call Mycabbrev("diffend"  , "windo diffoff")
call Mycabbrev("diffstop" , "windo diffoff")
call Mycabbrev("diffoff"  , "windo diffoff")

" Shortcuts for using fuzzy find to open files
nnoremap ,fe :find *
nnoremap ,ft :tabfind *
nnoremap ,fs :sfind *
nnoremap ,fv :vert sfind *

" Shortcuts for using tabs
call Mycabbrev("tn","tab split")
call Mycabbrev("to","TabOnly")
call Mycabbrev("tc","tabclose")
call Mycabbrev("c", "tabclose")
call Mycabbrev("tm","TabMove")

nmap H gT
nmap L gt
nnoremap K <nop>

" Shift enter should just do the same thing as enter
nmap OM <CR>
imap OM <CR>

" Shortcuts for using buffers
command! MyBufferDelete bp|bd# " :bd will delete buffer without deleting window
call Mycabbrev("bd","MyBufferDelete")
nnoremap ,l :ls<CR>:b<Space>

" Commands for specific filetypes
set spelllang=en_gb
augroup FileTypeAuCmds
	au!
	autocmd FileType cpp
		\ setlocal commentstring=\/\/\ %s |
		\ setlocal matchpairs+=<:>
	autocmd FileType tex,rst,markdown call Prose()

" Use ,q to show the highlight group under the cursor, allows colourscheme to
" be changed
" http://vim.wikia.com/wiki/Identify_the_syntax_highlighting_group_used_at_the_cursor
map ,q :echo "hi<" . synIDattr(synID(line("."),col("."),1),"name") . '> trans<'
\ . synIDattr(synID(line("."),col("."),0),"name") . "> lo<"
\ . synIDattr(synIDtrans(synID(line("."),col("."),1)),"name") . ">"<CR>
