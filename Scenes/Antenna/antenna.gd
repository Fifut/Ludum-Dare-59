class_name Antena extends StaticBody3D


@export var ld_signal: PackedScene

@onready var antena_pivot_point: Marker3D = %AntenaPivotPoint
@onready var ray_cast_3d: RayCast3D = %RayCast3D
@onready var signal_emit_marker_3d: Marker3D = %SignalEmitMarker3D
@onready var beep_audio: AudioStreamPlayer3D = %BeepAudio
@onready var emit_timer: Timer = %EmitTimer
@onready var target_camera_3d: Camera3D = %TargetCamera3D
@onready var signal_hole_light: OmniLight3D = %SignalHoleLight
@onready var progress_mesh: MeshInstance3D = %ProgressMesh
@onready var cool_down_timer: Timer = %CoolDownTimer
@onready var progress_small_mesh: MeshInstance3D = %ProgressSmallMesh
@onready var idle_timer: Timer = %IdleTimer


var _interact: bool = false
var _planet_detected: bool = false
var _emit_count: int = 0

func _ready() -> void:
	progress_small_mesh.scale.y = 0.0
	progress_mesh.scale.y = 0.0
	signal_hole_light.light_energy = 0.0
	

func _process(delta: float) -> void:

	if cool_down_timer.is_stopped():
		progress_mesh.scale.y = _emit_count / 6.0
		progress_small_mesh.scale.y = _emit_count / 6.0
	else:
		progress_mesh.scale.y = cool_down_timer.time_left / cool_down_timer.wait_time
		progress_small_mesh.scale.y = cool_down_timer.time_left / cool_down_timer.wait_time
	
	progress_mesh.position.y = (progress_mesh.scale.y - 1.0) * (0.75/2)
	progress_small_mesh.position.y = (progress_mesh.scale.y - 1.0) * 0.05


	if ray_cast_3d.is_colliding() and not _planet_detected:
		_planet_detected = true
		_create_signal()
		emit_timer.start()
	elif not ray_cast_3d.is_colliding() and _planet_detected:
		_planet_detected = false
		emit_timer.stop()
	
	signal_hole_light.light_energy = lerpf(signal_hole_light.light_energy, 0.0, 0.2)
	
		
	if not _interact:
		return
	
	var speed: float = 10.0
	if Input.is_action_pressed("speed"):
		speed = 50.0
		
	if Input.is_action_pressed("move_left") and antena_pivot_point.rotation_degrees.y < 90:
		antena_pivot_point.rotation_degrees.y += delta * speed
		
	elif Input.is_action_pressed("move_right") and antena_pivot_point.rotation_degrees.y > -90:
		antena_pivot_point.rotation_degrees.y -= delta * speed
		
	if Input.is_action_pressed("move_forward") and antena_pivot_point.rotation_degrees.x < 80:
		antena_pivot_point.rotation_degrees.x += delta * speed
		
	elif Input.is_action_pressed("move_backward") and antena_pivot_point.rotation_degrees.x > 0:
		antena_pivot_point.rotation_degrees.x -= delta * speed
	

func _create_signal():

	if _emit_count >= 6:
		return
			
	_emit_count += 1
	idle_timer.start()
	
	if _emit_count >= 6:
		cool_down_timer.start()
		
	var ld_sig: LDSignal = ld_signal.instantiate()
	ld_sig.global_transform =  signal_emit_marker_3d.global_transform
	signal_emit_marker_3d.add_child(ld_sig, true)
	
	signal_hole_light.light_energy = 3.0
	beep_audio.play()
	

func interact_toggle() -> bool:
	_interact = not _interact
	
	if _interact:
		target_camera_3d.make_current()

	return _interact


func _on_emit_timer_timeout() -> void:
	_create_signal()


func _on_cool_down_timer_timeout() -> void:
	_emit_count = 0


func _on_idle_timer_timeout() -> void:
	cool_down_timer.start()
