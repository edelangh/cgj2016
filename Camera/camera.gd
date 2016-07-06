
extends KinematicBody2D

var WALK_SPEED =  global.WALK_SPEED
var WALK_SPEED_MAX =  global.WALK_SPEED_MIN
var force = Vector2(WALK_SPEED, 0)
var velocity = Vector2()

func _fixed_process(delta):
	if global.gameover:
		return
	var pos = get_pos()
	var p_pos = global.player_pos
	var motion = velocity * delta
	
	global.camera_pos = pos
	velocity += force * delta
	if motion.x > WALK_SPEED_MAX:
		motion.x = WALK_SPEED_MAX
	print(p_pos.y)
	set_pos(Vector2(pos.x, clamp(p_pos.y, 0, 536)))
	move(motion)

func _ready():
	global.main_camera = self
	set_fixed_process(true)