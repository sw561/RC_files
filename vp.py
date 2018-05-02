"""
Non-scary script for management of vim plugins.

This script doesn't do anything! It won't touch your files without your
permission. Furthermore, *literally* nothing will happen unless you choose to
execute the script. Nothing is done on vim startup, so there is no extra cost
added to your vim startup time.

All it does is generate bash scripts, which you don't need to execute until you
are satisfied that nothing unexpected is about to happen.
"""

from __future__ import print_function
from six.moves import input
from contextlib import contextmanager
import os
import re

COMMAND_FILE = "AUTOvp.sh"
BUNDLE_PATH = ".vim/bundle/"
HOME = os.path.expanduser("~")
VIMRC_PATH = os.path.join(HOME, ".vimrc")

GIT_OPTIONS = "--depth 1"
DIVIDER = "-"*40

@contextmanager
def myopen(filename, *args, **kwargs):
    """
    Open a file for writing, and ensure we are not going to overwrite something
    important
    """
    if os.path.isfile(filename):
        print("{} will be overwritten".format(filename))
        try:
            input("Press Enter to continue, CTRL-C to cancel\n")
        except KeyboardInterrupt:
            print('')
            exit()
    f = open(filename, *args, **kwargs)
    try:
        yield f
        print("Commands to be run have been written in {}".format(COMMAND_FILE))
        print("To run, type $ bash {}".format(COMMAND_FILE))
    finally:
        f.close()

def get_pairs(expected_prefix):
    with open(VIMRC_PATH) as f:
        prev = None
        for line in f:
            line = line.strip()
            if re.match(expected_prefix, line) and re.match('^"', prev):
                yield prev, line
            prev = line

def get_plugins():
    """
    Get details of all the desired plugins from the .vimrc file
    """
    expected_prefix = "^set runtimepath\+=~/{}".format(BUNDLE_PATH)

    for comment, rtpath in get_pairs(expected_prefix):

        url = comment[1:].lstrip()
        name_from_url = "/".join(url.split()[0].split('/')[3:])
        name_from_path = rtpath[len(expected_prefix)-2:]
        if not name_from_url.split("/")[1] == name_from_path+'.git':
            print("Failed to understand the lines:\n{}\n{}".format(comment, rtpath))
            print("name_from_url:", name_from_url)
            print("name_from_path:", name_from_path)
            continue

        # Remove the trailing .git
        name_from_url = name_from_url[:-4]

        path = os.path.join(HOME, BUNDLE_PATH, name_from_path)

        yield (name_from_url, url, path)

def clean_up():
    unneeded_plugins = []

    # First find paths that we want to keep
    paths = set(x[2].split('/')[-1] for x in get_plugins())

    for path in os.listdir(os.path.join(HOME, BUNDLE_PATH)):
        if path not in paths:
            print("{:40s} no longer needed".format(path))
            unneeded_plugins.append(path)

    if not unneeded_plugins:
        print("No unused plugins found")
        return

    print(DIVIDER)
    with myopen(COMMAND_FILE, 'w') as f:
        f.write("set -e\n")
        for path in unneeded_plugins:
            f.write("rm -rf {}\n".format(os.path.join(HOME, BUNDLE_PATH, path)))

def main():
    urls = []
    plugins = []
    paths = []

    print("Checking for plugins to be installed...")
    for name, url, path in get_plugins():
        if os.path.exists(path):
            print("{:40s} already installed".format(name))
        else:
            urls.append(url)
            plugins.append(name)
            paths.append(path)
    print(DIVIDER)

    if not plugins:
        print("No new plugins to be installed.")
        return

    for name in plugins:
        print("{:40s} needs to be installed".format(name))
    print(DIVIDER)

    # Ensure the folder actually exists
    bundle_dir = os.path.join(HOME, BUNDLE_PATH)
    if not os.path.exists(bundle_dir):
        os.makedirs(bundle_dir)

    with myopen(COMMAND_FILE, 'w') as f:
        f.write("set -e\n")
        f.write("cd {}\n".format(os.path.join(HOME, BUNDLE_PATH)))
        for url in urls:
            f.write("git clone {} {}\n".format(GIT_OPTIONS, url))

        # Helptags command
        for path in paths:
            f.write('vim -u NONE -c "helptags {}" -c q\n'.format(os.path.join(path, "doc")))

def update():
    urls = []
    plugins = []
    paths = []

    print("Checking for installed and wanted plugins...")
    for name, url, path in get_plugins():
        if os.path.exists(path):
            urls.append(url)
            plugins.append(name)
            paths.append(path)

    with myopen(COMMAND_FILE, 'w') as f:
        f.write("set -e\n")
        for p in paths:
            f.write("cd {}\n".format(p))
            f.write("git pull\n")

if __name__=="__main__":
    import argparse
    parser = argparse.ArgumentParser(
        description="vp is a non-scary script to install your vim plugins"
        )
    parser.add_argument("-c", "--clean", action="store_true",
                        help="Clean up unused plugins"
                        )
    parser.add_argument("-u", "--update", action="store_true",
                        help="Update installed plugins"
                        )
    args = parser.parse_args()

    if args.clean:
        clean_up()
    elif args.update:
        update()
    else:
        # Script is by default verbose
        main()
