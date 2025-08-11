extends Control

func set_time_label(value):
	get_node("TimeLabel").text = "TIME: " + str(value)
