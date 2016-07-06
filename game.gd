
extends Node2D

func _ready():
	set_process_input(true)

func _input(event):
	if event.is_action_pressed("spell_left"):
		global.scale_factor = clamp(global.scale_factor - 1, global.SCALE_FACTOR_MIN, global.SCALE_FACTOR_MAX)
		print("left input")
		global.emit_signal("dimension_left", global.scale_factor)
	elif event.is_action_pressed("spell_right"):
		global.scale_factor = clamp(global.scale_factor + 1, global.SCALE_FACTOR_MIN, global.SCALE_FACTOR_MAX)
		print("right input")
		global.emit_signal("dimension_right", global.scale_factor)