class_name Receiver extends StaticBody3D


signal on_ld_signal_received(total: int)

@export var max_ld_signal: int = 5

@onready var received_audio: AudioStreamPlayer3D = %ReceivedAudio
@onready var progress_mesh: MeshInstance3D = %ProgressMesh

var _received_count: int = 0


func _process(delta: float) -> void:
	var ratio: float = _received_count / float(max_ld_signal)
	#progress_mesh.scale.y = ratio
	progress_mesh.scale.y = lerpf(progress_mesh.scale.y, ratio, delta)
	progress_mesh.position.y = (progress_mesh.scale.y - 1.0) * 0.5


func _on_receiver_area_3d_body_entered(body: Node3D) -> void:
	if body is LDSignal:
		received_audio.play()
		on_ld_signal_received.emit(_received_count)
		body.queue_free()
		
		_received_count += 1


func _on_decrease_timer_timeout() -> void:
	if _received_count > 0:
		_received_count -= 1
