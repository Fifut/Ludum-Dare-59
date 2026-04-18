extends Node3D


@onready var xp_label: Label = %XPLabel


func _on_receiver_on_ld_signal_received(total: int) -> void:
	xp_label.text = str(total)
