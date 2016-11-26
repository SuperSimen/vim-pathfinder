
function! s:InitializaSettings()
    if !exists('g:pathfinder_include')
        let g:pathfinder_include = ''
    endif
endfunction


function! s:UpdatePath()
    let path = s:FindProjectPath(fnamemodify(getcwd(), ':p'))
    let folders = s:GetFolders(path)
    let combinedPath = join(folders, ",") . g:pathfinder_include
    let &path = combinedPath
endfunction

function! s:FindProjectPath(path)
    let path = finddir('.git', a:path . ';~/')
    if len(path)
        return fnamemodify(path, ':p:h:h')
    else
        return ""
    endif
endfunction

function! s:GetFolders(path)
    if (!len(a:path))
        return []
    endif

    let command = 'ag -g "" ' . a:path
    let folders = split(system(command))
    let folders = map(folders, 'substitute(v:val, "/[^/]*$", "/", "g")')
    let folders = uniq(folders)
    return folders
endfunction




call s:InitializaSettings()
call s:UpdatePath()

com! UpdatePath :call s:UpdatePath()
com! -complete=dir -nargs=? Cd :cd <args> | UpdatePath
