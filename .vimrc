set tabstop=4
set autoindent
set number

set cursorline

set mouse=a
map <ScrollWheelUp> <C-Y>
map <ScrollWheelDown> <C-E>

set noerrorbells
set vb t_vb=

autocmd BufRead,BufNewFile *.tex set textwidth=80
autocmd BufRead,BufNewFile *.hs set expandtab

match ErrorMsg '\s\+$'
