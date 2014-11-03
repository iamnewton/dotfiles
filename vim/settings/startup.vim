" http://stackoverflow.com/a/6821698/1536779
if has("autocmd")
	" startup with tagbar window shown
	autocmd VimEnter * TagbarToggle

	" startup with nerdtree window shown
	autocmd VimEnter * NERDTreeToggle
endif
