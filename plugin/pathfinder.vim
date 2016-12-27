
function! s:InitializaSettings()
    if !exists('g:pathfinder_include')
        let g:pathfinder_include = ''
    endif
endfunction


function! s:UpdatePath()
    let path = s:FindProjectPath(fnamemodify(getcwd(), ':p'))
    let folders = s:GetFolders(path)
    let combinedPath = join(folders, ",") . "," . g:pathfinder_include
    let &path = combinedPath
endfunction


function! s:FindProjectPath(path)
    let path = finddir('.git', a:path . ';~/')
    if len(path)
        return fnamemodify(path, ':p:h:h')
    else
        return a:path
    endif
endfunction


function! s:GetFolders(path)
    if (!len(a:path))
        return []
    endif

    let command = "ls -F " . a:path . " | grep '/\\|@' "
    let foldersAndLinks = [''] + split(system(command))
    let folders = map(foldersAndLinks, 'substitute(v:val, "@", "/", "")')
    return s:MakePaths(a:path, folders)
endfunction

function! s:MakePaths(path, folders)
    let basedFolders = s:AddBasePath(a:path, a:folders)
    let mappedFolders = map(basedFolders, 'fnamemodify(v:val, ":p")')
    
    return mappedFolders
endfunction

function! s:AddBasePath(path, list)
    if len(a:list) == 0
        return []
    else
        return [a:path . "/" . a:list[0]] + s:AddBasePath(a:path, a:list[1:])
    endif
endfu




call s:InitializaSettings()
call s:UpdatePath()

com! UpdatePath :call s:UpdatePath()
com! -complete=dir -nargs=? Cd :cd <args> | UpdatePath


