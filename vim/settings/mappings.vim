" Strip trailing whitespace (,$)
" disabled so EditorConfig can control it
" noremap <leader>$ :call StripTrailingWhitespace()<CR>

" turn off search highlighting
nnoremap <leader>/ :nohlsearch<CR>

" ctrl p search tags
nnoremap <leader>. :CtrlPTag<CR>

" grep/Ack/Ag for the word under cursor
vnoremap <leader>a y:grep! "\b<c-r>"\b"<cr>:cw<cr>
nnoremap <leader>a :grep! "\b<c-r><c-w>\b"

" toggle Nerd Tree
nnoremap <leader>b :NERDTreeToggle<CR>

" clear out the cache for ctrl p
nnoremap <leader>c :ClearAllCtrlPCaches<CR>

" open last edited buffer
nnoremap <leader>e :e#<cr>

" Toggle the foldcolumn
nnoremap <leader>f :call FoldColumnToggle()<cr>

" grep searches
" nnoremap <leader>g :silent execute "grep! -r " . shellescape('<cword>') . " ."<cr>:copen 12<cr>
" nnoremap <leader>g :silent execute "grep! -r " . shellescape('<cword>') . " ."<cr>:copen 12<cr>

" https://twitter.com/goatslacker/status/192085732834291712
" run fixmyjs on the current file, and reload the page
map <leader>k :execute ":w !fixmyjs " . expand("%")<cr>:edit<cr>

" http://captainbollocks.tumblr.com/post/9858989188/linking-macvim-and-marked-app
nnoremap <silent> <leader>m ! open -a marked\ 2.app '%:p'<cr>

" shortcut to jump to next conflict marker
nnoremap <silent> <leader>n /^\(<\\|=\\|>\)\{7\}\([^=].\+\)\?$<cr>

" toggle paste mode
nnoremap <leader>o :set pastetoggle<CR>

" quickly close the current buffer
nnoremap <leader>q :bd<cr>

" shortcut for Rainbow plugin
nnoremap <silent> <leader>r :RainbowToggle<CR>

" shortcut for :shell/:sh mode
nnoremap <leader>s :shell<cr>

" toggle TagBar
nnoremap <silent> <Leader>t :TagbarToggle<CR>

" toggle Gundo
nnoremap <leader>u :GundoToggle<CR>

" toggle wrap
map <leader>w :set nowrap!<CR>

" reselect text that was just pasted with ,v
nnoremap <leader>v v`]

" quick alignment of text
nnoremap <leader>al :left<cr>
nnoremap <leader>ar :right<cr>
nnoremap <leader>ac :center<cr>

" toggle line numbers/invisible characters for copy/paste
map <leader>cp :setlocal nonumber! nolist!<CR>

" quickly edit the vimrc file in a split window
nnoremap <silent> <leader>ev <c-w><c-v><c-l>:e $myvimrc<cr>

" creating folds for tags in html
nnoremap <leader>ft vatzf

" ctrl p search MRU files
nnoremap <silent> <leader>mr :CtrlPMRUFiles<CR>

" split previously opened file ('#') in a split window
nnoremap <leader>sh :execute "leftabove vsplit" bufname('#')<cr>
nnoremap <leader>sl :execute "rightbelow vsplit" bufname('#')<cr>

" allow toggling between tabs and spaces mode
map <leader>sp :call TabToggle()<CR>

" quickly reload the vimrc file
nmap <silent> <leader>sv :so $myvimrc<cr>

" make the tab key match bracket pairs
" nnoremap <tab> %
" vnoremap <tab> %

" activate clam shell
nnoremap ! :Clam<space>

" ctrl p search
nnoremap <silent> \ :CtrlP<CR>
" ctrl p search files
nnoremap <silent> <Tab> :CtrlPCurFile<CR>
" ctrl p search buffers
nnoremap <silent> <space> :CtrlPBuffer<CR>

" indent
vmap <<tab></tab>> >gv
vmap <s-tab> <gv

" Folding
nnoremap <Space> za
vnoremap <Space> za


" save a character when saving
nnoremap ; :

" http://statico.github.io/vim.html#rudimentary_essentials
" move up/down a file in screen line, not a file line
nnoremap j gj
nnoremap k gk

" keep search matches in the middle of the window and pulse the line when
" moving to them.
if has("extra_search")
	nnoremap n n:call pulsecursorline()<cr>
	nnoremap n n:call pulsecursorline()<cr>
endif

" Mappings to easily toggle fold levels
nnoremap z0 :set foldlevel=0<cr>
nnoremap z1 :set foldlevel=1<cr>
nnoremap z2 :set foldlevel=2<cr>
nnoremap z3 :set foldlevel=3<cr>
nnoremap z4 :set foldlevel=4<cr>
nnoremap z5 :set foldlevel=5<cr>

" lets you use w!! to sudo save after you opened the file already
cmap w!! w !sudo tee % >/dev/null

" use shift-h to move to beginning
nnoremap H 0
" use shift-l to move to the end
nnoremap L $

nnoremap K *n:grep! "\b<c-r><c-w>\b"<cr>:cw<cr>

" make `y` work from the cursor to the end of line (which is more logical)
nnoremap Y y$

" quickly get out of insert mode without your fingers having to leave the home
" row (either use 'jj' or 'jk')
inoremap jj <esc>

" faster viewport scrolling (3 lines at a time)
nnoremap <c-e> 3<c-e>
nnoremap <c-y> 3<c-y>
vnoremap <c-e> 3<c-e>
vnoremap <c-y> 3<c-y>

" move forward/back in buffers
nnoremap <c-n> :bnext<cr>
nnoremap <c-p> :bprev<cr>

" complete whole filenames/lines with a quicker shortcut key in insert mode
inoremap <c-f> <c-x><c-f>
inoremap <c-l> <c-x><c-l>
