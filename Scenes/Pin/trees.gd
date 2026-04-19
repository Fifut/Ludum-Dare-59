@tool
extends Node3D


@export_tool_button("Populate") var pop = populate
@export_tool_button("Clear") var clr = clear

const PIN = preload("uid://dy2kb3umf2utg")
const RANGE = 200

func _ready() -> void:
	populate()


func clear():
	for child in get_children():
		child.queue_free()
	
	
func populate():
	randomize()
	clear()
	
	var step_x = randi_range(5, 10)
	for x in range(-RANGE, RANGE, step_x):
		var step_y = randi_range(5, 10)
		for z in range(-RANGE, RANGE, step_y):
			if -50 < x and x < 50 and -50 < z and z < 50:
				continue
				
			if randf() >= 0.5:
				var pin = PIN.instantiate()
				add_child(pin, true)
				pin.global_position.x = x
				pin.global_position.z = z
