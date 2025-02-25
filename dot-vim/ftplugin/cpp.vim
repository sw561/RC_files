" Mapping to quickly print variables for debugging
function! MyCppPrint()
	exec 'normal! ^y$Istd::cout << "A: " << pA << std::endl;j'
	try
		call repeat#set("\<Plug>MyCppPrint", v:count)
	" catch unknown function error, in case vim-repeat plugin is not installed
	catch /^Vim\%((\a\+)\)\=:E117/
	endtry
endfunction

nnoremap <buffer> <Plug>MyCppPrint :call MyCppPrint()<CR>
nmap <buffer> ,p <Plug>MyCppPrint



" std::cout << "a, b, c: " << a << b << c << std::endl

  " std::cout << "a : " << a << std::endl;

" 0y$Istd::cout << "A: " << pA<< std::endl;
