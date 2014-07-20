" ctrlp plugin

let g:ctrlp_working_path_mode = 0
let g:ctrlp_extensions = ['tag']
let g:ctrlp_custom_ignore = {
    \ 'dir':  'node_modules$\|\.git$\|WEB-INF$\|META-INF$\|.sass-cache$\|_site$',
    \ 'file': '\.DS_Store$\|\.jpg$\|\.png$\|\.jpeg$\|\jpeg.gif$\|\.svg$\|\.class$\|\.iml$\|\.log$'
    \ }
" set to 1 will put regex search by default
let g:ctrlp_regexp_search = 0                       
" set to 0 for results to show at top; set to 1 for results to show on bottom
let g:ctrlp_match_window_bottom = 0
" set to 0 for results matches to show top to bottom; set to 1 for matches to show bottom to top
let g:ctrlp_match_window_reversed = 0
" default is 10, sets the max height of the match window
let g:ctrlp_max_height = 20
" set to 1 to show all dotfiles and hiddens
let g:ctrlp_show_hidden = 1
" set to 1 to search by filename (as opposed to full path) as default
let g:ctrlp_by_filename = 0

