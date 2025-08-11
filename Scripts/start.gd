extends StaticBody2D

@onready var spawn_pos = get_node("SpawnPosition")

func get_spawn_pos():
	return spawn_pos.global_position
