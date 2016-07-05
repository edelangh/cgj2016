
extends Control

func _ready():
	global.gameover = true
	set_process_input(true)
	pass

func _input(ev):
	if global.gameover:
		if (ev.type == InputEvent.MOUSE_BUTTON and ev.is_pressed() and ev.button_index == 1):
			global.gameover = false
			scene_manager.set_scene('res://game.tscn')
			queue_free()