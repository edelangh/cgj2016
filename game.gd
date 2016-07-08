
extends Node2D

var score_float


func _ready():
	score_float = global.score
	set_process_input(true)
	set_process(true)


func _input(event):
	
	if event.is_action_pressed("spell_left"):
		global.scale_factor = clamp(global.scale_factor - 1, global.SCALE_FACTOR_MIN, global.SCALE_FACTOR_MAX)
		global.emit_signal("dimension_left", global.scale_factor)
	elif event.is_action_pressed("spell_right"):
		global.scale_factor = clamp(global.scale_factor + 1, global.SCALE_FACTOR_MIN, global.SCALE_FACTOR_MAX)
		global.emit_signal("dimension_right", global.scale_factor)
	elif event.is_action_pressed("escape"):
		scene_manager.set_scene("res://menu/main.tscn")


func _process(delta):
	if not global.gameover:
		score_float += global.SCORE_BY_SEC * global.score_multiplier * delta
		global.score = floor(score_float)
		if global.score_multiplier > 1:
			global.score_multiplier_timer -= delta
			if global.score_multiplier_timer < 0:
				global.score_multiplier -= 1
				if global.score_multiplier == 1:
					global.score_multiplier_timer = 0
				else:
					global.score_multiplier_timer = global.SCORE_MULTIPLIER_DURATION
	else:
		score_float = 0