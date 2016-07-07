
extends Sprite

export(int, "Small", "Medium", "Big") var starting_scale = 1
var current_scale

func _ready():
	var s = [0.25, 0.5, 1][starting_scale]
	set_scale(Vector2(s, s))
	current_scale = starting_scale - 1
	print(starting_scale, current_scale)
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
