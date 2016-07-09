
extends Node2D

export(String, FILE) var tileset_test = null

var store = []
var rooms = []
var instance_count = 0
const PATTERNS_WIDTH = 64 * 40
var start_pos


func _ready():
	start_pos = -get_viewport().get_rect().size.x * 0.5
	store.push_back(preload('res://patterns/tuto.tscn'))
	store.push_back(preload('res://patterns/tresor.tscn'))
	store.push_back(preload('res://patterns/p_001.tscn'))
	store.push_back(preload('res://patterns/p_002.tscn'))
	store.push_back(preload('res://patterns/p_003.tscn'))
	var room = store[0].instance()
	room.set_pos(Vector2(start_pos, 0))
	add_child(room)
	rooms.push_back(room)
	set_process(true)


func _process(delta):
	if rooms.size() < 3:
		instance_count += 1
		var room
		if not tileset_test:
			room = store[1 + (randi() % (store.size() - 1))].instance()
		else:
			room = load(tileset_test).instance()
		room.set_pos(Vector2(start_pos + PATTERNS_WIDTH * instance_count, 0))
		add_child(room)
		rooms.push_back(room)
	for room in rooms:
		var dx = room.get_pos().x - global.main_camera.get_pos().x
		if dx < -get_viewport().get_rect().size.x * 0.7 - PATTERNS_WIDTH:
			rooms.erase(room)
			room.queue_free()
