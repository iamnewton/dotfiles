" Strip trailing whitespace (,$)
noremap <leader>$ :call StripTrailingWhitespace()<CR>

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

" Ctrlp plugin
nnoremap <silent> \ :CtrlP<CR>
nnoremap <silent> <Tab> :CtrlPCurFile<CR>
nnoremap <silent> <space> :CtrlPBuffer<CR>
nnoremap <silent> <leader>m :CtrlPMRUFiles<CR>
nnoremap <silent> cv :CtrlPTag<CR>
