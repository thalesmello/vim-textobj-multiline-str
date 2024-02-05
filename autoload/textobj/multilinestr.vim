function! textobj#multilinestr#select_a() abort
    return textobj#multilinestr#select("a")
endfunction

function! textobj#multilinestr#select_i() abort
    return textobj#multilinestr#select("i")
endfunction

function! textobj#multilinestr#select(mode)
    if !s:CheckInsidePythonString()
        return 0
    endif

    echomsg 'Inside string!'

    " We are inside a Python multiline string, so we have to find the boundaries
    let quote_type = search('[fr]\?"""\|\([rf]\?''''''\)', 'bWp')

    if quote_type == 0
        return 0
    elseif quote_type == 1
        let end_quote = '"""'
    elseif quote_type == 2
        let end_quote = "'''"
    else
        echoerr "Invalid quote pattern found"
        return 0
    endif

    if a:mode == "a"
        let start = getpos('.')
        " Goes to the end of the beginning match, to match with the closing
        " quote later
        call search(end_quote, 'We')
    elseif a:mode == "i"
        " Try to match the first character after the tripple quote
        call search(end_quote . '\n\?\zs', "W")
        let start = getpos('.')
    endif

    if search(end_quote, 'We') == 0
        " No end quote was found
        return 0
    endif

    if a:mode == "i"
        call search('\_.\n\?' . end_quote, 'Wb')
    endif

    let end = getpos('.')

    return ['v', start, end]
endfunction

function s:CheckInsidePythonString()
    let syntaxGroups = map(synstack(line('.'), col('.')), 'synIDattr(v:val, "name")')
    let stringTypes = ['pythonString', 'pythonRawString', 'pythonFString']

    for strType in stringTypes
        if index(syntaxGroups, strType) >= 0
            return 1
        endif
    endfor

    return 0
endfunction
