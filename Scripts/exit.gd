extends Area2D

@onready var animated_exit_sprite = get_node("AnimatedSprite2D")

func _ready():
	pass

func animate():
	animated_exit_sprite.play("default")
