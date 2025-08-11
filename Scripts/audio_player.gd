extends Node

var hurt = preload("res://Assets/audio/hurt.wav")
var jump = preload("res://Assets/audio/jump.wav")

func play_sfx(sfx_name: String):
	var stream = null
	if sfx_name == "hurt":
		stream = hurt
	elif sfx_name == "jump":
		stream = jump
	else:
		print("Invalid SFX Name")
		return
	
	var asp = AudioStreamPlayer.new()
	asp.stream = stream
	asp.name == "SFX"
	add_child(asp)
	asp.play()
	await asp.finished
	asp.queue_free()
