
extends Node2D

var y_max

func _ready():
	y_max = get_viewport().get_rect().size.y / 2
	global.main_camera = self
	set_process(true)
	
func _process(delta):
	if global.gameover:
		return
	set_pos(Vector2(get_pos().x + global.WALK_SPEED_MIN * delta, min(global.player.get_pos().y, y_max)))