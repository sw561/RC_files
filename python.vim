" Want to block the setting of expandtab which is done in default
" usr/share/vim/vim74/ftplugin/python.vim
let b:did_ftplugin = 1
setlocal commentstring=#%s

" Mapping to quickly print variables for debugging
nnoremap <buffer> ,p ^y$Iprint("<Esc>A:", <Esc>pA)<Esc>j

" Mapping to update import paths for python formatting
" replace / with . and
function! PythonifyPath()
	" Remove trailing .py
	.s/\.py\>//ge
	.s/\//\./ge
endfunction
nnoremap <buffer> ,im :call PythonifyPath()<CR>
