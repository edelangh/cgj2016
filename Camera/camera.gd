
extends Node2D


func _ready():
	global.main_camera = self
	set_process(true)


func _process(delta):
	if global.gameover or not global.player:
		return
	set_pos(Vector2(get_pos().x + global.WALK_SPEED_MIN * delta, min(global.player.get_pos().y, global.y_max_to_die)))