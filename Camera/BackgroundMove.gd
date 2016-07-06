
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
	if layer_lvl == 0:		move_speed = 75
	elif layer_lvl == 1:	move_speed = 100
	else:					move_speed = 125
	set_process(true)
	pass

func _process(delta):
	if global.gameover:
		return
	var cur_pos = get_pos()
	cur_pos.x -= move_speed * delta
	if cur_pos.x < -200:
		cur_pos.x = 1200 + 600 + 200
	set_pos(cur_pos)
	if printer:
		print(cur_pos)
