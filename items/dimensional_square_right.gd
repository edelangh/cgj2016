
extends Sprite

var current_scale = 0

func _ready():
	global.connect("dimension_left", self, "on_dimension_left", [])
	global.connect("dimension_right", self, "on_dimension_right", [])

func on_dimension_left(scale):
	if scale == 0:
		get_node("anim").play_backwards("right")
	elif scale != current_scale:
		get_node("anim").play("left")
	current_scale = scale

func on_dimension_right(scale):
	if scale == 0:
		get_node("anim").play_backwards("left")
	elif scale != current_scale:
		get_node("anim").play("right")
	current_scale = scale
