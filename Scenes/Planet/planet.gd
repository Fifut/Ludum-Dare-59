extends StaticBody3D


@export var color: Color = Color.BLUE


@onready var mesh_instance_3d: MeshInstance3D = %MeshInstance3D


func _ready() -> void:
	mesh_instance_3d.mesh.material.emission = color


func _process(delta: float) -> void:
	mesh_instance_3d.mesh.material.uv1_offset.x += delta / 50
