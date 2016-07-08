
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
var player
var WALK_SPEED = 1000
const WALK_SPEED_MIN = 350
const WALK_SPEED_MAX = 1000
var gameover = false
var scale_factor = 0
const SCALE_FACTOR_MIN = -1
const SCALE_FACTOR_MAX = 1
const PLAYER_START_POS = Vector2(-600, 0)
var y_max_to_die
var x_max_to_die

func _ready():
	var screen_size = get_viewport().get_rect().size
	y_max_to_die = screen_size.y * 1.5
	x_max_to_die = -screen_size.x * 0.7

func run_death():
	if not gameover:
		var gameOver = preload('res://gameover/gameover.tscn')
		var game = gameOver.instance()
		game.set_pos(main_camera.get_pos())
		main_camera.add_child(game)

