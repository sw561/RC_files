" Want to block the setting of expandtab which is done in default
" usr/share/vim/vim74/ftplugin/python.vim
let b:did_ftplugin = 1
setlocal commentstring=#%s

setlocal suffixesadd=.py

" Mapping to quickly print variables for debugging
function! MyPythonPrint()
	exec 'normal! ^y$Iprint("A:", pA)j'
	try
		call repeat#set("\<Plug>MyPythonPrint", v:count)
	" catch unknown function error, in case vim-repeat plugin is not installed
	catch /^Vim\%((\a\+)\)\=:E117/
	endtry
endfunction

nnoremap <buffer> <Plug>MyPythonPrint :call MyPythonPrint()<CR>
nmap ,p <Plug>MyPythonPrint

" Mapping to update import paths for python formatting
" replace / with . and
function! PythonifyPath()
	" Remove trailing .py
	keeppatterns .s/\.py\>//ge
	keeppatterns .s/\//\./ge
endfunction
nnoremap <buffer> ,im :call PythonifyPath()<CR>$
inoremap <buffer> <expr> ,im pumvisible() ? '<Esc>:call PythonifyPath()<CR>A' : ',im'

function! Pep8()
	set expandtab
	set softtabstop=4
	set shiftwidth=4
endfunction

function! AddPdb()
	exec 'normal! Oimport pdb; pdb.set_trace()'
endfunction

nnoremap <buffer> ,pdb :call AddPdb()<CR>
