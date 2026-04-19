extends Node3D

@onready var level_label: Label = %LevelLabel
@onready var game_over_label: Label = %GameOverLabel
@onready var timer_label: Label = %TimerLabel

@onready var receiver_1: Receiver = %Receiver1

@onready var level_2: Node3D = $Level2
@onready var level_3: Node3D = %Level3
@onready var level_4: Node3D = %Level4


var _level: int = 1
var _start_time: int = 0

func _ready() -> void:
	game_over_label.hide()
	
	_start_time = Time.get_ticks_msec()

	
func _process(delta: float) -> void:
	var elapsed  = Time.get_ticks_msec() - _start_time
	elapsed /= 1000
	var minute = elapsed / 60
	var second = elapsed % 60
	if second < 10:
		timer_label.text = str(minute) + ":0" + str(second)
	else:
		timer_label.text = str(minute) + ":" + str(second)
	
	if Input.is_action_just_pressed("camera_god"):
		_next_level()



func _on_receiver_1_on_level_reach() -> void:
	_next_level()


func _next_level():
	_level += 1
	
	match _level:
		2:
			receiver_1.max_ld_signal = 10
			level_label.text = "2"
			level_2.show()
			
		3:
			receiver_1.max_ld_signal = 15
			level_label.text = "3"
			level_3.show()
			
		4:
			receiver_1.max_ld_signal = 20
			level_label.text = "4"
			level_4.show()
			
		5:
			level_label.text = "5"
			game_over_label.show()
