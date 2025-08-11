extends CharacterBody2D
class_name Player

@export var gravity = 200
@export var speed = 125
@export var jump_force = 150

@onready var animated_sprite = get_node("AnimatedSprite2D")

var active = true

func _physics_process(delta: float) -> void:
	if active == true:
		_handle_gravity(delta)
		_handle_jump()
		_handle_movement()

func _handle_gravity(_delta: float) -> void:
	if is_on_floor() == false:
		velocity.y += gravity*_delta
	if velocity.y > 500:
		velocity.y = 500

func _handle_movement() -> void:
	var direction = Input.get_axis("move_left", "move_right")
	if direction != 0:
		animated_sprite.flip_h = (direction == -1)
	velocity.x = direction*speed
	move_and_slide()
	update_animations(direction)
	
func _handle_jump() -> void:
	if Input.is_action_just_pressed("jump") && is_on_floor():
		jump(jump_force)

func update_animations(direction) -> void:
	if is_on_floor():
		if direction == 0:
			animated_sprite.play("Idle")
		else:
			animated_sprite.play("Run")
	else:
		if velocity.y < 0:
			animated_sprite.play("Jump")
		else:
			animated_sprite.play("Fall")
			

func jump(force):
	velocity.y = -force
	AudioPlayer.play_sfx("jump")
