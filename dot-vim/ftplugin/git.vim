
function! s:MoveToFile(flags)
	let l = search("^diff --git", a:flags)
	return l ? printf("%dG", l) : ''
endfunction

nnoremap <silent> <buffer> <expr> <C-N> <sid>MoveToFile('')
nnoremap <silent> <buffer> <expr> <C-P> <sid>MoveToFile('b')
