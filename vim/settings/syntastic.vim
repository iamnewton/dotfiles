" configure syntastic syntax checking to check on open as well as save
let g:syntastic_check_on_open=1
" Enable this option to tell syntastic to always stick any detected errors into
" the |location-list|: >
let g:syntastic_always_populate_loc_list = 1
" When set to 0 the error window will not be opened or closed automatically.
let g:syntastic_auto_loc_list = 1
let g:syntastic_css_checkers = ['csslint'] " CSS
let g:syntastic_html_checkers = ['tidy'] " HTML
let g:syntastic_html_tidy_exec = '/usr/bin/tidy' " Tidy's executable
let g:syntastic_javascript_checkers = ['jscs', 'jshint'] " Javascript
" let g:syntastic_javascript_jshint_args = '--config ${HOME}/.jshintrc' " jshint conf
let g:syntastic_json_checkers = ['jsonlint'] " JSON
let g:syntastic_markdown_checkers = ['mdl'] " Markdown
let g:syntastic_php_checkers = ['php'] " PHP
let g:syntastic_python_checkers = ['python'] " Python
let g:syntastic_ruby_checkers = ['rubocop'] " Ruby
let g:syntastic_scss_checkers = ['scss_lint'] " SCSS
let g:syntastic_sh_checkers = ['shellcheck'] " Bourne/Shell
let g:syntastic_text_checkers = ['atdtool'] " Grammar, spelling, style
let g:syntastic_xhtml_checkers = ['tidy'] " xHTML
let g:syntastic_yaml_checkers = ['jsyaml'] " YAML
