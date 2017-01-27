" My statusline function

if exists("g:loaded_statusline") || &cp || v:version < 700
	finish
else
	let g:loaded_statusline = 1
endif

" Show a warning if tabs and spaces have been mixed
" This will also inform you if the expandtab setting doesn't match the file
if !exists("g:tab_warning")
	let g:tab_warning = 1
endif
if !exists("g:status_filetype")
	let g:status_filetype = 1
endif
if !exists("g:status_fileformat")
	let g:status_fileformat = 1
endif

set laststatus=2                "statusline displayed always
set statusline=\ %t             "tail of the filename
set statusline+=%m              "modified flag
set statusline+=%r              "read only flag
set statusline+=%{MyFileType()} "filetype
set statusline+=%{DosWarning()}

"display a warning if &et is wrong, or we have mixed-indenting
set statusline+=\ %#ErrorMsg#
set statusline+=%{TabWarning()}
set statusline+=%*

set statusline+=%=          "left/right separator
set statusline+=%l          "cursor line
set statusline+=/%L,        "total number of lines
set statusline+=%-10.10c    "cursor column

function! MyFileType()
	if g:status_filetype
		return '[' . &filetype . ']'
	else
		return ''
	endif
endfunction

function! TabWarning()
	if g:tab_warning==0 || !&modifiable || &readonly
		return ''
	endif
	let b:statusline_tab_warning = ''

	let tabs = search('^\t', 'nw') != 0

	"find spaces that arent used as alignment in the first indent column
	let spaces = search('^ \{' . &ts . ',}[^\t]', 'nw') != 0

	if tabs && spaces
		let b:statusline_tab_warning =	' [mixed-indenting] '
	elseif (spaces && !&et) || (tabs && &et)
		if &et
			let b:statusline_tab_warning = ' [expandtab] '
		else
			let b:statusline_tab_warning = ' [noexpandtab] '
		endif
	endif
	return b:statusline_tab_warning
endfunction

function! DosWarning()
	if g:status_fileformat && &fileformat!="unix"
		return ' [' . &fileformat . ']'
	endif
	return ''
endfunction
