class_name Receiver extends StaticBody3D


signal on_ld_signal_received(total: int)

@onready var received_audio: AudioStreamPlayer3D = %ReceivedAudio

var _received_count: int = 0


func _on_receiver_area_3d_body_entered(body: Node3D) -> void:
	if body is LDSignal:
		received_audio.play()
		on_ld_signal_received.emit(_received_count)
		body.queue_free()
		
		_received_count += 1
		print(_received_count)
