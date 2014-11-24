let g:rainbow_active = 1
let g:rainbow_conf = {
\  'operators': '_,_',
\ 'parentheses': [['(',')'], ['\[','\]'], ['{','}']],
\ 'separately': {
\       '*': {},
\       'vim': {
\           'parentheses': [['fu\w* \s*.*)','endfu\w*'], ['for','endfor'], ['while', 'endwhile'], ['if','_elseif\|else_','endif'], ['(',')'], ['\[','\]'], ['{','}']],
\       },
\       'tex': {
\           'parentheses': [['(',')'], ['\[','\]'], ['\\begin{.*}','\\end{.*}']],
\       },
\       'css': 0
\   }
\}
