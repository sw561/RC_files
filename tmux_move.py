from subprocess import check_output, check_call

def get_window():
	x = check_output("tmux display-message -p '#I'", shell=True)
	win = int(x.strip())
	return win

def number_of_windows():
	x = check_output("tmux list-windows | wc -l", shell=True)
	n = int(x.strip())
	return n

def move_window(window, destination):
	command = "tmux swap-window -s {} -t {}".format(window, destination)
	check_call(command, shell=True)

def move_right():
	win = get_window()
	if win==number_of_windows():
		# If already the last window, do nothing
		return
	move_window(win, win+1)

def move_left():
	win = get_window()
	if win==1:
		return
	move_window(win, win-1)
