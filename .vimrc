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
set wildignore=*.swp,*.png,*.pyc,*.o,*.so,*~,*.pdf
set wildmenu
set noerrorbells
set vb t_vb=

set laststatus=2            "statusline displayed always
set statusline=%t           "tail of the filename
set statusline+=%m          "modified flag
set statusline+=%r          "read only flag
set statusline+=%y          "filetype
set statusline+=%=          "left/right separator
set statusline+=%l          "cursor line
set statusline+=/%L,        "total number of lines
set statusline+=%-10.10c    "cursor column

" Turn on the mouse, for scrolling too
set mouse=a
noremap <ScrollWheelUp> 3<C-Y>
noremap <ScrollWheelDown> 3<C-E>

noremap <C-E> 3<C-E>
noremap <C-Y> 3<C-Y>

" Don't need exec mode
noremap Q <nop>

autocmd VimEnter,BufWinEnter,WinEnter * setlocal cursorline
autocmd WinLeave * setlocal nocursorline

" Avoid having to press <CR> twice after the make
cnoremap make !make

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

" Use arrow keys to resize split windows
nnoremap <Right> <C-W>>
nnoremap <Left> <C-W><
nnoremap <Down> <C-W>-
nnoremap <Up> <C-W>+
inoremap <Right> <Esc><C-W>>
inoremap <Left> <Esc><C-W><
inoremap <Down> <Esc><C-W>-
inoremap <Up> <Esc><C-W>+

" In visual mode, don't include end of line blank characters
vnoremap $ g_

" Commands for specific filetypes
autocmd FileType tex,rst,markdown
	\ setlocal textwidth=79
	\ spell spelllang=en_gb spellfile=./en.utf-8.add
autocmd FileType haskell setlocal expandtab
autocmd BufRead,BufNewFile *.i setlocal filetype=swig
