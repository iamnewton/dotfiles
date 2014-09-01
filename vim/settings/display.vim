if has("syntax")
	" Enable syntax highlighting
	syntax enable
	" Set 256 color terminal support
	set t_Co=256
	hi Visual ctermbg=15 ctermfg=0
	" Highlight current line
	set cursorline
	hi clear CursorLine
	hi CursorLine cterm=underline term=underline gui=underline guibg=NONE
endif

if has("cmdline_info")
	" Show the cursor line and column number
	set ruler
	" Show partial commands in status line
	set showcmd
	" Show whether in insert or replace mode
	set showmode
endif

if has('statusline')
	" Always show status line
	set laststatus=2
	" Broken down into easily includeable segments
	" Filename
	set statusline=%<%f
	" Options
	set statusline+=%w%h%m%r
	" Current dir
	set statusline+=\ [%{getcwd()}]
	" Right aligned file nav info
	set statusline+=%=%-14.(%l,%c%V%)\ %p%%
	hi StatusLine term=bold,reverse ctermfg=15 ctermbg=9
	hi StatusLine term=reverse ctermfg=0 ctermbg=10
endif

" Enable line numbers
set number!
hi LineNr ctermbg=NONE ctermfg=white

" Show 'invisible' characters
set list!
" Set characters used to indicate 'invisible' characters
set listchars=tab:+-
set listchars+=trail:·
set listchars+=nbsp:_
"set listchars+=eol:¬

