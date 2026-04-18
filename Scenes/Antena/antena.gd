class_name Antena extends StaticBody3D


@export var signal_scene: PackedScene

@onready var antena_pivot_point: Marker3D = %AntenaPivotPoint
@onready var ray_cast_3d: RayCast3D = %RayCast3D
@onready var signal_emit_marker_3d: Marker3D = %SignalEmitMarker3D
@onready var emit_timer: Timer = %EmitTimer


var enable_focus: bool = false

var _planet_detected: bool = false


func _process(delta: float) -> void:
	
	if ray_cast_3d.is_colliding() and not _planet_detected:
		_planet_detected = true
		_create_signal()
		emit_timer.start()
	elif not ray_cast_3d.is_colliding() and _planet_detected:
		_planet_detected = false
		emit_timer.stop()
		
		
	if not enable_focus:
		return
	
	var speed: float = 10.0
	if Input.is_action_pressed("speed"):
		speed = 100.0
		
	if Input.is_action_pressed("move_left"):
		antena_pivot_point.rotation_degrees.y += delta * speed
		
	elif Input.is_action_pressed("move_right"):
		antena_pivot_point.rotation_degrees.y -= delta * speed
		
	if Input.is_action_pressed("move_forward"):
		antena_pivot_point.rotation_degrees.x += delta * speed
		
	elif Input.is_action_pressed("move_backward"):
		antena_pivot_point.rotation_degrees.x -= delta * speed
	

func _create_signal():
	var sig: LDSignal = signal_scene.instantiate()
	sig.global_transform =  signal_emit_marker_3d.global_transform
	signal_emit_marker_3d.add_child(sig, true)


func _on_emit_timer_timeout() -> void:
	_create_signal()
