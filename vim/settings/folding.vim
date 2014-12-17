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

set foldtext=FoldText()

let g:last_fold_column_width = 4  " Pick a sane default for the foldcolumn
