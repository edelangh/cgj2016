
extends Node

signal dimension_left(scale)
signal dimension_right(scale)

var main_camera = null
var camera_pos = Vector2()
var player_pos = Vector2()
var WALK_SPEED = 300
const WALK_SPEED_MIN = 7
const WALK_SPEED_MAX = 9
var gameover = false
var scale_factor = 0
const SCALE_FACTOR_MIN = -1
const SCALE_FACTOR_MAX = 1

func run_death():
	if not gameover:
		var gameOver = preload('res://gameover/gameover.tscn')
		var game = gameOver.instance()
		game.set_pos(camera_pos)
		main_camera.add_child(game)

func _ready():
	pass
