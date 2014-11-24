" http://stackoverflow.com/a/6821698/1536779
if has("autocmd")
	" http://stackoverflow.com/a/23121220/438329
	" commenting these 3 out as the article above makes a good point
	" against it
	" startup with tagbar window shown
	" autocmd VimEnter * TagbarToggle
	" startup with nerdtree window shown
	" autocmd VimEnter * NERDTreeToggle
	" startup in the correct window
	" autocmd VimEnter * wincmd l

	" Save files when ViM loses focus
	autocmd FocusLost * :wa

	" Restore cursor position upon reopening files {{{
	autocmd BufReadPost *
	\ if line("'\"") > 0 && line("'\"") <= line("$") |
	\     execute "normal! g`\"" |
	\ endif

	" somehow, during vim filetype detection, this gets set for vim files, so
	" explicitly unset it again
	autocmd filetype vim set formatoptions-=o
endif
