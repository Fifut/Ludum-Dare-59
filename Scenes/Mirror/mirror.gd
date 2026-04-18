class_name Mirror extends StaticBody3D


@onready var angle_label: Label3D = %AngleLabel


func _physics_process(delta: float) -> void:
	angle_label.text = str(floori(global_rotation_degrees.y))
