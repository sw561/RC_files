set ignorecase
set nosmartcase
let g:searchindex_star_case=0

" Mapping to quickly print variables for debugging
function! MyFortranPrint()
	exec 'normal! ^y$Iwrite (*,*) "A", pj'
	try
		call repeat#set("\<Plug>MyFortranPrint", v:count)
	" catch unknown function error, in case vim-repeat plugin is not installed
	catch /^Vim\%((\a\+)\)\=:E117/
	endtry
endfunction

nnoremap <buffer> <Plug>MyFortranPrint :call MyFortranPrint()<CR>
nmap ,p <Plug>MyFortranPrint
