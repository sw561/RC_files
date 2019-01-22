
nnoremap <buffer> <C-N> :cnext<CR><C-W><C-W>
nnoremap <buffer> <C-P> :cprevious<CR><C-W><C-W>
nnoremap <buffer> q :cclose<CR>
noremap <buffer> <C-E> <C-E>
noremap <buffer> <C-Y> <C-Y>

function! MyOpen()
	execute "cc ".line('.')
endfunction

nnoremap <buffer> o :call MyOpen()<CR><C-W><C-W>

setlocal norelativenumber
