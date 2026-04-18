extends Camera3D



func _process(_delta: float) -> void:
	if Input.is_action_just_pressed("camera_god"):
		if not current:
			make_current()
		else:
			clear_current()
