class_name Interactable extends Area3D


@export var antena: Antena = null

@onready var target_camera_3d: Camera3D = %TargetCamera3D

var _interact: bool = false



func interact(status: bool):
	_interact = status
	
	antena.enable_focus = _interact
	
	if _interact:
		target_camera_3d.make_current()
	else:
		target_camera_3d.clear_current()


func interact_toggle() -> bool:
	interact(not _interact)
	return _interact
