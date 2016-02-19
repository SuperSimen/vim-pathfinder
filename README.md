# vim-pathfinder

Vim plugin that manages the path variable. This makes file searching with native VIM commands easier.

The plugin provides two VIM commands: `FindPath` and `Cd`. `FindPath` will fill the path variable. It is automatically run when VIM launches. `Cd` is just like `cd` except it runs `FindPath` just after the directory changes.

`FindPath` Looks for a parent `.git` directory and uses that as the project root directory. It uses the current directory if no repository is found.

It also reads `.gitignore` in project root if found, and ignores listed directories.

Works very well with `:find` and `gf` (TIP: use `:set suffixesadd` for `gf` to recognize filenames without extensions)
