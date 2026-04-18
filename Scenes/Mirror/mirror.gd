class_name Mirror extends StaticBody3D


@onready var angle_label: Label3D = %AngleLabel


func _process(_delta: float) -> void:
	angle_label.text = str(floori(global_rotation_degrees.y))
	global_rotation_degrees.y = snappedf(global_rotation_degrees.y, 5.0)
	
	var pos_x = snappedf(position.x, 1.0)
	var pos_z = snappedf(position.z, 1.0)
	
	position.x = lerpf(position.x, pos_x, 0.25)
	position.z = lerpf(position.z, pos_z, 0.25)
