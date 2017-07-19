filetype plugin on

" For plugins
" https://github.com/google/vim-searchindex.git
set runtimepath+=~/.vim/bundle/vim-searchindex
" https://github.com/moorereason/quick-scope.git -b protect-higroup
set runtimepath+=~/.vim/bundle/quick-scope
" https://github.com/tpope/vim-commentary.git
set runtimepath+=~/.vim/bundle/vim-commentary

let g:qs_first_occurrence_highlight_color = 9
let g:qs_second_occurrence_highlight_color = 5
let g:qs_highlight_on_keys = ['f', 'F', 't', 'T']

" Settings
set autoindent
set copyindent
set noexpandtab
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
set wildignore=*.swp,*.png,*.pyc,*.o,*.so,*~,*.pdf,*.db,*.eps
set wildmenu
set noerrorbells
set vb t_vb=
set exrc " Can put local .vimrc in project directory
set timeout timeoutlen=1000 ttimeoutlen=10
set hlsearch
nohl " Make sure that on reload of vimrc the last search is not highlighted
nnoremap <silent> ,/ :nohl<CR>
set listchars=tab:>-,eol:$
nnoremap ,t :set list!<CR>
set formatoptions+=jroln
set synmaxcol=300
set path=**
set linebreak

" My custom color scheme - just some minor changes to the default settings
colo sand

nnoremap <F12> :up<CR>:colo sand<CR>
imap <F12> <Esc><F12>

" Turn on the mouse, for scrolling too
set mouse=n
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

" Swap 0 and ^, ^ is more useful, but 0 is easier to press
nnoremap 0 ^
nnoremap ^ 0

" In visual mode, don't include end of line blank characters
vnoremap $ g_
vnoremap g_ $

" In visual mode, search for the selected string with //
vnoremap // y/<C-R>0<CR>
nmap * viw//

" Don't lose the visual selection when adjusting indentation
vnoremap < <gv
vnoremap > >gv

" Don't need exec mode
noremap Q <nop>
" Don't open command line when trying to quit
noremap q: <nop>

" From defaults.vim - Use CTRL-G u to break undo
inoremap <C-U> <C-G>u<C-U>

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

" Tab shortcut for cross line searching in prose
cnoremap <expr> ,<space> getcmdtype()=='/' ? '\_W\+' : ',<space>'

function! RepeatSearch()
	" Modify the contents of the register with last search pattern
	let @/ = substitute(@/, ' ', '\\_W\\+', 'g')
	" Now search for it
	call search(@/)
endfunction

command! S call RepeatSearch()
nnoremap ,,/ :call RepeatSearch()<CR>

" Settings for netrw
let g:netrw_liststyle=3
let g:netrw_browse_split=3

" Autocomplete works in normal mode too
" See :help ins-completion
nnoremap <C-N> viw<Esc>`>a<C-N>
nnoremap <C-P> viw<Esc>`>a<C-P>
inoremap <C-F> <C-X><C-F>
inoremap <C-]> <C-X><C-]>

" Quit command window by pressing CTRL-C once only
nnoremap <silent> <C-C> <C-C><C-C>
inoremap <silent> <C-C> <C-C><C-C>

" Use autocomplete in command mode by opening command window
cmap <C-N> <C-F><C-N>
cmap <C-P> <C-F><C-P>

" Undo autocomplete using <BS>
" This means if pumvisible() returns true do CTRL-E instead
" :help popupmenu-keys
inoremap <expr> <BS> pumvisible() ? '<C-E>' : '<BS>'
inoremap <expr> <CR> pumvisible() ? '<C-Y>' : '<CR>'

" Use CTRL j to navigate down directories in wildmenu
set wildcharm=<Tab>
cnoremap <C-J> <Down>

" Make tags file for jumping around using <C-]> and back with <C-T>
command! MakeTags !ctags -R .
" Open tags in vertical split rather than horizontal
nnoremap <C-W><C-]> <C-W><C-]><C-W>t<C-W>H<C-W>l
" Open tag in new tab
nnoremap <C-T><C-]> <C-W><C-]><C-W>T
" If preceding with g, use :tselect not :tjump
nnoremap g<C-]> g]
" Make a split for the tag - and go back in old window
nnoremap <C-W><C-T> :vsplit<CR><C-W>h<C-T>

autocmd VimEnter,WinEnter,BufEnter * setlocal cursorline
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

" Folding
nnoremap <space> zf
vnoremap <space> zf
nnoremap ,<space> zd

" Comfortable movement between split windows
noremap <C-J> <C-W>j
noremap <C-K> <C-W>k
noremap <C-L> <C-W>l
noremap <C-H> <C-W>h
inoremap <C-J> <Esc><C-W>j
inoremap <C-K> <Esc><C-W>k
inoremap <C-L> <Esc><C-W>l
inoremap <C-H> <Esc><C-W>h

" The above mappings overwrite CTRL-L for redrawing the screen
noremap ,d <C-L>

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
function! TabMoveNew(index)
	" New implementation of custom tabmove function to account for the change
	" in behaviour which starts in vim patch 7.4.709
	"
	" This change means that :tabmove N moves tab to after the Nth tab (zero
	" indexed) as opposed to moving the tab to the Nth position. The
	" difference is that if the current tab is the 2nd, then :tabmove 1 and
	" :tabmove 2 will both leave the tab unmoved.
	"
	" I prefer to specify the desired destination index when moving my tabs.
	if a:index == '$'
		execute "tabmove $"
		return
	endif
	if a:index >= tabpagenr() || a:index == 0
		let val = a:index
	else
		let val = a:index-1
	endif
	execute "tabmove ".val
endfunction
if has('patch709')
	command! -nargs=1 TM call TabMoveNew(<f-args>)
