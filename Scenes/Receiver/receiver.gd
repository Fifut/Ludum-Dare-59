class_name Receiver extends StaticBody3D

signal on_level_reach()

@export var max_ld_signal: int = 5

@onready var received_audio: AudioStreamPlayer3D = %ReceivedAudio
@onready var progress_mesh: MeshInstance3D = %ProgressMesh
@onready var decrease_timer: Timer = %DecreaseTimer
@onready var count_label: Label3D = %CountLabel

var _received_count: int = 0


func _process(delta: float) -> void:
	var ratio: float = _received_count / float(max_ld_signal)
	progress_mesh.scale.y = lerpf(progress_mesh.scale.y, ratio, delta)
	progress_mesh.position.y = (progress_mesh.scale.y - 1.0) * 0.5
	
	count_label.text = str(_received_count) + "/" + str(max_ld_signal)


func _on_receiver_area_3d_body_entered(body: Node3D) -> void:
	if body is LDSignal:
		decrease_timer.start()
		_received_count += 1
		_received_count = clampi(_received_count, 0, max_ld_signal)
		
		received_audio.play()
		body.queue_free()
		
		if _received_count >= max_ld_signal:
			_received_count = 0
			on_level_reach.emit()


func _on_decrease_timer_timeout() -> void:
	if _received_count > 0:
		_received_count -= 1
