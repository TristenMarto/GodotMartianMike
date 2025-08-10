extends Node2D

signal touched_player

func _on_area_2d_body_entered(body: Node2D) -> void:
	if body is Player:
		emit_signal("touched_player")
