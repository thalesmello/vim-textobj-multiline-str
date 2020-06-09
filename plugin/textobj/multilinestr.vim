call textobj#user#plugin('multilinestr', {
      \   'python': {
      \     'select-a-function': 'textobj#multilinestr#select_a',
      \     'select-i-function': 'textobj#multilinestr#select_i',
      \     'select-a': [],
      \     'select-i': []
      \   }
      \ })

augroup multilinestr_textobj
  autocmd!
  autocmd FileType python call textobj#user#map('multilinestr', {
        \   'python': {
        \     'select-a': 'aq',
        \     'select-i': 'iq',
        \   },
        \ })
augroup END
