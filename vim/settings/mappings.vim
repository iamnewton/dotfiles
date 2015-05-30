" Strip trailing whitespace (,$)
" disabled so EditorConfig can control it
" noremap <leader>$ :call StripTrailingWhitespace()<CR>

" turn off search highlighting
nnoremap <leader>/ :nohlsearch<CR>

" ctrl p search tags
nnoremap <leader>. :CtrlPTag<CR>

" grep/Ack/Ag for the word under cursor
vnoremap <leader>a y:grep! "\b<C-r>"\b"<CR>:cw<CR>
nnoremap <leader>a :grep! "\b<C-r><C-w>\b"

" toggle Nerd Tree
nnoremap <leader>b :NERDTreeToggle<CR>

" clear out the cache for ctrl p
nnoremap <leader>c :ClearAllCtrlPCaches<CR>

" color picker css
nnoremap <leader>C :ColorRGBCSS<CR>

" search term under cursor in Dash in docset matching filetype
nnoremap <leader>d :Dash<CR>

" search term under cursor in Dash in all docsets
nnoremap <leader>D :Dash!<CR>

" open last edited buffer
nnoremap <leader>e :e#<CR>

" Toggle the foldcolumn
nnoremap <leader>f :call FoldColumnToggle()<CR>

" Send current buffer to Gist
nnoremap <leader>g :Gist<CR>

" Git blame highlighted code
vmap <leader>g :<C-U>!git blame <C-R>=expand("%:p") <CR> \| sed -n <C-R>=line("'<") <CR>,<C-R>=line("'>") <CR>p <CR>

" grep searches
" nnoremap <leader>g :silent execute "grep! -r " . shellescape('<cword>') . " ."<CR>:copen 12<CR>
" nnoremap <leader>g :silent execute "grep! -r " . shellescape('<cword>') . " ."<CR>:copen 12<CR>

" https://twitter.com/goatslacker/status/192085732834291712
" run fixmyjs on the current file, and reload the page
map <leader>k :execute ":w !fixmyjs " . expand("%")<CR>:edit<CR>

" http://captainbollocks.tumblr.com/post/9858989188/linking-macvim-and-marked-app
nnoremap <silent> <leader>m ! open -a marked\ 2.app '%:p'<CR>

" shortcut to jump to next conflict marker
nnoremap <silent> <leader>n /^\(<\\|=\\|>\)\{7\}\([^=].\+\)\?$<CR>

" run csscomb on current file, then reload page
" map <leader>o :execute ":w !csscomb " . expand("%")<CR>:edit<CR>

" toggle numbers between absolute & relative
nnoremap <leader>N :NumbersToggle<CR>
" nnoremap <F4> :NumbersOnOff<CR>

" toggle paste mode
nnoremap <leader>p :set pastetoggle<CR>

" quickly close the current buffer
nnoremap <leader>q :bd<CR>

" shortcut for Rainbow plugin
nnoremap <silent> <leader>r :RainbowToggle<CR>

" shortcut for :shell/:sh mode
nnoremap <leader>s :shell<CR>

" toggle TagBar
nnoremap <silent> <Leader>t :TagbarToggle<CR>

" toggle Gundo
nnoremap <leader>u :GundoToggle<CR>

" toggle wrap
map <leader>w :set nowrap!<CR>

" reselect text that was just pasted with ,v
nnoremap <leader>v v`]

" quick alignment of text
nnoremap <leader>al :left<CR>
nnoremap <leader>ar :right<CR>
nnoremap <leader>ac :center<CR>

" toggle line numbers/invisible characters for copy/paste
map <leader>cp :setlocal nonumber! nolist!<CR>

" quickly edit the vimrc file in a split window
nnoremap <silent> <leader>ev <C-w><C-v><C-l>:e $MYVIMRC<CR>

" creating folds for tags in html
nnoremap <leader>ft vatzf

" ctrl p search MRU files
nnoremap <silent> <leader>mr :CtrlPMRUFiles<CR>

" Upload contents of buffer
nnoremap <leader>sc :%! slackcat -c transact<CR>

" split previously opened file ('#') in a split window
nnoremap <leader>sh :execute "leftabove vsplit" bufname('#')<CR>
nnoremap <leader>sl :execute "rightbelow vsplit" bufname('#')<CR>

" allow toggling between tabs and spaces mode
map <leader>sp :call TabToggle()<CR>

" quickly reload the vimrc file
nmap <silent> <leader>sv :so $MYVIMRC<CR>

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
vmap <Tab> >gv
vmap <S-Tab> <gv

" Tab completion
" will insert tab at beginning of line,
" will use completion if not at beginning
" https://github.com/thoughtbot/dotfiles/blob/master/vimrc#L98-L111
inoremap <Tab> <c-r>=InsertTabWrapper()<cr>
inoremap <S-Tab> <c-n>

" Folding
" nnoremap <Space> za
" vnoremap <Space> za


" save a character when saving
nnoremap ; :

" http://statico.github.io/vim.html#rudimentary_essentials
" move up/down a file in screen line, not a file line
nnoremap j gj
nnoremap k gk

" keep search matches in the middle of the window and pulse the line when
" moving to them.
if has("extra_search")
	nnoremap n n:call PulseCursorLine()<CR>
	nnoremap n n:call PulseCursorLine()<CR>
endif

" Mappings to easily toggle fold levels
nnoremap z0 :set foldlevel=0<CR>
nnoremap z1 :set foldlevel=1<CR>
nnoremap z2 :set foldlevel=2<CR>
nnoremap z3 :set foldlevel=3<CR>
nnoremap z4 :set foldlevel=4<CR>
nnoremap z5 :set foldlevel=5<CR>

" lets you use w!! to sudo save after you opened the file already
cmap w!! w !sudo tee % >/dev/null

" use shift-h to move to beginning
nnoremap H 0
" use shift-l to move to the end
nnoremap L $

nnoremap K *n:grep! "\b<C-r><C-w>\b"<CR>:cw<CR>

" make `y` work from the cursor to the end of line (which is more logical)
nnoremap Y y$

" quickly get out of insert mode without your fingers having to leave the home
" row (either use 'jj' or 'jk')
inoremap jj <esc>

" faster viewport scrolling (3 lines at a time)
nnoremap <C-e> 3<C-e>
nnoremap <C-y> 3<C-y>
vnoremap <C-e> 3<C-e>
vnoremap <C-y> 3<C-y>

" move forward/back in buffers
nnoremap <C-n> :bnext<CR>
nnoremap <C-p> :bprev<CR>

" autocomplete whole filenames/lines with a quicker shortcut key in insert mode
inoremap <C-f> <C-x><C-f>
inoremap <C-l> <C-x><C-l>
inoremap <C-k> <C-x><C-o>

