extends MeshInstance3D


var _speed: float = 1.0

func _ready() -> void:
	mesh.material.albedo_color.a = 0.0
	_speed = randf_range(2.0, 4.0)
	scale *= randf_range(1.0, 3.0)
	position.x = randf_range(-200.0,200.0)
	position.z = randf_range(-200.0,200.0)


func _process(delta: float) -> void:
	position.z += delta * _speed
	mesh.material.albedo_color.a = lerpf(mesh.material.albedo_color.a, 1.0, delta)
	
	if position.z > 200.0:
		queue_free()
