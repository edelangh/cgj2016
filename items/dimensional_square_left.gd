tool
extends Sprite

export(int, "Small", "Medium", "Big") var starting_scale = 1 setget rescale
var current_scale


func _ready():
	set_z(0)
	if get_tree().is_editor_hint():
		return
	rescale(starting_scale)
	if get_node("/root/global") != null:
		get_node("/root/global").connect("dimension_left", self, "on_dimension_left", [])
		get_node("/root/global").connect("dimension_right", self, "on_dimension_right", [])


func rescale(new_scale):
	starting_scale = new_scale
	var s = [0.25, 0.5, 1][starting_scale]
	set_scale(Vector2(s, s))
	current_scale = starting_scale - 1


func on_dimension_left(scale):
	if get_tree().is_editor_hint():
		return
	if current_scale == -1:
		get_node("anim").play_backwards("right")
		current_scale += 1
	elif current_scale == 0:
		get_node("anim").play("left")
		current_scale += 1
		

func on_dimension_right(scale):
	if get_tree().is_editor_hint():
		return
	if current_scale == 1:
		get_node("anim").play_backwards("left")
		current_scale -= 1
	elif current_scale == 0:
		get_node("anim").play("right")
		current_scale -= 1
