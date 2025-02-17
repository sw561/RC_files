set nocompatible

syntax enable

filetype plugin on

" For plugins
" " https://github.com/google/vim-searchindex.git
" set runtimepath+=~/.vim/bundle/vim-searchindex
" https://github.com/unblevable/quick-scope.git
set runtimepath+=~/.vim/bundle/quick-scope
" https://github.com/tpope/vim-commentary.git
set runtimepath+=~/.vim/bundle/vim-commentary
" https://github.com/tpope/vim-repeat.git
set runtimepath+=~/.vim/bundle/vim-repeat
" https://github.com/tpope/vim-fugitive.git
set runtimepath+=~/.vim/bundle/vim-fugitive
" https://github.com/nacitar/a.vim.git
set runtimepath+=~/.vim/bundle/a.vim
" https://github.com/sw561/vim-resizewindow.git
set runtimepath+=~/.vim/bundle/vim-resizewindow
" https://github.com/junegunn/gv.vim.git
set runtimepath+=~/.vim/bundle/gv.vim
" https://github.com/tpope/vim-eunuch.git
set runtimepath+=~/.vim/bundle/vim-eunuch
" https://github.com/tpope/vim-rhubarb.git
set runtimepath+=~/.vim/bundle/vim-rhubarb

" Alternative to my own trim plugin
" https://github.com/axelf4/vim-strip-trailing-whitespace.git
set runtimepath+=~/.vim/bundle/vim-strip-trailing-whitespace

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
nmap [1;5A <Plug>ResizeWindowUp
nmap [1;5B <Plug>ResizeWindowDown
nmap [1;5C <Plug>ResizeWindowRight
nmap [1;5D <Plug>ResizeWindowLeft

" Settings
set autoindent
set copyindent
set noexpandtab
set tabstop=4
set softtabstop=4 " Useful in case where I use expandtab
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
set shortmess-=S " Give count of matches when searching
set virtualedit=block

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
noremap <PageUp> 15<C-Y>
noremap <PageDown> 15<C-E>
imap <PageUp> <C-O><PageUp>
imap <PageDown> <C-O><PageDown>

" Make Y behave analogously to D and C
noremap Y y$

" New line with enter - start new paragraph by hitting enter twice
nnoremap <CR> o
nmap OM <CR>
inoremap OM <CR>

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
	let @/ = escape(@0, '/[]')
	call search(@/)
	call getreg('/')->histadd("search")
endfunction
vnoremap <silent> // y:call SearchSelection()<CR>:set hls<CR>

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
inoremap <C-K> <C-G>u<Esc>m'jdd<Esc><C-O>a

" For digraphs
" inoremap <C-I> <C-K>

" Use CTRL j to navigate down directories in wildmenu
set wildcharm=<Tab>
cnoremap <C-J> <Down>

" Make tags file for jumping around using <C-]> and back with <C-T>
command! MakeTags !ctags -R .
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

tmap <C-H> <C-W>N<C-H>a
tmap <C-J> <C-W>N<C-J>a
tmap <C-K> <C-W>N<C-K>a
tmap <C-L> <C-W>N<C-L>a

tmap <Esc> <C-W>N
" function! TerminalOptions()
" 	silent! au BufEnter <buffer> startinsert!
" 	silent! au BufLeave <buffer> stopinsert!
" endfunction
" au TerminalOpen * call TerminalOptions()
call Mycabbrev("vterm", "vert terminal")

" The above mappings overwrite CTRL-L for redrawing the screen
nnoremap <expr> ,d &diff ? '<C-L>:diffupdate<CR>' : '<C-L>'

" For whatever reason, I can never remember :diffthis and :diffoff
call Mycabbrev("diffstart", "windo diffthis")
call Mycabbrev("diffon", "windo diffthis")
call Mycabbrev("diffend", "windo diffoff")
call Mycabbrev("diffstop", "windo diffoff")

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

" Shortcuts for using buffers
command! MyBufferDelete bp|bd# " :bd will delete buffer without deleting window
call Mycabbrev("bd","MyBufferDelete")
nnoremap ,l :ls<CR>:b<Space>

function! GetModTime()
	echo strftime('%c',getftime(expand('%')))
endfunction

command! GM call GetModTime()

command! CD cd %:h

" Commands for specific filetypes
set spelllang=en_gb
augroup FileTypeAuCmds
	au!
	autocmd FileType cpp
		\ setlocal commentstring=\/\/\ %s |
		\ setlocal matchpairs+=<:>
	autocmd FileType tex,rst,markdown call Prose()

	autocmd FileType haskell setlocal expandtab
	autocmd BufRead,BufNewFile *.i setlocal filetype=swig
	autocmd BufRead,BufNewFile *.gp setlocal filetype=gnuplot
	autocmd FileType git setlocal foldlevel=1
	autocmd BufRead,BufNewFile *.tex,*.pdf_tex setlocal filetype=tex
	autocmd BufRead,BufNewFile *.out setlocal nowrap
	autocmd FileType cmake setlocal commentstring=#%s
	autocmd FileType vim setlocal noet
augroup END

function! Prose()
	setlocal textwidth=79
	let g:searchindex_star_case=0
	if !&readonly
		setlocal spell
	endif
	set spellfile=./en.utf-8.add |
endfunction

" vim -b : edit binary using xxd-format!
augroup Binary
	au!
	au BufReadPre   *.bin,*.bmp,*.gif,*.crypt let &bin=1
	au BufReadPost  *.bin,*.bmp,*.gif,*.crypt if &bin | %!xxd
	au BufReadPost  *.bin,*.bmp,*.gif,*.crypt set ft=xxd | endif
	au BufWritePre  *.bin,*.bmp,*.gif,*.crypt if &bin | %!xxd -r
	au BufWritePre  *.bin,*.bmp,*.gif,*.crypt endif
	au BufWritePost *.bin,*.bmp,*.gif,*.crypt if &bin | %!xxd
	au BufWritePost *.bin,*.bmp,*.gif,*.crypt set nomod | endif
augroup END

function! Skeleton_Candidates(ArgLead, CmdLine, CursorPos)
	return "python\npython3\ncodejam\ncpp\nMakefile\ngnuplot\nbash\ntex\ngo"
endfunction

" Skeleton files
function! Skeleton(name)
	setlocal autoread
	if a:name == "python"
		0read ~/RC_files/skeleton/python.py
		write
		!chmod u+x %
	elseif a:name == "python3"
		0read ~/RC_files/skeleton/python3.py
		write
		!chmod u+x %
	elseif a:name =="codejam"
		0read ~/RC_files/skeleton/codejam.py
		write
		!chmod u+x %
	elseif a:name == "cpp"
		0read ~/RC_files/skeleton/cpp.cpp
		write
	elseif a:name == "Makefile"
		0read ~/RC_files/skeleton/Makefile
		write
	elseif a:name == "gnuplot"
		0read ~/RC_files/skeleton/gp.gp
		write
	elseif a:name == "bash"
		0read ~/RC_files/skeleton/bash.sh
		write
		silent !chmod u+x %
	elseif a:name == "tex"
		0read ~/RC_files/skeleton/tex.tex
		write
	elseif a:name == "go"
		0read ~/RC_files/skeleton/go.go
		write
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
	setlocal readonly
	setlocal nomodifiable
	setlocal norelativenumber
	setlocal nospell
	if (v:version < 704)
		set number
	endif
endfunction

function! Edit()
	setlocal modifiable
	setlocal noreadonly
	setlocal relativenumber
	if &filetype == "tex" || &filetype == "rst" || &filetype == "markdown"
	  setlocal spell
	endif
endfunction

nnoremap ,r :call ReadOnly()<CR>
nnoremap ,e :call Edit()<CR>

" Prefer not to see filetype in statusbar
let g:status_filetype = 0

" Use ,q to show the highlight group under the cursor, allows colourscheme to
" be changed
" http://vim.wikia.com/wiki/Identify_the_syntax_highlighting_group_used_at_the_cursor
map ,q :echo "hi<" . synIDattr(synID(line("."),col("."),1),"name") . '> trans<'
\ . synIDattr(synID(line("."),col("."),0),"name") . "> lo<"
\ . synIDattr(synIDtrans(synID(line("."),col("."),1)),"name") . ">"<CR>
