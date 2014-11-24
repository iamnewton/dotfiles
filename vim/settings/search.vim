if has("extra_search")
	" Highlight searches [use :noh to clear]
	set hlsearch
	hi Search cterm=NONE ctermbg=yellow ctermfg=black
	" Highlight dynamically as pattern is typed
	set incsearch
	" Show matching parenthesis
	set showmatch
	" Ignore case of searches...
	set ignorecase
	" ...unless has mixed case
	set smartcase
	" Applies substitutions globally
	set gdefault

	function! PulseCursorLine()
		let current_window = winnr()

		windo set nocursorline
		execute current_window . 'wincmd w'

		setlocal cursorline

		redir => old_hi
			silent execute 'hi CursorLine'
		redir END
		let old_hi = split(old_hi, '\n')[0]
		let old_hi = substitute(old_hi, 'xxx', '', '')

		hi CursorLine guibg=#3a3a3a
		redraw
		sleep 20m

		hi CursorLine guibg=#4a4a4a
		redraw
		sleep 30m

		hi CursorLine guibg=#3a3a3a
		redraw
		sleep 30m

		hi CursorLine guibg=#2a2a2a
		redraw
		sleep 20m

		execute 'hi ' . old_hi

		windo set cursorline
		execute current_window . 'wincmd w'
	endfunction

endif

