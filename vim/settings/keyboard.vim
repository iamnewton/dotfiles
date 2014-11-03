" Strip trailing whitespace (,$)
" disabled so EditorConfig can control it
" noremap <leader>$ :call StripTrailingWhitespace()<CR>

" Faster viewport scrolling (3 lines at a time)
nnoremap <C-e> 3<C-e>
nnoremap <C-y> 3<C-y>
vnoremap <C-e> 3<C-e>
vnoremap <C-y> 3<C-y>

" Lets you use w!! to sudo save after you opened the file already
cmap w!! w !sudo tee % >/dev/null

" Make `Y` work from the cursor to the end of line (which is more logical)
nnoremap Y y$

" Indent
vmap <Tab> >gv
vmap <S-Tab> <gv

" http://captainbollocks.tumblr.com/post/9858989188/linking-macvim-and-marked-app
nnoremap <silent> <Leader>m !open -a Marked\ 2.app '%:p'<CR>

" https://twitter.com/goatslacker/status/192085732834291712
" run fixmyjs on the current file, and reload the page
map <Leader>k :execute ":w !fixmyjs " . expand("%")<CR>:edit<CR>

" http://statico.github.io/vim.html#rudimentary_essentials
" move up/down a file in a single column
nnoremap j gj
nnoremap k gk

" turn off search highlighting
nnoremap <Leader>q :nohlsearch<CR>

" move forward/back in buffers
nnoremap <C-n> :bnext<CR>
nnoremap <C-p> :bprev<CR>

" shortcut for :shell/:sh mode
nnoremap <Leader>s :shell<CR>

" open last edited buffer
nnoremap <C-e> :e#<CR>
