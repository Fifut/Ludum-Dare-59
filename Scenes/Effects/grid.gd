class_name Grid extends Node3D

@onready var mesh_instance_3d: MeshInstance3D = %MeshInstance3D

const GRID_SIZE: int = 100


func _ready() -> void:
	hide()
	
	var material = StandardMaterial3D.new()
	material.vertex_color_use_as_albedo = true
	material.shading_mode = BaseMaterial3D.SHADING_MODE_UNSHADED
	material.transparency = BaseMaterial3D.TRANSPARENCY_ALPHA

	var immediate_mesh = ImmediateMesh.new()
	immediate_mesh.surface_begin(Mesh.PRIMITIVE_LINES, material)
	immediate_mesh.surface_set_color(Color(Color.DARK_GREEN, 0.5))
	mesh_instance_3d.mesh = immediate_mesh
	
	# Lignes Z
	for i in range(GRID_SIZE):
		immediate_mesh.surface_add_vertex(Vector3(i, 0, 0))
		immediate_mesh.surface_add_vertex(Vector3(i, 0, GRID_SIZE))

	# Lignes X
	for i in range(GRID_SIZE):
		immediate_mesh.surface_add_vertex(Vector3(0, 0, i))
		immediate_mesh.surface_add_vertex(Vector3(GRID_SIZE, 0, i))

	immediate_mesh.surface_end()
