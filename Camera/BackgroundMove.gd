
extends Sprite

# member variables here, example:
# var a=2
# var b="textvar"

export(int, "Layer1", "Layer2", "Layer3") var layer_lvl = 0
var move_speed = 0

var printer = false

func _ready():
	# Called every time the node is added to the scene.
	# Initialization here
	if layer_lvl == 0:		move_speed = 125
	elif layer_lvl == 1:	move_speed = 150
	else:					move_speed = 175
	set_process(true)
	pass

var width = 2700.75

func _process(delta):
	if global.gameover:
		return
	var cur_pos = get_pos()
	cur_pos.x -= move_speed * delta
	if cur_pos.x < -2342:
		cur_pos.x = get_pos().x + width + width - move_speed * delta
	set_pos(cur_pos)
	if printer:
		print(cur_pos)
