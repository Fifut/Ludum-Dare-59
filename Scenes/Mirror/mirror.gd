class_name Mirror extends StaticBody3D


@onready var angle_label: Label3D = %AngleLabel


func _physics_process(_delta: float) -> void:
	angle_label.text = str(floori(global_rotation_degrees.y))
	global_rotation_degrees.y = snappedf(global_rotation_degrees.y, 5.0)
