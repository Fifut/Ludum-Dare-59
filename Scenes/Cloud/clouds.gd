extends Node3D


const CLOUD = preload("uid://btm5rg6xk5khq")


func _ready() -> void:
	for i in range(30):
		_on_timer_timeout()


func _on_timer_timeout() -> void:
	var cloud = CLOUD.instantiate()
	#cloud.position.x = randf_range(-200.0,200.0)
	#cloud.position.y = randf_range(60.0,100.0)
	#cloud.position.z = randf_range(-200.0,150.0)
	add_child(cloud, true)
