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
