# vim-pathfinder

Vim plugin that manages the path variable. This makes file searching with the native `:find` and `gf` commands easier.

The plugin provides two Vim commands: `:UpdatePath` and `:Cd`. `:UpdatePath` will fill the path variable and runs when Vim launches. It does not run on directory change, therefore `:Cd` is available. It is just like `:cd` except it runs `:UpdatePath` just after the directory changes.

`:UpdatePath` looks for a parent `.git` directory and uses that as the project root directory. It uses the current directory if no repository is found.

It also reads `.gitignore` in project root if found, and ignores listed directories.


## Options

There are some options to customize the behaviour of `vim-pathfinder`.

### `g:pathfinder_include`
Include your own folders in the search path.

```shell
let g:pathfinder_include='/home/supersimen/documents,/home/supersimen/Dropbox/**'
```

Use `/**` after the folder name to include subfolders. The path must be absolute, so using `~/` will not work.

### `g:pathfinder_exclude`

Exclude folders from the search path. These folders are relative to the project root. Using `g:pathfinder_exclude` is equivalent to writing folders in `.gitignore`.

```shell
let g:pathfinder_exclude='vendor,node_modules'
```

### `g:pathfinder_look_for_git`

Specify whether or not to look for a parent git repo. Default is 1.

```shell
let g:pathfinder_look_for_git=0
```

### `g:pathfinder_use_gitignore`

Specify whether or not to read the `.gitignore` file in project root. Default is 1.

```shell
let g:pathfinder_use_gitignore=0
```

## Tips

* `set suffixesadd+=.js,.java` to help Vim recognize filenames without extensions.
* `set wildignorecase` to enable case insensetive file searching.
