" Some shortcuts for constructing latex environments

function! Environment()
	exec 'normal! yyI\begin{A}pI\end{A}'
	exec "normal! ki\<tab>"
endfunction

function! FigSkeleton()
	exec 'normal! ifigure'
	call Environment()
	exec 'normal! A\centering\includegraphics{}\caption{}\label{fig:}'
endfunction

nnoremap ,env :call Environment()<CR>
nnoremap ,fig :call FigSkeleton()<CR>
inoremap ,env <Esc>:call Environment()<CR>
inoremap ,fig <Esc>:call FigSkeleton()<CR>

set wildignore-=*.pdf
set wildignore-=*.eps
set wildignore-=*.png
set wildignore+=*blx.bib,*.xml,*.aux,*.bbl,*.blg,*.log,*.out,*.toc,*.lof,*.lot,*.nlo,*.nls,*.ilg

syn region texRefZone	matchgroup=texStatement start="\\cref{"	end="}\|%stopzone\>"	contains=@texRefGroup
syn region texRefZone	matchgroup=texStatement start="\\fullcite{"	end="}\|%stopzone\>"	contains=@texRefGroup

" Clear these slow syntax highlighting groups
syn clear texString
syn clear texSubSectionZone
syn clear texSectionZone
syn clear texOption
syn clear texLength
