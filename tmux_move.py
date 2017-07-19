from subprocess import check_output, check_call

def get_window():
	x = check_output("tmux display-message -p '#I'", shell=True)
	win = int(x.strip())
	return win

def move_window(window, destination):
	command = "tmux swap-window -s {} -t {}".format(window, destination)
	check_call(command, shell=True)

def move_right():
	win = get_window()
	move_window(win, win+1)

def move_left():
	win = get_window()
	move_window(win, win-1)
