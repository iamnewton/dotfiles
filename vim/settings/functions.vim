" Tab completion
" will insert tab at beginning of line,
" will use completion if not at beginning
" https://github.com/thoughtbot/dotfiles/blob/master/vimrc#L98-L111
function! InsertTabWrapper()
	let col = col('.') - 1
	if !col || getline('.')[col - 1] !~ '\k'
		return "\<tab>"
	else
		return "\<c-p>"
	endif
endfunction

" http://stackoverflow.com/a/4294176/1536779
" Creates a folder/file from current buffer if it doesn't exist
function s:MkNonExDir(file, buf)
	if empty(getbufvar(a:buf, '&buftype')) && a:file!~#'\v^\w+\:\/'
		let dir=fnamemodify(a:file, ':h')
		if !isdirectory(dir)
			call mkdir(dir, 'p')
		endif
	endif
endfunction
augroup BWCCreateDir
	autocmd!
	autocmd BufWritePre * :call s:MkNonExDir(expand('<afile>'), +expand('<abuf>'))
augroup END

function! FoldText()
	let line = getline(v:foldstart)

	let nucolwidth = &fdc + &number * &numberwidth
	let windowwidth = winwidth(0) - nucolwidth - 3
	let foldedlinecount = v:foldend - v:foldstart

	" expand tabs into spaces
	let onetab = strpart('          ', 0, &tabstop)
	let line = substitute(line, '\t', onetab, 'g')

	let line = strpart(line, 0, windowwidth - 2 -len(foldedlinecount))
	let fillcharcount = windowwidth - len(line) - len(foldedlinecount) - 4
	return line . ' …' . repeat(" ",fillcharcount) . foldedlinecount . ' '
endfunction

function! FoldColumnToggle()
	if &foldcolumn
		let g:last_fold_column_width = &foldcolumn
		setlocal foldcolumn=0
	else
		let &l:foldcolumn = g:last_fold_column_width
	endif
endfunction

function! TabToggle()
	if &expandtab
		set shiftwidth=4
		set softtabstop=4
		set tabstop=4
		set noexpandtab
		set list
	else
		set shiftwidth=2
		set softtabstop=2
		set tabstop=2
		set expandtab
		set nolist
	endif
endfunction
