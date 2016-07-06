
extends KinematicBody2D


const FLOOR_ANGLE_TOLERANCE = 40
var WALK_SPEED = global.WALK_SPEED
var WALK_SPEED_MAX = global.WALK_SPEED_MAX
var WALK_SPEED_MIN = global.WALK_SPEED_MIN

const GRAVITY = 2000
const JUMP_SPEED = 30000
const JUMP_SPEED_CONTINUE = 1500
const JUMP_MAX_AIRBORNE_TIME = 0.2

const SLIDE_STOP_VELOCITY = 1.0
const SLIDE_STOP_MIN_TRAVEL = 1.0

var velocity = Vector2()
var on_air_time = 100
var jumping = false
var can_continue_jump = false

var prev_jump_pressed = false
var die = false

func die():
	die = true
	if not global.gameover:
		var gameOver = preload('res://gameover/gameover.tscn')
		var game = gameOver.instance()
		game.set_pos(global.camera_pos)
		global.main_camera.add_child(game)

func check_die():
	var pos = get_pos()
	var cam_pos = global.camera_pos
	var dist = cam_pos.x - pos.x
	if pos.y > 600 or dist > 1000:
		die()

func _fixed_process(delta):
	if global.gameover or die:
		return
	check_die()
	var force = Vector2(WALK_SPEED, GRAVITY)
	var jump = Input.is_action_pressed("player_jump")
	var camera_pos = global.camera_pos
	var pos = get_pos()
	var dist = camera_pos.x - pos.x - 100
	var dist_ratio = dist / 600.0
	var motion
	var max_speed = lerp(WALK_SPEED_MIN, WALK_SPEED_MAX, clamp(dist_ratio, 0.0, 1.0))
	velocity += force * delta     # Integrate forces to velocity
	motion = velocity * delta     # Integrate velocity into motion and move
	
	if motion.x > max_speed:
		motion.x = max_speed
	
	motion = move(motion)         # Move and consume motion
	#if can_continue_jump and not jump:
#		can_continue_jump = false
	var floor_velocity = Vector2()
	
	if (is_colliding()):
		var collider = get_collider()
		if collider extends preload("res://items/coin.gd"): # a coin!
			collider.take_it()

		var n = get_collision_normal()
		if (rad2deg(acos(n.dot(Vector2(0, -1)))) < FLOOR_ANGLE_TOLERANCE):
			# If angle to the "up" vectors is < angle tolerance
			# char is on floor
			on_air_time = 0
			floor_velocity = get_collider_velocity()
		
		if (on_air_time == 0 and force.x == 0 and get_travel().length() < SLIDE_STOP_MIN_TRAVEL and abs(velocity.x) < SLIDE_STOP_VELOCITY and get_collider_velocity() == Vector2()):
			revert_motion()
			velocity.y = 0.0
		else:
			# For every other c-ase of motion, our motion was interrupted.
			# Try to complete the motion by "sliding" by the normal
			motion = n.slide(motion)
			velocity = n.slide(velocity)
			# Then move again
			move(motion)
	
	if (floor_velocity != Vector2()):
		# If floor moves, move with floor
		move(floor_velocity*delta)
	
	if (jumping and velocity.y > 0):
		# If falling, no longer jumping
		jumping = false

	if jump && jumping and can_continue_jump:
		velocity.y -= (JUMP_SPEED_CONTINUE + velocity.y) * delta
	
	if (on_air_time < JUMP_MAX_AIRBORNE_TIME and jump and not prev_jump_pressed and not jumping):
		# Jump must also be allowed to happen if the character left the floor a little bit ago.
		# Makes controls more snappy.
		velocity.y = -JUMP_SPEED * delta
		jumping = true
		can_continue_jump = true
	
	velocity.y = clamp(velocity.y, -500, 500) # Horrible things but it fix some bugs
	on_air_time += delta
	prev_jump_pressed = jump


func _ready():
	global.gameover = false
	set_fixed_process(true)
