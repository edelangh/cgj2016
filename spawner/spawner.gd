
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
		add_child(load(tileset_test).instance())
		return	
	store.push_back(preload('res://patterns/p_001.tscn'))
	store.push_back(preload('res://patterns/p_002.tscn'))
	var room = store[0].instance()
	var pos = Vector2(start_pos, 0)
	instance_count += 1
	room.set_pos(pos)
	add_child(room)
	rooms.push_back(room)
	set_process(true)

func _process(delta):
	if tileset_test != null:
		return
	if rooms.size() < 3:
		var room = store[rand_range(0, store.size())].instance()
		var lol = global.camera_pos.x - fmod(global.camera_pos.x, 64)
		var pos = Vector2(start_pos + PATTERNS_WIDTH * instance_count, 0)
		instance_count += 1
		room.set_pos(pos)
		add_child(room)
		rooms.push_back(room)

	for room in rooms:
		var dist = room.get_pos() - global.camera_pos
		var norm = dist.length()
		if dist.x < 0 and norm > PATTERNS_WIDTH:
			rooms.erase(room)