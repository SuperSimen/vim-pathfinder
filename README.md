# vim-pathfinder

Vim plugin that manages the path variable. This makes file searching with the native `:find` and `gf` commands easier.

The plugin provides two VIM commands: `UpdatePath` and `Cd`. `UpdatePath` will fill the path variable and runs when VIM launches. It does not run on directory change, therefore `Cd` is available. It is just like `cd` except it runs `UpdatePath` just after the directory changes.

`UpdatePath` Looks for a parent `.git` directory and uses that as the project root directory. It uses the current directory if no repository is found.

It also reads `.gitignore` in project root if found, and ignores listed directories.


## Options

Include your own folders in the search path with `g:pathfinder_include`.

```shell
let g:pathfinder_include='/home/supersimen/documents,/home/supersimen/Dropbox/**'
```

```javascript
let g:pathfinder_include='/home/supersimen/documents,/home/supersimen/Dropbox/**'
```

Use `/**` after the folder name to include subfolders. The path must be absolute, so using `~/` will not work.


## Tips

* `:set suffixesadd+=.js,.java` to help `gf` recognize filenames without extensions.
* `:set wildignorecase` to enable case insensetive file searching.
