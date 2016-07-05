
extends KinematicBody2D

var WALK_SPEED =  global.WALK_SPEED
var WALK_SPEED_MAX =  global.WALK_SPEED_MIN
var force = Vector2(WALK_SPEED, 0)
var velocity = Vector2()

func _fixed_process(delta):
	velocity += force * delta
	global.camera_pos = get_pos() 
	var motion = velocity * delta
	if motion.x > WALK_SPEED_MAX:
		motion.x = WALK_SPEED_MAX
	move(motion)

func _ready():
	set_fixed_process(true)
	pass