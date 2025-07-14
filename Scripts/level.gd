extends Node2D

@onready var starting_position = get_node("StartPosition")

func _process(delta):
	if Input.is_action_just_pressed("quit"):
		get_tree().quit()
	elif Input.is_action_just_pressed("reset"):
		get_tree().reload_current_scene()
		


func _on_deathzone_body_entered(body: CharacterBody2D) -> void:
	body.velocity = Vector2.ZERO
	body.global_position = starting_position.global_position
