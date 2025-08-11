extends CanvasLayer

@onready var win_screen = get_node("WinScreen")

func show_win_screen(flag: bool):
	win_screen.visible = flag
