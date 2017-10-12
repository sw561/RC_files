# VP
Non-scary script for management of vim plugins.

This script doesn't do anything! It won't touch your files without your
permission. Furthermore, *literally* nothing will happen unless you choose to
execute the script. Nothing is done on vim startup, so there is no extra cost
added to your vim startup time.

All it does is generate bash scripts, which you don't need to execute until you
are satisfied that nothing unexpected is about to happen.

Finally, this is nothing more than a python script. You can run it in
any directory &mdash; no installation required.

### Adding Plugins

In your `.vimrc` (which `VP` will expect to find in your home directory)
declare the plugins you want to use in pairs of lines like so:

    " https://github.com/tpope/vim-repeat.git
    set runtimepath+=~/.vim/bundle/vim-repeat

There must not be any space between these two lines. The name of the repository
must match the name of the directory.

Further arguments to `git` can be added by simply including them in your
`.vimrc` after the URL. For example

    " https://github.com/tpope/vim-repeat.git -b special_branch

Run VP to check if any plugins need to be installed.

    python3 vp.py

If `VP` detects any plugins that need installing, a bash script will be
generated in `AUTOvp.sh`, which you can execute in the normal way

    bash AUTOvp.sh

Note that some plugins need to be compiled. VP won't compile anything
automatically.

### Removing Plugins

It is also possible to remove any plugins which you no longer want. Simply
comment out or remove the relevant lines from your `.vimrc`. Then run

    python3 vp.py --clean

A bash file will be generated in `AUTOrmvp.sh`. Run it to delete any
repositories that are no longer needed.
