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
    let cmd = g:himalaya_executable . ' --config ' . g:himalaya_config_path
    let cmd .= ' account list'
    let cmd .= ' --output json'
    let accounts = json_decode(system(cmd))
    for account in accounts
        call add(found, account['name'])
    endfor
    return found
endfunction

" complete tab for Himalaya command
function! himalaya#domain#account#complete(args, ...) abort
    return filter(himalaya#domain#account#list(), 'v:val =~ a:args')
endfunction
