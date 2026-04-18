extends StaticBody3D


@export var signal_scene: PackedScene

@onready var signal_emit_marker_3d: Marker3D = %SignalEmitMarker3D
@onready var emit_timer: Timer = %EmitTimer




func _create_signal():
	var sig: LDSignal = signal_scene.instantiate()
	sig.global_transform =  signal_emit_marker_3d.global_transform
	signal_emit_marker_3d.add_child(sig, true)


func _on_emit_timer_timeout() -> void:
	_create_signal()
