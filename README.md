# vim-pathfinder

Vim plugin that manages the path variable. This makes file searching with the native `:find` and `gf` commands easier.

The plugin provides two Vim commands: `:UpdatePath` and `:Cd`. `:UpdatePath` will fill the path variable and runs when Vim launches. It does not run on directory change, therefore `:Cd` is available. It is just like `:cd` except it runs `:UpdatePath` just after the directory changes.

`:UpdatePath` looks for a parent `.git` directory and uses that as the project root directory. It uses the current directory if no repository is found.

Requires `ag` The Silver Searcher to be installed on the computer.


## Options

There are some options to customize the behaviour of `vim-pathfinder`.

### `g:pathfinder_include`
Include your own folders in the search path.

```shell
let g:pathfinder_include='/home/supersimen/documents,/home/supersimen/Dropbox/**'
```

Use `/**` after the folder name to include subfolders. The path must be absolute, so using `~/` will not work.


## Tips

* `set suffixesadd+=.js,.java` to help Vim recognize filenames without extensions.
* `set wildignorecase` to enable case insensetive file searching.
