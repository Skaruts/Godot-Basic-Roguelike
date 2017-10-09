#######################################################################
# Player controls component
# Allows the player to control a mob
#######################################################################
extends Node

var key_repeat          = settings.KEY_REPEAT
var key_cooldown        = settings.KEY_COOLDOWN
var key_1st_cooldown    = settings.KEY_1ST_COOLDOWN
var key_timer           = 0
var max_key_timer       = key_1st_cooldown

var k_left  = false     # key flags
var k_right = false
var k_up    = false
var k_down  = false

var moving_left     = false # movement flags for no key-repeat
var moving_right    = false
var moving_up       = false
var moving_down     = false
var moving          = false

var k_shake = false
var shaking         = false

# var parent
# func _ready():
#   parent = get_parent()

func handle_keys(delta):
	var parent = get_parent()
	var took_turn = false
	k_left  = Input.is_action_pressed("k_left")
	k_right = Input.is_action_pressed("k_right")
	k_up    = Input.is_action_pressed("k_up")
	k_down  = Input.is_action_pressed("k_down")
	k_shake = Input.is_action_pressed("k_shake")

	if key_repeat:  took_turn = move_repeat(delta)
	else:           took_turn = move_once()

	# Camera shake test. To be implemented somewhere else, like monster steps
	# or big damage hits or something

	if k_shake:
		parent.get_node("Camera").shake(0.4, 16)

	if took_turn: parent.take_turn()
	return took_turn

func move_once():
	var has_moved = false
	var parent = get_parent()

	if k_left and not moving_left and not k_right:
		has_moved = move( -1, 0 )
		moving_left = true
	elif not k_left and moving_left:
		moving_left = false

	if k_right and not moving_right and not k_left:
		has_moved = move( 1, 0 )
		moving_right = true
	elif not k_right and moving_right:
		moving_right = false

	if k_up and not moving_up and not k_down:
		has_moved = move( 0, -1 )
		moving_up = true
	elif not k_up and moving_up:
		moving_up = false

	if k_down and not moving_down and not k_up:
		has_moved = move( 0, 1 )
		moving_down = true
	elif not k_down and moving_down:
		moving_down = false

	if has_moved:
		parent.dungeon.calc_fovmap(parent.pos, parent.sight_range)

	return has_moved


func move_repeat(delta):
	var has_moved = false
	var parent = get_parent()

	# if already moving since last frame, make the cooldown shorter
	# else, make it longer for the first key press
	if moving:  max_key_timer = key_cooldown
	else:       max_key_timer = key_1st_cooldown

	# check if any movement key is being pressed
	moving = k_left or k_right or k_up or k_down

	# if none is pressed, reset the timer so the player is free to move
	if not moving: key_timer = 0

	# if no cooldown and a key was pressed
	if key_timer <= 0 and moving:
		if k_left and not k_right:
			if move(-1,  0):    has_moved = true
		if k_right and not k_left:
			if move( 1,  0):    has_moved = true
		if k_up and not k_down:
			if move( 0, -1):    has_moved = true
		if k_down and not k_up:
			if move( 0,  1):    has_moved = true

		if has_moved:
			parent.dungeon.calc_fovmap(parent.pos, parent.sight_range)
			key_timer = max_key_timer   # set the cooldown
	# else if still cooling down, just reduce timer by delta
	else:
		key_timer -= delta

	return has_moved

func move(dx, dy):
	var parent = get_parent()
	var mob = parent.dungeon.check_for_mob(parent.pos.x+dx, parent.pos.y+dy)
	if mob != null:
		parent.combat.attack(mob)
		return true
	else:
		if parent.dungeon.can_walk( parent.pos.x+dx, parent.pos.y+dy ):
			parent.set_position( Vector2(parent.pos.x+dx, parent.pos.y+dy) )
			return true
	return false