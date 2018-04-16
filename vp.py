"""
Non-scary script for management of vim plugins.

This script doesn't do anything! It won't touch your files without your
permission. Furthermore, *literally* nothing will happen unless you choose to
execute the script. Nothing is done on vim startup, so there is no extra cost
added to your vim startup time.

All it does is generate bash scripts, which you don't need to execute until you
are satisfied that nothing unexpected is about to happen.
"""

import argparse
from subprocess import check_output
import os
# To ensure python2 compatibility
from six.moves import input

COMMAND_FILE = "AUTOvp.sh"
BUNDLE_PATH = ".vim/bundle"
GIT_OPTIONS = "--depth 1"
DIVIDER = "-"*40

def home():
    """ Return path to home directory """
    return os.path.expanduser("~")

def myopen(filename, method):
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
    return open(filename, method)

def split_pairs(text, expected_prefix):
    # Yield lines with the expected_prefix and their preceding comments
    u = text.split('\n')
    for i in range(1, len(u)):
        if u[i].startswith(expected_prefix) and u[i-1] and u[i-1][0]=='"':
            yield u[i-1], u[i]

def get_plugins():
    """
    Get details of all the desired plugins from the .vimrc file
    """

    expected_prefix = "set runtimepath+=~/{}/".format(BUNDLE_PATH)
    command = "grep -B1 '^{}' {}/.vimrc".format(expected_prefix, home())
    # print("command:", command)
    grep_output = check_output(command, shell=True).decode('utf8').strip()

    for comment, rtpath in split_pairs(grep_output, expected_prefix):

        url = comment[1:].lstrip()
        name_from_url = "/".join(url.split()[0].split('/')[3:])
        name_from_path = rtpath[len(expected_prefix):]
        if not name_from_url.endswith(name_from_path+'.git'):
            print("Failed to understand the lines:\n{}\n{}".format(comment, rtpath))
            print("name_from_url:", name_from_url)
            print("name_from_path:", name_from_path)
            continue

        # Remove the trailing .git
        name_from_url = name_from_url[:-4]

        path = "/".join([home(), BUNDLE_PATH, name_from_path])

        yield (name_from_url, url, path)

def finish():
    print("Commands to be run have been written in {}".format(COMMAND_FILE))
    print("To run, type $ bash {}".format(COMMAND_FILE))

def clean_up():
    unneeded_plugins = []

    # First find paths that we want to keep
    paths = set(x[2].split('/')[-1] for x in get_plugins())

    for path in os.listdir("{}/{}".format(home(), BUNDLE_PATH)):
        if path not in paths:
            print("{:40s} no longer needed".format(path))
            unneeded_plugins.append(path)

    if not unneeded_plugins:
        print("No unused plugins found")
        return

    print(DIVIDER)
    f = myopen(COMMAND_FILE, 'w')
    f.write("set -e\n")
    for path in unneeded_plugins:
        f.write("rm -rf {}/{}/{}\n".format(home(), BUNDLE_PATH, path))
    f.close()

    finish()

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
    bundle_dir = "{}/{}".format(home(), BUNDLE_PATH)
    if not os.path.exists(bundle_dir):
        os.makedirs(bundle_dir)

    f = myopen(COMMAND_FILE, 'w')
    f.write("set -e\n")
    f.write("cd {}/{}\n".format(home(), BUNDLE_PATH))
    for url in urls:
        f.write("git clone {} {}\n".format(GIT_OPTIONS, url))

    # Helptags command
    for path in paths:
        f.write('vim -u NONE -c "helptags {}/doc" -c q\n'.format(path))
    f.close()

    finish()

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

    f = myopen(COMMAND_FILE, 'w')
    f.write("set -e\n")
    for p in paths:
        f.write("cd {}\n".format(p))
        f.write("git pull\n")

    f.close()

    finish()

if __name__=="__main__":
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
