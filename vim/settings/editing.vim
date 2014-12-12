" http://vim.wikia.com/wiki/Word_wrap_without_line_breaks
" Note that this may lead to a bunch of screen lines being taken up by only a
" single "real" line, so commands like j and k which move on real lines will
" skip over a lot of screen lines. You can use gj and gk to move by screen
" lines.
set wrap!
set linebreak
set nolist
set textwidth=0
set wrapmargin=0

" Wrap lines at 80 characters
" set textwidth=80
" Use 4 spaces for soft tab
set softtabstop=4
" Use 4 spaces for tab
set tabstop=4
" Don't expand tab to spaces
set noexpandtab

" Use 4 spaces for indentation
set shiftwidth=4
" https://github.com/nvie/vimrc/blob/master/vimrc#L40-L81
" use multiple of shiftwidth when indenting with '<' and '>'
set shiftround
" always set autoindenting on
set autoindent
" copy the previous indentation on autoindenting
set copyindent
" insert tabs on the start of a line according to shiftwidth, not tabstop
set smarttab

" Start scrolling three lines before the horizontal window border
" set scrolloff=3
" Keep scrolling in the middle of the window
set scrolloff=999
" Don’t reset cursor to start of line when moving around.
set nostartofline
" allow the cursor to go in to "invalid" places
" valid values = 'block', 'insert', 'all', 'onemore', ''
" set virtualedit=all
" Backspace through everything in INSERT mode
set backspace=indent,eol,start

if has("wildmenu")
	" Show a list of possible completions
	set wildmenu
	" Tab autocomplete longest possible part of a string, then list
	set wildmode=longest,list
	if has ("wildignore")
		set wildignore+=*.a,*.pyc,*.o,*.orig
		set wildignore+=*.bmp,*.gif,*.ico,*.jpg,*.jpeg,*.png
		set wildignore+=.DS_Store,.git,.hg,.svn
		set wildignore+=*~,*.sw?,*.tmp
	endif
endif

" highlight conflict markers
match ErrorMsg '^\(<\|=\|>\)\{7\}\([^=].\+\)\?$'

" set location of tags file
" set tags=tags;/
set tags=./tags;
