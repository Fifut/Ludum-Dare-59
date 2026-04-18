class_name LDSignal extends RigidBody3D


@export var speed: float = 5.0


func _ready() -> void:
	apply_central_impulse(global_transform.basis.z * speed)
