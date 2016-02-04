" My tabline function

if exists("g:loaded_tabline") || &cp || v:version < 700
	finish
endif
let g:loaded_tabline = 1

" Function to check if the highlight group exists and has not been cleared
function! HlExists(hl)
	if !hlexists(a:hl)
		return 0
	endif
	redir => hlstatus
	exe "silent hi" a:hl
	redir END
	return (hlstatus !~ "cleared")
endfunction

" Based on the function from http://superuser.com/questions/331272/
" custom tab pages line
set tabline=%!MyTabLine()
function! MyTabLine()
	let s = '' " complete tabline goes here
	" loop through each tab page
	for t in range(tabpagenr('$'))
		" set highlight for tab numbers
		if and(HlExists("TabNumSel"), HlExists("TabNum"))
			if t + 1 == tabpagenr()
				let s .= '%#TabNumSel#'
			else
				let s .= '%#TabNum#'
			endif
		else
			" If colors for TabNum are undefined, use TabLine colors
			if t + 1 == tabpagenr()
				let s .= '%#TabLineSel#'
			else
				let s .= '%#TabLine#'
			endif
		endif
		" set the tab page number (for mouse clicks)
		let s .= '%' . (t + 1) . 'T'
		let s .= ' '
		" set page number string
		let s .= (t + 1)
		" get buffer names and statuses
		" temp string for buffer names while we loop and check buftype
		let n = ''
		let m = 0 " Set m to true if any buffer is modified

		" loop through each buffer in a tab
		for b in tabpagebuflist(t + 1)
			" buffer types: quickfix gets a [Q], help gets [H]{base fname}
			" others get 1dir/2dir/3dir/fname shortened to 1/2/3/fname
			if getbufvar( b, "&buftype" ) == 'help'
				let n .= '[H]' . fnamemodify( bufname(b), ':t:s/.txt$//' )
			elseif getbufvar( b, "&buftype" ) == 'quickfix'
				let n .= '[Q]'
			else
				let n .= pathshorten(bufname(b))
			endif
			" check and set modified boolean
			if getbufvar( b, "&modified" )
				let m = 1
			endif
			let n .= ' '
		endfor
		" add modified label [+] where pages are modified
		if m > 0
			let s .= '[+]'
		endif
		let s .= ': ' " Add separator between tab number and name
		" select the highlighting for the buffer names
		if t + 1 == tabpagenr()
			let s .= '%#TabLineSel#'
		else
			let s .= '%#TabLine#'
		endif
		let s .= n
	endfor
	" after the last tab fill with TabLineFill and reset tab page nr
	let s .= '%#TabLineFill#%T'
	return s
endfunction
