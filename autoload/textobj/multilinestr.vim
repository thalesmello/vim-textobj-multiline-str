function! textobj#multilinestr#select()
    if !s:CheckInsidePythonString()
        return 0
    endif

    " We are inside a Python multiline string, so we have to find the boundaries
    let quote_type = search('"""\|\(''''''\)', 'bWp')

    if quote_type == 0
        return 0
    endif

    let start = getpos('.')

    if quote_type == 1
        let end_quote = '"""'
    elseif quote_type == 2
        let end_quote = "'''"
    else
        echoerr "Invalid quote pattern found"
        return 0
    endif

    let end = search(end_quote, 'We')

    if end == 0
        " No end quote was found
        return 0
    endif

    let end = getpos('.')

    return ['v', start, end]
endfunction

function s:CheckInsidePythonString()
    return index(map(synstack(line('.'), col('.')), 'synIDattr(v:val, "name")'), "pythonString") >= 0
endfunction
