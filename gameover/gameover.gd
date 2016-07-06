
extends Control

func _ready():
	global.gameover = true
	set_process_input(true)
	pass

func _input(ev):
	if global.gameover and ev.is_action_released("ui_accept"):
			global.gameover = false
			scene_manager.set_scene('res://game.tscn')
			queue_free()