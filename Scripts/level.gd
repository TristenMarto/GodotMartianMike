extends Node2D

@export var next_level: PackedScene = null
@export var level_time = 5
@export var is_final_level: bool = false

@onready var start = get_node("Start")
@onready var exit = get_node("Exit")
@onready var death_zone = get_node("Deathzone")
@onready var ui_layer = get_node("UILayer")
@onready var hud = get_node("UILayer/HUD")

var player = null
var timer_node = null
var time_left = null
var win = false

func _ready() -> void:
	player = get_tree().get_first_node_in_group("player")
	player.global_position = start.get_spawn_pos()
	var traps = get_tree().get_nodes_in_group("traps")
	
	for trap in traps:
		trap.connect("touched_player", _on_trap_touched_player)
	
	exit.body_entered.connect(_on_exit_body_entered)
	death_zone.body_entered.connect(_on_deathzone_body_entered)
	
	time_left = level_time
	hud.set_time_label(time_left)
	
	timer_node = Timer.new()
	timer_node.name = "Level Timer"
	timer_node.wait_time = 1
	timer_node.timeout.connect(_on_level_timer_timeout)
	add_child(timer_node)
	timer_node.start()


func _process(_delta):
	if Input.is_action_just_pressed("quit"):
		get_tree().quit()
	elif Input.is_action_just_pressed("reset"):
		get_tree().reload_current_scene()

func _on_deathzone_body_entered(body: CharacterBody2D) -> void:
	AudioPlayer.play_sfx("hurt")
	reset_player()

func _on_trap_touched_player():
	AudioPlayer.play_sfx("hurt")
	reset_player()

func _on_level_timer_timeout():
	if win == false:
		time_left -= 1
		hud.set_time_label(time_left)
		if time_left < 0:
			reset_player()
			time_left = level_time
			hud.set_time_label(time_left)

func reset_player() -> void:
	player.velocity = Vector2.ZERO
	player.global_position = start.get_spawn_pos()

func _on_exit_body_entered(body):
	if body is Player:
		if is_final_level or (next_level != null):
			player.active=false
			win = true
			exit.animate()
			await get_tree().create_timer(1.5).timeout
			if is_final_level:
				ui_layer.show_win_screen(true)
			else:
				get_tree().change_scene_to_packed(next_level)
