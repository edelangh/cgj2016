
extends KinematicBody2D

const GRAVITY = 600

const FLOOR_ANGLE_TOLERANCE = 40
var WALK_SPEED = global.WALK_SPEED
var WALK_SPEED_MAX = global.WALK_SPEED_MAX
var WALK_SPEED_MIN = global.WALK_SPEED_MIN

const JUMP_SPEED = 400
const JUMP_MAX_AIRBORNE_TIME = 0.2

const SLIDE_STOP_VELOCITY = 1.0
const SLIDE_STOP_MIN_TRAVEL = 1.0

var velocity = Vector2()
var on_air_time = 100
var jumping = false

var prev_jump_pressed = false

func _fixed_process(delta):
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
	print("My speed %f  %f %f" % [motion.x, max_speed, dist_ratio])
	motion = move(motion)         # Move and consume motion
	
	var floor_velocity = Vector2()
	
	if (is_colliding()):
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
			# For every other case of motion, our motion was interrupted.
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
	
	if (on_air_time < JUMP_MAX_AIRBORNE_TIME and jump and not prev_jump_pressed and not jumping):
		# Jump must also be allowed to happen if the character left the floor a little bit ago.
		# Makes controls more snappy.
		velocity.y = -JUMP_SPEED
		jumping = true
	
	on_air_time += delta
	prev_jump_pressed = jump


func _ready():
	set_fixed_process(true)
