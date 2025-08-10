extends Node2D

@onready var starting_position = get_node("StartPosition")
@onready var player = get_node("Player")

func _ready() -> void:
	var traps = get_tree().get_nodes_in_group("traps")
	
	for trap in traps:
		trap.connect("touched_player", _on_trap_touched_player)

func _process(delta):
	if Input.is_action_just_pressed("quit"):
		get_tree().quit()
	elif Input.is_action_just_pressed("reset"):
		get_tree().reload_current_scene()
		


func _on_deathzone_body_entered(body: CharacterBody2D) -> void:
	reset_player()


func _on_trap_touched_player():
	reset_player()

func reset_player() -> void:
	player.velocity = Vector2.ZERO
	player.global_position = starting_position.global_position
