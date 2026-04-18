extends Node3D


@onready var level_audio: AudioStreamPlayer3D = %LevelAudio


func _ready() -> void:
	hide()
	global_position.y = -2.0


func _process(delta: float) -> void:
	if visible:
		global_position.y = lerpf(global_position.y, 0.0, delta)


func _on_visibility_changed() -> void:
	if visible:
		level_audio.play()
