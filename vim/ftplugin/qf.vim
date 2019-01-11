
nnoremap <buffer> <C-N> :cnext<CR><C-W><C-W>
nnoremap <buffer> <C-P> :cprevious<CR><C-W><C-W>
nnoremap <buffer> q :cclose<CR>

function! MyOpen()
	execute "cc ".line('.')
endfunction

nnoremap <buffer> o :call MyOpen()<CR><C-W><C-W>

setlocal norelativenumber
