extends Area2D

@export var jump_force = 200

@onready var animated_sprite = get_node("AnimatedSprite2D")

func _on_body_entered(body: Node2D) -> void:
	if body is Player:
		animated_sprite.play("Jump")
		body.jump(jump_force)
