" Mapping to quickly print variables for debugging
function! MyCppPrint()
	exec 'normal! ^y$Istd::cout << ": " << :s/,/ <</g3f:PA << std::endl;'
	try
		call repeat#set("\<Plug>MyCppPrint", v:count)
	" catch unknown function error, in case vim-repeat plugin is not installed
	catch /^Vim\%((\a\+)\)\=:E117/
	endtry
endfunction

nnoremap <buffer> <Plug>MyCppPrint :call MyCppPrint()<CR>
nmap <buffer> ,p <Plug>MyCppPrint



" std::cout << "a, b, c: " << a << b << c << std::endl


