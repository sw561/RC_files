import subprocess
def get_window():
	x = subprocess.check_output("tmux display-message -p '#I'", shell=True)
	win = int(x.strip())
	return win

def move_window(window, destination):
	command = "tmux swap-window -s {} -t {}".format(window, destination)
	subprocess.check_call(command, shell=True)

# Move right
def move_right():
	win = get_window()
	move_window(win, win+1)

# Move left
def move_left():
	win = get_window()
	move_window(win, win-1)
