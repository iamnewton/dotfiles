if has("autocmd")
	" Load files for specific filetypes
	filetype on
	filetype indent on
	filetype plugin on

	" Languages with specific tabs/space requirements
	autocmd FileType make setlocal ts=4 sts=4 sw=4 noexpandtab
	" Automatically strip trailing whitespace on file save
	autocmd BufWritePre *.css,*.html,*.js,*.json,*.md,*.php,*.py,*.rb,*.scss,*.sh,*.txt :call StripTrailingWhitespace()
endif

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

" Change mapleader
let mapleader=","

" http://vim.wikia.com/wiki/Word_wrap_without_line_breaks
" Note that this may lead to a bunch of screen lines being taken up by only a
" single "real" line, so commands like j and k which move on real lines will
" skip over a lot of screen lines. You can use gj and gk to move by screen
" lines.
"
set wrap
set linebreak
set nolist
set textwidth=0
set wrapmargin=0

" http://stackoverflow.com/a/3765575/1536779
if exists('+colorcolumn')
	" Color the column when you reach 80 characters
	set colorcolumn=80
else
	au BufWinEnter * let w:m2=matchadd('ErrorMsg', '\%>80v.\+', -1)
endif

" Wrap lines at 80 characters
" set textwidth=80
" Use 4 spaces for indentation
set shiftwidth=4
" Use 4 spaces for soft tab
set softtabstop=4
" Use 4 spaces for tab
set tabstop=4
" Don't expand tab to spaces
set noexpandtab

" Start scrolling three lines before the horizontal window border
" set scrolloff=3
" Keep scrolling in the middle of the window
set scrolloff=999
" Don’t reset cursor to start of line when moving around.
set nostartofline

" Backspace through everything in INSERT mode
set backspace=indent,eol,start
" Optimize for fast terminal connections
set ttyfast
" Use UTF-8 without BOM
set encoding=utf-8 nobomb

" Centralize backups, swapfiles and undo history
set backupdir=$HOME/.vim/backups
set directory=$HOME/.vim/swaps
if exists("&undodir")
	set undodir=$HOME/.vim/undo
endif
set viminfo+=n$HOME/.vim/.viminfo

" Load local machine settings if they exist
if filereadable(glob("$HOME/.vimrc.local"))
	source $HOME/.vimrc.local
endif
