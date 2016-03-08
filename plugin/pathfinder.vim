
function! s:UpdatePath()
    let path = s:FindProjectPath(fnamemodify(getcwd(), ':p'))
    let folders = s:GetFolders(path)
    let ignoredFolders = s:GetIgnoredFolders(path)
    let includedFolders = s:FilterList(ignoredFolders, folders)
    let combinedPath = path . "," . s:CombinePathsIntoPath(includedFolders)
    if exists('g:pathfinder_include')
        let combinedPath .= g:pathfinder_include
    endif
    echo combinedPath
    let &path = combinedPath
endfunction

function! s:FindProjectPath(path)
    let path = finddir('.git', a:path . ';~/')
    if len(path)
        let path = fnamemodify(path, ':h')
    endif
    let path = fnamemodify(path, ':p')
    return path
endfunction

function! s:GetFolders(path)
    let command = "ls -F " . a:path . " | grep '/\\|@' "
    let foldersAndLinks = split(system(command))
    let folders = s:Map(function('s:LinkToFolder'), foldersAndLinks)
    let basedFolders = s:AddBasePath(a:path, folders)
    return s:Map(function('s:FullPath'), basedFolders)
endfunction

function! s:LinkToFolder(linkOrFolder)
	return substitute(a:linkOrFolder, '@', '/', '')
endfunction

function! s:GetIgnoredFolders(path)
    let gitignore = a:path . '/.gitignore'
    let command = "cat " . gitignore . " | grep '/$'"
    let folders = []
    if filereadable(gitignore)
        let folders = split(system(command))
    endif
    let basedFolders = s:AddBasePath(a:path, folders)
    return s:Map(function('s:FullPath'), basedFolders)
endfunction

function! s:AddBasePath(path, list)
    if len(a:list) == 0
        return []
    else
        return [a:path . a:list[0]] + s:AddBasePath(a:path, a:list[1:])
    endif
endfu

function! s:FullPath(name)
    return fnamemodify(a:name, ':p')
endfunction

function! s:CombinePathsIntoPath(paths)
    if len(a:paths) == 0
        return ""
    else
        return a:paths[0] . "**," . s:CombinePathsIntoPath(a:paths[1:])
    endif
endfunction

function! s:Map(Fun, list)
    if len(a:list) == 0
        return []
    else
        return [a:Fun(a:list[0])] + s:Map(a:Fun, a:list[1:])
    endif
endfunction

function! s:FilterList(itemsToExclude, list)
    if len(a:list) == 0
        return []
    elseif index(a:itemsToExclude, a:list[0]) == -1
        return [a:list[0]] + s:FilterList(a:itemsToExclude, a:list[1:])
    else
        return s:FilterList(a:itemsToExclude, a:list[1:])
    endif
endfunction
call s:UpdatePath()

com! UpdatePath :call s:UpdatePath()
com! -complete=dir -nargs=? Cd :cd <args> | UpdatePath
