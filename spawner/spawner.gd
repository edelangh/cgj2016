
extends Node2D

export(String, FILE) var tileset_test = null

var store = []
var rooms = []
var instance_count = 0
const PATTERNS_WIDTH = 64 * 40
var start_pos

func _ready():
	start_pos = -get_viewport().get_rect().size.x * 0.5
	if tileset_test != null:
		var pattern = load(tileset_test).instance()
		pattern.set_pos(Vector2(start_pos, 0))
		add_child(pattern)
		set_process(true)
		return
	store.push_back(preload('res://patterns/p_001.tscn'))
	store.push_back(preload('res://patterns/p_002.tscn'))
	var room = store[0].instance()
	room.set_pos(Vector2(start_pos, 0))
	add_child(room)
	rooms.push_back(room)
	set_process(true)

func _process(delta):
	if rooms.size() < 3:
		instance_count += 1
		if tileset_test != null:
			var room = load(tileset_test).instance()
			room.set_pos(Vector2(start_pos + PATTERNS_WIDTH * instance_count, 0))
			add_child(room)
		else:
			var room = store[rand_range(0, store.size())].instance()
			room.set_pos(Vector2(start_pos + PATTERNS_WIDTH * instance_count, 0))
			add_child(room)
			rooms.push_back(room)
	for room in rooms:
		var dist = room.get_pos() - global.main_camera.get_pos()
		var len = dist.length()
		if dist.x < 0 and len > PATTERNS_WIDTH:
			rooms.erase(room)
