extends Node3D

@onready var skybox_mesh: MeshInstance3D = %SkyboxMesh

@onready var xp_label: Label = %XPLabel
@onready var level_audio: AudioStreamPlayer = %LevelAudio

@onready var antenna_3: Antena = %Antenna3
@onready var mirror_2: Mirror = %Mirror2


func _ready() -> void:
	skybox_mesh.show()


func _on_receiver_on_ld_signal_received(total: int) -> void:
	xp_label.text = str(total)


func _on_receiver_1_on_level_reach() -> void:
	level_audio.play()
	antenna_3.show()
	mirror_2.show()
