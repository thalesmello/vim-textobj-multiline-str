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
  if !exists("g:textobj_multilinestr_no_default_key_mappings")
    autocmd FileType python call textobj#user#map('multilinestr', {
          \   'python': {
          \     'select-a': '<buffer> aq',
          \     'select-i': '<buffer> iq',
          \   },
          \ })
  endif
augroup END
