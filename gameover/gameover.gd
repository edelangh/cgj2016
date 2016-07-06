
extends Control


func _ready():
	global.gameover = true
	if global.score > global.highscore:
		global.highscore = global.score
	set_process_input(true)


func _input(event):
	if global.gameover and event.is_action_released("ui_accept"):
			global.gameover = false
			global.score = 0
			global.score_multiplier = 1
			scene_manager.set_scene('res://game.tscn')
			queue_free()