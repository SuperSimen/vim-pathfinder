function! UpdatePath()
    let path = FindProjectPath(fnamemodify(getcwd(), ':p'))
    let folders = GetFolders(path)
    let ignoredFolders = GetIgnoredFolders(path)
    let includedFolders = FilterList(ignoredFolders, folders)
    let combinedPath = path . "," . CombinePathsIntoPath(includedFolders)
    let &path = combinedPath
endfunction

function! FindProjectPath(path)
    let path = finddir('.git', a:path . ';~/')
    if len(path)
        let path = fnamemodify(path, ':h')
    endif
    let path = fnamemodify(path, ':p')
    return path
endfunction

function! GetFolders(path)
    let command = "ls -F " . a:path . " | grep / "
    let folders = systemlist(command)
    let basedFolders = AddBasePath(a:path, folders)
    return Map(function('FullPath'), basedFolders)
endfunction

function! GetIgnoredFolders(path)
    let gitignore = a:path . '/.gitignore'
    let command = "cat " . gitignore . " | grep '/$'"
    let folders = []
    if filereadable(gitignore)
        let folders = systemlist(command)
    endif
    let basedFolders = AddBasePath(a:path, folders)
    return Map(function('FullPath'), basedFolders)
endfunction

function! AddBasePath(path, list)
    if len(a:list) == 0
        return []
    else
        return [a:path . a:list[0]] + AddBasePath(a:path, a:list[1:])
    endif
endfu

function! FullPath(name)
    return fnamemodify(a:name, ':p')
endfunction

function! CombinePathsIntoPath(paths)
    if len(a:paths) == 0
        return ""
    else
        return a:paths[0] . "**," . CombinePathsIntoPath(a:paths[1:])
    endif
endfunction

function! Map(Fun, list)
    if len(a:list) == 0
        return []
    else
        return [a:Fun(a:list[0])] + Map(a:Fun, a:list[1:])
    endif
endfunction

function! FilterList(itemsToExclude, list)
    if len(a:list) == 0
        return []
    elseif index(a:itemsToExclude, a:list[0]) == -1
        return [a:list[0]] + FilterList(a:itemsToExclude, a:list[1:])
    else
        return FilterList(a:itemsToExclude, a:list[1:])
    endif
endfunction
call UpdatePath()
