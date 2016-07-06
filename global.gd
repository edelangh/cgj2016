
extends Node

signal dimension_left(scale)
signal dimension_right(scale)

const SCORE_BY_SEC = 2
const SCORE_MULTIPLIER_DURATION = 2 # seconds
var score = 0
var highscore = 0
var score_multiplier = 1
var score_multiplier_timer = 0
var main_camera = null
var camera_pos = Vector2()
var player_pos = Vector2()
var WALK_SPEED = 1000
const WALK_SPEED_MIN = 7
const WALK_SPEED_MAX = 20
var gameover = false
var scale_factor = 0
const SCALE_FACTOR_MIN = -1
const SCALE_FACTOR_MAX = 1
const PLAYER_START_POS = Vector2(-500, 300)

func run_death():
	if not gameover:
		var gameOver = preload('res://gameover/gameover.tscn')
		var game = gameOver.instance()
		game.set_pos(camera_pos)
		main_camera.add_child(game)

