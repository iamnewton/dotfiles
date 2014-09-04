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
nnoremap <silent> <leader>md !open -a Marked.app '%:p'<CR>
