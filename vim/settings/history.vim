" hide buffers instead of closing them this means that the current buffer can
" be put to background without being written; and that marks and undo history
" are preserved
set hidden
" reveal already opened files from the quickfix window instead of opening new
" buffers
set switchbuf=useopen

" do not keep backup files
set nobackup
" store backup files (in case backup is ever turned on)
set backupdir=$HOME/.vim/backups

" do not write annoying intermediate swap files, who did ever restore from swap
" files anyway?
set noswapfile
" store swap files (in case swapfile is ever turned on)
set directory=$HOME/.vim/swaps

" remember more commands and search history
set history=1000
" use many muchos levels of undo
set undolevels=1000
if v:version >= 730
	" keep a persistent backup file
	set undofile
	set undodir=$HOME/.vim/undo
endif

" read/write a .viminfo file, don't store more than 80 lines of registers
set viminfo='20,\"80
set viminfo+=n$HOME/.vim/.viminfo
