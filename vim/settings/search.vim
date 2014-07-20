if has("extra_search")
	" Highlight searches [use :noh to clear]
	set hlsearch
	hi Search cterm=NONE ctermbg=yellow ctermfg=black
	" Highlight dynamically as pattern is typed
	set incsearch
	" Ignore case of searches...
	set ignorecase
	" ...unless has mixed case
	set smartcase
endif

