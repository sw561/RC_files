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
	for tforwards in range(tabpagenr('$'))
		let t = tabpagenr('$') - tforwards - 1
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
		let s .= (tforwards + 1)
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
				let n .= strpart(pathshorten(bufname(b)), 0, 20)
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
		let s .= '%#TabLine# '
	endfor
	" after the last tab fill with TabLineFill and reset tab page nr
	let s .= '%#TabLineFill#%T'
	return s
endfunction

nnoremap gt gT
nnoremap gT gt

" Credit to https://stackoverflow.com/questions/14079149/vim-automatically-show-left-tab-after-closing-tab

let s:prevtabtotal=tabpagenr('$')
let s:prevtabnum=tabpagenr()
function! MoveLeftMaybe()
	if tabpagenr('$') > s:prevtabtotal && tabpagenr() == s:prevtabnum+1
		tabmove -1
	endif
	let s:prevtabtotal = tabpagenr('$')
	let s:prevtabnum = tabpagenr()
endfunction

augroup TabClosed
	au!
	autocmd TabEnter * call MoveLeftMaybe()
augroup END

function! TabMove(index)
	" Only works after vim patch 7.4.709, which modified the behaviour of
	" tabmove
	"
	" :tabmove N moves tab to after the Nth tab (zero
	" indexed) as opposed to moving the tab to the Nth position. The
	" difference is that if the current tab is the 2nd, then :tabmove 1 and
	" :tabmove 2 will both leave the tab unmoved.
	"
	" I prefer to specify the desired destination index when moving my tabs.
	"
	" Furthermore, we are using a reversed image of the tabline

	if a:index == '$'
		execute "tabmove 0"
		return
	endif

	" Current tab nr displayed on screen
	let display = tabpagenr('$') - tabpagenr() + 1
	if a:index < display
		let val = tabpagenr('$') - a:index + 1
		execute "tabmove ".val
	elseif a:index > display
		let val = tabpagenr('$') - a:index
		execute "tabmove ".val
	endif
endfunction

command! -nargs=1 TM call TabMove(<f-args>)