else
	command! -nargs=1 TM call TabMove(<f-args>)
endif
call Mycabbrev("tm","TM")

nnoremap gr gT
nnoremap H gT
nnoremap L gt

" Split windows without scrolling, assumes splitbelow is set
" Inspired by stackoverflow.com/questions/12897276/
function! MySplit(...)
	normal! Hmx``
	if a:0 > 0
		exec "split " . a:1
		normal! k`xzt``j
	else
		split
		normal! k`xzt``j`xzt``
	endif
endfunction

nnoremap <C-W>s :call MySplit()<CR>
nnoremap <C-W><C-S> :call MySplit()<CR>
command! -nargs=? -complete=file_in_path Split call MySplit(<f-args>)
call Mycabbrev("s", "Split")
call Mycabbrev("sp", "Split")
call Mycabbrev("spl", "Split")
call Mycabbrev("spli", "Split")
call Mycabbrev("split", "Split")

" Shortcuts for using buffers
command! MyBufferDelete bp|bd# " :bd will delete buffer without deleting window
call Mycabbrev("bd","MyBufferDelete")
nnoremap ,l :ls<CR>:b<Space>

" Use arrow keys to resize split windows or to scroll
nmap <Down> <C-E>
nmap <Up> <C-Y>
imap <Down> <Esc><C-E>
imap <Up> <Esc><C-Y>
nnoremap [A <C-W>+
nnoremap [B <C-W>-
nnoremap [C <C-W>>
nnoremap [D <C-W><

" Commands for specific filetypes
set spelllang=en_gb
autocmd FileType cpp setlocal commentstring=\/\/\ %s
autocmd FileType tex,rst,markdown
	\ setlocal textwidth=79
	\ spell spellfile=./en.utf-8.add
autocmd FileType haskell setlocal expandtab
autocmd BufRead,BufNewFile *.i setlocal filetype=swig
autocmd FileType gp setlocal commentstring=#%s comments+=",#"

" vim -b : edit binary using xxd-format!
augroup Binary
  au!
  au BufReadPre  *.bin,*.bmp let &bin=1
  au BufReadPost *.bin,*.bmp if &bin | %!xxd
  au BufReadPost *.bin,*.bmp set ft=xxd | endif
  au BufWritePre *.bin,*.bmp if &bin | %!xxd -r
  au BufWritePre *.bin,*.bmp endif
  au BufWritePost *.bin,*.bmp if &bin | %!xxd
  au BufWritePost *.bin,*.bmp set nomod | endif
augroup END

function! Skeleton_Candidates(ArgLead, CmdLine, CursorPos)
	return "python\npython3\ncpp\nMakefile\ngnuplot\nbash"
endfunction

" Skeleton files
function! Skeleton(name)
	setlocal autoread
	if a:name == "python"
		0read ~/RC_files/python_skeleton.py
		write
		silent !chmod u+x %
	elseif a:name == "python3"
		0read ~/RC_files/python3_skeleton.py
		write
		!chmod u+x %
	elseif a:name == "cpp"
		0read ~/RC_files/cpp_skeleton.cpp
		write
	elseif a:name == "Makefile"
		0read ~/RC_files/Makefile_skeleton
		write
	elseif a:name == "gnuplot"
		0read ~/RC_files/gp_skeleton.gp
		write
	elseif a:name == "bash"
		0read ~/RC_files/bash_skeleton.sh
		write
		silent !chmod u+x %
	else
		echohl WarningMsg | echo "Argument not understood" | echohl None
	endif
	setlocal noautoread
endfunction
command! -nargs=1 -complete=custom,Skeleton_Candidates Sk call Skeleton(<f-args>)
call Mycabbrev("sk","Sk")

" Tiny plugin to make writing class constructors easy in python
" Put the cursor on a line which looks like: (you can try it right here)
"	>>> def __init__(self, a, b, c):
" Then type ,init and see what happens
function! PutSelf()
	exec "normal! i\<tab>\<tab>self.\<esc>lyiwA = \<esc>p"
endfunction
nnoremap ,init 0f(lyi(o<Esc>p0df V:s/, /\r/ge<CR>:nohl<CR>V'<:call PutSelf()<CR>

" In versions of vim older than 7.4 relativenumber and number cannot be
" combined. As a result to switch to number, it is not sufficient to turn off
" relativenumber, number also has to be set.

function! ReadOnly()
	set readonly
	call LongLineHighlightOff()
	set norelativenumber
	if (v:version < 704)
		set number
	endif
endfunction
call Mycabbrev("read","call ReadOnly()")

function! Edit()
	if !&readonly
		return
	endif
	set noreadonly
	call LongLineHighlightOn()
	set relativenumber
endfunction
call Mycabbrev("edit","call Edit()")

function! ToggleRead()
	if &readonly
		call Edit()
	else
		call ReadOnly()
	endif
endfunction
nnoremap ,r :call ToggleRead()<CR>

function! CheckReadOnly()
	if !&modifiable
		return
	endif
	if &readonly || &diff
		set norelativenumber
		if (v:version < 704)
			set number
		endif
	else
		set relativenumber
	endif
endfunction
autocmd BufEnter,WinEnter,VimEnter * call CheckReadOnly()
autocmd InsertEnter * call Edit()

" Prefer not to see filetype in statusbar
let g:status_filetype = 0

" Use ,q to show the highlight group under the cursor, allows colourscheme to
" be changed
" http://vim.wikia.com/wiki/Identify_the_syntax_highlighting_group_used_at_the_cursor
map ,q :echo "hi<" . synIDattr(synID(line("."),col("."),1),"name") . '> trans<'
\ . synIDattr(synID(line("."),col("."),0),"name") . "> lo<"
\ . synIDattr(synIDtrans(synID(line("."),col("."),1)),"name") . ">"<CR>
