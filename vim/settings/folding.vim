if ("folding")
	" enable folding
	set foldenable
	" add a fold column
	set foldcolumn=2
	" detect triple-{ style fold markers
	set foldmethod=marker
	" start out with everything unfolded
	set foldlevelstart=99
	" which commands trigger auto-unfold
	set foldopen=block,hor,insert,jump,mark,percent,quickfix,search,tag,undo
endif

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
set foldtext=FoldText()

let g:last_fold_column_width = 4  " Pick a sane default for the foldcolumn

function! FoldColumnToggle()
	if &foldcolumn
		let g:last_fold_column_width = &foldcolumn
		setlocal foldcolumn=0
	else
		let &l:foldcolumn = g:last_fold_column_width
	endif
endfunction
