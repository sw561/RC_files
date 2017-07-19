" Want to block the setting of expandtab which is done in default
" usr/share/vim/vim74/ftplugin/python.vim
let b:did_ftplugin = 1
setlocal commentstring=#%s

" Mapping to quickly print variables for debugging
nnoremap <buffer> ,p ^y$Iprint("<Esc>A:", <Esc>pA)<Esc>j
