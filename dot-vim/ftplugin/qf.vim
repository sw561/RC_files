
nnoremap <silent> <buffer> <C-N> :call Cnext()<CR><C-W><C-W>
nnoremap <silent> <buffer> <C-P> :call Cprev()<CR><C-W><C-W>
nnoremap <buffer> q :cclose<CR>
noremap <buffer> <C-E> <C-E>
noremap <buffer> <C-Y> <C-Y>

function! MyOpen()
	execute "cc ".line('.')
endfunction

nnoremap <buffer> o :call MyOpen()<CR><C-W><C-W>

setlocal norelativenumber
