
extends Control

# member variables here, example:
# var a=2
# var b="textvar"

var store = []
var rooms = []

func _ready():
	# Called every time the node is added to the scene.
	# Initialization here
	store.push_back(preload('res://patterns/p_001.tscn'))
	store.push_back(preload('res://patterns/p_002.tscn'))
	var room = store[0].instance()
	add_child(room)
	rooms.push_back(room)
	set_process(true)
	pass

func _process(delta):
	if rooms.size() < 3:
		var room = store[rand_range(0, store.size())].instance()
		var lol = global.camera_pos.x - fmod(global.camera_pos.x, 64)
		var pos = Vector2(64 * 40 * rooms.size() + lol, 0)
		room.set_pos(pos)
		add_child(room)
		rooms.push_back(room)
	for room in rooms:
		var dist = room.get_pos() - global.camera_pos
		var norm = dist.length()
		if dist.x < 0 and norm > 64 * 40:
			rooms.erase(room)