" My custom color scheme - just some minor changes to the default settings
colo blueblack

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

" Turn on the mouse, for scrolling too
set mouse=a
noremap <ScrollWheelUp> 3<C-Y>
noremap <ScrollWheelDown> 3<C-E>
noremap <C-E> 3<C-E>
noremap <C-Y> 3<C-Y>
imap <C-E> <Esc><C-E>
imap <C-Y> <Esc><C-Y>

" Make Y behave analogously to D and C
noremap Y y$

" New line with enter - start new paragraph by hitting enter twice
nnoremap <CR> o

" In visual mode, don't include end of line blank characters
vnoremap $ g_

" In visual mode, search for the selected string with //
vnoremap // y/<C-R>0<CR>

" Don't need exec mode
noremap Q <nop>
" Don't open command line when trying to quit
noremap q: <nop>

autocmd VimEnter,BufWinEnter,WinEnter * setlocal cursorline
autocmd WinLeave * setlocal nocursorline

" Exclamation mark avoids having to press <CR> twice after the make
nnoremap ,m :!make<CR>

" Turn off spell checking for comments in tex files
let g:tex_comment_nospell=1

" Set all three of shiftwidth, softtabstop and tabstop
function! SetTab(value)
	let &shiftwidth  = a:value
	let &softtabstop = a:value
	let &tabstop     = a:value
endfunction
call SetTab(4)

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
cabbrev tn tabnew
nnoremap gr gT

" Shortcuts for using buffers
command! MyBufferDelete bp|bd# " :bd will delete buffer without deleting window
cabbrev bd MyBufferDelete
nnoremap ,l :ls<CR>:b

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
