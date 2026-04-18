extends Node3D

@onready var skybox_mesh: MeshInstance3D = %SkyboxMesh

@onready var xp_label: Label = %XPLabel


func _ready() -> void:
	skybox_mesh.show()


func _on_receiver_on_ld_signal_received(total: int) -> void:
	xp_label.text = str(total)
