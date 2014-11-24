" http://stackoverflow.com/a/3765575/1536779
if exists('+colorcolumn')
	" Color the column when you reach 80 characters
	set colorcolumn=80
else
	au BufWinEnter * let w:m2=matchadd('ErrorMsg', '\%>80v.\+', -1)
endif

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

	" Switch from block-cursor to vertical-line-cursor when going into/out of
	" insert mode
	let &t_SI = "\<Esc>]50;CursorShape=1\x7"
	let &t_EI = "\<Esc>]50;CursorShape=0\x7"
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
	" Always show status line even if there is only 1 window
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
	" use a status bar that is 2 rows high
	" set cmdheight=2

	hi StatusLine term=bold,reverse ctermfg=15 ctermbg=9
	hi StatusLine term=reverse ctermfg=0 ctermbg=10
endif

" Enable line numbers
set number!
" Highlight line number with no background and white foreground
hi LineNr ctermbg=NONE ctermfg=white

" Show 'invisible' characters
set list!
" Set tab to show plus on first character and dash on subsequent
set listchars=tab:+-
" Set trailing whitespace to show bull character
set listchars+=trail:·
" Character to show in the first column, when 'wrap'
" is off and there is text preceding the character
" visible in the first column
set listchars+=precedes:→
" Set characters that extend off-screen to ellipses
set listchars+=extends:…
" set non-breaking space to underscore
set listchars+=nbsp:_
" set end of line as return character
set listchars+=eol:¬

" hide the launch screen
set shortmess+=I

" When wrapping paragraphs, don't end lines with 1-letter words (looks stupid)
set formatoptions+=1
" don't start new lines w/ comment leader on pressing 'o'
set formatoptions-=o
" http://stevelosh.com/blog/2010/09/coming-home-to-vim/#making-vim-more-useful
" http://vimdoc.sourceforge.net/htmldoc/change.html#fo-table
" http://vimcasts.org/episodes/soft-wrapping-text/
" http://vimcasts.org/episodes/hard-wrapping-text/
" set formatoptions=qrn1

" change the terminal's title
set title
