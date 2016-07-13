extends KinematicBody2D

const FLOOR_ANGLE_TOLERANCE = 50
var WALK_SPEED = global.WALK_SPEED
var WALK_SPEED_MAX = global.WALK_SPEED_MAX
var WALK_SPEED_MIN = global.WALK_SPEED_MIN

const GRAVITY = 2000
const JUMP_SPEED = 30000
const JUMP_SPEED_CONTINUE = 1500
const JUMP_MAX_AIRBORNE_TIME = 0.3
const DIST_TO_CENTER = 666
const SLIDE_STOP_VELOCITY = 1.0
const SLIDE_STOP_MIN_TRAVEL = 1.0
const SPEED_BONUS_FOR_STAIRS = 2.0

var audioPlayer = null
var velocity = Vector2()
var on_air_time = 100
var jumping = false
var can_continue_jump = false

var prev_jump_pressed = false
var death = false
var animator = null

var fleshs = null # set in ready
var sprite = null # set in ready

var dust = preload("res://particles/running_dust.tscn")


func spread_fleshs():
	var child_count = fleshs.get_child_count()
	var i = 0
	sprite.hide()
	while i < child_count:
		var child = fleshs.get_child(i)
		child.show()
		var strength = Vector2(rand_range(-500, 100), rand_range(-1000, 100) - 200)
		child.apply_impulse(get_pos(), strength)
		child.set_gravity_scale(25)
		i += 1


func hide_fleshs():
	var child_count = fleshs.get_child_count()
	var i = 0
	while i < child_count:
		var child = fleshs.get_child(i)
		child.hide()
		i += 1


func die():
	emit_signal("spread_fleshs")
	death = true
	global.run_death()
	audioPlayer.play("scream_dead")


func die_because_trap():
	die()
	set_fixed_process(false)
	spread_fleshs()
	

func check_die():
	var pos = get_pos()
	var cam_pos = global.main_camera.get_pos()
	var dist = pos.x - cam_pos.x
	if pos.y > global.y_max_to_die or dist < global.x_max_to_die:
		die()


func _fixed_process(delta):
	if not global.gameover and not death:
		check_die()

	var force = Vector2(WALK_SPEED, GRAVITY)
	var jump = Input.is_action_pressed("player_jump")
	var camera_pos = global.main_camera.get_pos()
	var pos = get_pos()
	var dist = camera_pos.x - pos.x - DIST_TO_CENTER
	var dist_ratio = dist / 600.0

	var max_speed = lerp(WALK_SPEED_MIN, WALK_SPEED_MAX, clamp(dist_ratio, 0.0, 1.0)) * delta
	if death:
		if pos.x - camera_pos.x <= global.x_max_to_die:
			max_speed = -1
		else:
			max_speed = WALK_SPEED_MIN * delta
	
	velocity += force * delta     # Integrate forces to velocity
	var motion = velocity * delta     # Integrate velocity into motion and move
	
	if motion.x > max_speed:
		motion.x = max_speed
	
	motion = move(motion)         # Move and consume motion
	#if can_continue_jump and not jump:
#		can_continue_jump = false
	var floor_velocity = Vector2()
	
	if (is_colliding()):
		var collider = get_collider()

		var n = get_collision_normal()
		var rad = acos(n.dot(Vector2(0, -1)))
		if (rad2deg(rad) < FLOOR_ANGLE_TOLERANCE):
			# If angle to the "up" vectors is < angle tolerance
			# char is on floor
			set_rot(rad / 2 * -sign(n.x))
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
			if n.x != 0 && n.x != -1: # ni le sol ni un mur
				var k = (WALK_SPEED_MIN * delta) / motion.x # or max_speed / motion.x ?
				motion *= k
			# Then move again
			move(motion)
	
	if (floor_velocity != Vector2()):
		# If floor moves, move with floor
		move(floor_velocity * delta)
	
	if (jumping and velocity.y > 0):
		# If falling, no longer jumping
		jumping = false
		animator.play("run")
		set_rot(0)

	if jump && jumping and can_continue_jump:
		velocity.y -= (JUMP_SPEED_CONTINUE + velocity.y) * delta
	
	if (on_air_time < JUMP_MAX_AIRBORNE_TIME and jump and not prev_jump_pressed and not jumping):
		# Jump must also be allowed to happen if the character left the floor a little bit ago.
		# Makes controls more snappy.
		velocity.y = -JUMP_SPEED * delta
		jumping = true
		animator.play("jump")
		set_rot(0)
		can_continue_jump = true
	
	velocity.y = clamp(velocity.y, -500, 500) # Horrible things but it fix some bugs
	on_air_time += delta
	prev_jump_pressed = jump


func emit_dust():
	if not jumping:
		var r = dust.instance()
		r.set_pos(get_pos() + Vector2(-5, 25))
		get_parent().add_child(r)
		r.set_emitting(true)


func _ready():
	global.player = self
	set_pos(global.PLAYER_START_POS)
	global.gameover = false
	animator = get_node("Sprite/anim")
	animator.play("run")
	audioPlayer = get_node("audioPlayer")
	fleshs = get_node("Fleshs")
	sprite = get_node("Sprite")
	hide_fleshs()
	set_fixed_process(true)
