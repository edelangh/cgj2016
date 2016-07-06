
extends Node2D

func _ready():
	global.main_camera = self
	set_process(true)
	
func _process(delta):
	if global.gameover:
		return
	set_pos(Vector2(get_pos().x + global.WALK_SPEED_MIN * delta, clamp(global.player.get_pos().y, 0, 536)))