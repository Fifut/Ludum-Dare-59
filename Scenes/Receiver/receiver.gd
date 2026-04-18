extends AnimatableBody3D


var _received_count: int = 0


func _on_receiver_area_3d_body_entered(body: Node3D) -> void:
	if body is LDSignal:
		body.queue_free()
		_received_count += 1
		print(_received_count)
