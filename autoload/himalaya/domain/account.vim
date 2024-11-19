let s:account = ''

function! himalaya#domain#account#current() abort
  return s:account
endfunction

function! himalaya#domain#account#select(account) abort
  let s:account = a:account
endfunction

" return accounts list
function! himalaya#domain#account#list() abort
    let found = []
    call foreach(json_decode(system([
    \ g:himalaya_executable,
    \ '--config',
    \ g:himalaya_config_path,
    \ 'account',
    \ 'list',
    \ '--output',
    \ 'json',
    \])), {k, v -> add(found, v.name)})
    return found
endfunction

" complete tab for Himalaya command
function! himalaya#domain#account#complete(args, ...) abort
    return filter(himalaya#domain#account#list(), 'v:val =~ a:args')
endfunction
