extends Node2D

@export var next_level: PackedScene = null
@onready var start = get_node("Start")
@onready var exit = get_node("Exit")

var player = null

func _ready() -> void:
	player = get_tree().get_first_node_in_group("player")
	player.global_position = start.get_spawn_pos()
	var traps = get_tree().get_nodes_in_group("traps")
	
	for trap in traps:
		trap.connect("touched_player", _on_trap_touched_player)
	
	exit.body_entered.connect(_on_exit_body_entered)

func _process(_delta):
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
	player.global_position = start.get_spawn_pos()

func _on_exit_body_entered(body):
	if body is Player:
		if next_level != null:
			player.active=false
			exit.animate()
			await get_tree().create_timer(1.5).timeout
			get_tree().change_scene_to_packed(next_level)
