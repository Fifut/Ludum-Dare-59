extends GPUParticles3D


func _on_visibility_changed() -> void:
	if visible:
		emitting = true
