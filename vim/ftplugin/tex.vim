" Some shortcuts for constructing latex environments
"

function! Environment()
	exec 'normal! yyI\begin{A}
	exec "normal! ki\<tab>"
endfunction

function! FigSkeleton()
	exec 'normal! ifigure'
	call Environment()
	exec 'normal! A\centering
endfunction

nnoremap ,env :call Environment()<CR>
nnoremap ,fig :call FigSkeleton()<CR>
inoremap ,env <Esc>:call Environment()<CR>
inoremap ,fig <Esc>:call FigSkeleton()<CR>