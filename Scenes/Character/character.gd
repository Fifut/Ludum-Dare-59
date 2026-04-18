extends CharacterBody3D


@onready var camera: Camera3D = $Camera3D

@onready var interact_label: Label = %InteractLabel

const SPEED: float = 5.0
const JUMP_VELOCITY: float = 4.5
const MOUSE_SENSITIVITY: float = 0.001

var _interact_area: Area3D = null
var _stop_move: bool = false


func _ready() -> void:
	interact_label.hide()
	Input.mouse_mode = Input.MOUSE_MODE_CAPTURED


func _input(event: InputEvent) -> void:
	
	if _interact_area:
		if event.is_action_pressed("interact"):
			_stop_move = _interact_area.interact_toggle()
	
	
	if event is InputEventMouseMotion:
		rotate_y(-event.relative.x * MOUSE_SENSITIVITY)
		
		camera.rotate_x(-event.relative.y * MOUSE_SENSITIVITY)
		camera.rotation_degrees.x = clamp(camera.rotation_degrees.x, -80, 80)
		
	if event.is_action_pressed("ui_cancel"):
		if Input.mouse_mode == Input.MOUSE_MODE_CAPTURED:
			Input.mouse_mode = Input.MOUSE_MODE_VISIBLE
		else:
			Input.mouse_mode = Input.MOUSE_MODE_CAPTURED


func _physics_process(delta: float) -> void:
	
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


func _on_interact_detection_area_3d_area_entered(area: Area3D) -> void:
	if _interact_area == null:
		_interact_area = area
		interact_label.show()


func _on_interact_detection_area_3d_area_exited(area: Area3D) -> void:
	if area == _interact_area:
		_interact_area = null
		
	interact_label.hide()
