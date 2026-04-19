class_name Player extends CharacterBody3D

@export var grid: Grid

@onready var body_mesh: MeshInstance3D = %BodyMesh
@onready var camera: Camera3D = $Camera3D
@onready var interact_label: Label = %InteractLabel

const SPEED: float = 5.0
const JUMP_VELOCITY: float = 4.5
const MOUSE_SENSITIVITY: float = 0.001

var _interact: Node3D = null
var _stop_move: bool = false
var _grab_in_progress: bool = false
var _grab_rotation: Vector3 = Vector3.ZERO


func _ready() -> void:
	body_mesh.hide()
	interact_label.hide()
	Input.mouse_mode = Input.MOUSE_MODE_CAPTURED


func _input(event: InputEvent) -> void:
	
	if event.is_action_pressed("interact"):
		
		if _interact is Antena:
			_stop_move = _interact.interact_toggle()
			camera.current = not _stop_move
		
		#elif (_interact is Receiver or _interact is Mirror) and not _grab_in_progress:
		elif (_interact is Mirror) and not _grab_in_progress:
			_grab_in_progress = true
			_grab_rotation = _interact.global_rotation_degrees
			_interact.reparent(self)
		
		elif (_interact is Mirror) and _grab_in_progress:
		#elif (_interact is Receiver or _interact is Mirror) and _grab_in_progress:		
			_grab_in_progress = false
			_interact.reparent(get_tree().root)

	
	if _grab_in_progress and event.is_action_pressed("rotation_left"):
		_interact.rotation_degrees.y += 15.0
		_grab_rotation = _interact.global_rotation_degrees
		
	elif _grab_in_progress and event.is_action_pressed("rotation_right"):
		_interact.rotation_degrees.y -= 15.0	
		_grab_rotation = _interact.global_rotation_degrees
		
	elif _interact and _grab_in_progress:
		_interact.global_rotation_degrees = _grab_rotation
	
	
	grid.visible = _grab_in_progress
		
	
	if event is InputEventMouseMotion and not _stop_move:
		rotate_y(-event.relative.x * MOUSE_SENSITIVITY)
		
		camera.rotate_x(-event.relative.y * MOUSE_SENSITIVITY)
		camera.rotation_degrees.x = clamp(camera.rotation_degrees.x, -80, 80)
		
	if event.is_action_pressed("ui_cancel"):
		if Input.mouse_mode == Input.MOUSE_MODE_CAPTURED:
			Input.mouse_mode = Input.MOUSE_MODE_VISIBLE
		else:
			Input.mouse_mode = Input.MOUSE_MODE_CAPTURED


func _physics_process(delta: float) -> void:
	
	if _grab_in_progress:
		interact_label.text = "E to drop - Mouse Left/Right rotate"
		
	elif _stop_move:
		interact_label.text = "E to exit"
		
	elif _interact is Antena:
		interact_label.text = "E to aiming"
	
	#elif _interact is Receiver:
		#interact_label.text = "E to grab"
	
	elif _interact is Mirror:
		interact_label.text = "E to grab"
	
	if _interact:
		interact_label.show()
	else:
		interact_label.hide()
		
		
	if _stop_move:
		return
	
	if not is_on_floor():
		velocity.y -= ProjectSettings.get_setting("physics/3d/default_gravity") * delta
		
	if Input.is_action_just_pressed("ui_accept") and is_on_floor():
		velocity.y = JUMP_VELOCITY
		
	var input_dir := Input.get_vector("move_left", "move_right", "move_forward", "move_backward")
	
	var direction := (transform.basis * Vector3(input_dir.x, 0, input_dir.y)).normalized()
	if direction:
		velocity.x = direction.x * SPEED
		velocity.z = direction.z * SPEED
	else:
		velocity.x = move_toward(velocity.x, 0, SPEED)
		velocity.z = move_toward(velocity.z, 0, SPEED)
		
	move_and_slide()



func _on_interact_detection_body_entered(body: Node3D) -> void:
	if not _interact:
		_interact = body
		
		print("Interact start detection : " + str(_interact))


func _on_interact_detection_body_exited(body: Node3D) -> void:
	if body == _interact:
		print("Interact end detection : " + str(_interact))
		_interact = null	
