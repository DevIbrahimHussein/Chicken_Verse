extends Node2D

var jump_count = 0
var has_double_jumped = false
var on_ground = false 
var motion = Vector2()
var last_ground_time = 0

const UP = Vector2(0,-1)
const GRAVITY = 20
const SPEED = 300
const JUMP_HEIGHT = -550
const FRAMES_TO_FULL_SPEED = 4
const FRAMES_TO_STOP = 6

var move_controller
var parent
var current_speed = 0

var current_frame = 0

func _ready():
	parent = get_parent()
	
func set_move_controller(move_ctrl):
	current_frame = 0
	move_controller = move_ctrl

func _process(delta):
	if (move_controller != null):
		move_controller.update(current_frame)
		move()
	current_frame += 1

func move():
	motion.y += GRAVITY
	if (move_controller.right_pressed()):
		if (current_speed <= 0):
			current_speed = 0
		current_speed += SPEED / FRAMES_TO_FULL_SPEED
		current_speed = clamp(current_speed, 0, SPEED)
	elif (move_controller.left_pressed()):
		if (current_speed >= 0):
			current_speed = 0
		current_speed -= SPEED / FRAMES_TO_FULL_SPEED
		current_speed = clamp(current_speed, -SPEED, 0)
	else:
		if (abs(current_speed) <= SPEED / FRAMES_TO_STOP ):
			current_speed = 0
		else:
			current_speed += SPEED / FRAMES_TO_STOP * (-current_speed / abs(current_speed))
	
	on_ground = parent.is_on_floor()
	if on_ground:
		jump_count = 0
		motion.y = GRAVITY
		last_ground_time = OS.get_ticks_msec()
		
	if move_controller.up_just_pressed() && not on_ground && jump_count == 1:
		motion.y = JUMP_HEIGHT
		jump_count += 1
		
		
	if move_controller.up_pressed():
		if OS.get_ticks_msec() - last_ground_time < 200 && jump_count == 0:
			motion.y = JUMP_HEIGHT
			on_ground = false
			jump_count += 1
	else:
		if (motion.y < -30 && motion.y > -500):
			motion.y += 90
			
	

	parent.move_and_slide(Vector2(current_speed, motion.y), UP)
