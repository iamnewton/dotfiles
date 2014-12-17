" http://thejakeharding.com/tutorial/2012/06/13/using-spell-check-in-vim.html
" Set spellfile to location that is guaranteed to exist, can be symlinked to
" Dropbox or kept in Git and managed outside of thoughtbot/dotfiles using
" rcm.
set spelllang=en
set spellfile=$HOME/.vim/settings/spell-en.utf-8.add

" Markdown
"
" Enable spell checking
autocmd FileType markdown setlocal spell

" Automatically wrap at 80 characters for Markdown
autocmd BufRead,BufNewFile *.md setlocal textwidth=80

" Git Commits
"
" Enable spell checking 
autocmd FileType gitcommit setlocal spell

" Automatically wrap at 72 characters and spell check git commit
" messages
autocmd FileType gitcommit setlocal textwidth=72

