
extends Sprite

# member variables here, example:
# var a=2
# var b="textvar"

var move_speed = 100.0
var printer = false

func _ready():
	# Called every time the node is added to the scene.
	# Initialization here
	set_process(true)
	pass

func _process(delta):
	var cur_pos = get_pos()
	cur_pos.x -= move_speed * delta
	if cur_pos.x < -200:
		cur_pos.x = 1200 + 600 + 200
	set_pos(cur_pos)
	if printer:
		print(cur_pos)
