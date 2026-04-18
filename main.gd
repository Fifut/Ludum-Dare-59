extends Control


@onready var orbit_marker: Marker3D = %OrbitMarker


func _on_start_button_pressed() -> void:
	get_tree().change_scene_to_packed(preload("uid://dhgwygr2gtd1c"))


func _process(delta: float) -> void:
	orbit_marker.rotation_degrees.y += delta
