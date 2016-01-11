# vim-pathfinder

Vim plugin that manages the path variable. Works well with `:find` and `gf` (TIP: use `:set suffixesadd` for `gf` to recognize filenames without extensions)

Looks for a parent `.git` directory and uses that as the project root directory. Uses the current directory if no repository is found.

Reads `.gitignore` in project root if found, and ignores listed directories.
