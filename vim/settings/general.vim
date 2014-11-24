" Vim expects a POSIX-compliant shell
set shell=bash
if has("multi_byte")
	" Use UTF-8 without BOM
	set encoding=utf-8 nobomb
	set termencoding=utf-8
endif
" set eol formats
set fileformats="unix,dos,mac"
" Optimize for fast terminal connections
set ttyfast
" normal OS clipboard interaction
" commenting out for now as it makes it difficult to yank and paste
" as you yank into the pasteboard, thus removing what you wanted to paste
" set clipboard=unnamed

" Change mapleader
let mapleader = ","
let maplocalleader = "<"

if has("autocmd")
	" Load files for specific file types
	filetype on
	" Indenting intelligence based on syntax rules for file type
	filetype indent on
	" Load file type specific plugins only for file type
	filetype plugin on
	" Languages with specific tabs/space requirements
	" autocmd FileType make setlocal ts=4 sts=4 sw=4 noexpandtab
	" Automatically strip trailing whitespace on file save
	" disabled so EditorConfig can control it
	" autocmd BufWritePre *.css,*.html,*.js,*.json,*.md,*.php,*.py,*.rb,*.scss,*.sh,*.txt :call StripTrailingWhitespace()
endif

" don't beep
set visualbell
set noerrorbells
