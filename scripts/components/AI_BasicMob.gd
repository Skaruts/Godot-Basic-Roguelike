#######################################################################
# Basic Mob AI component
# Allows a mob to move and attack the player
#######################################################################
extends Node

# var parent
#func _ready():
#   parent = get_parent()

func take_turn(player):
	var parent = get_parent()
	if player.alive and distance_to(player) <= parent.sight_range:
		if distance_to(player) >= 2:
			move_to(player)
		elif player.combat.hp > 0:
			parent.combat.attack(player)
	# else:
		# move randomly

func move_to(t):
	var parent = get_parent()
	# vector from this entity to the target
	var dx = t.pos.x - parent.pos.x
	var dy = t.pos.y - parent.pos.y
	var distance = sqrt(dx*dx + dy*dy)

	# normalize, preserving direction, round it and convert to int
	# so that movement is restricted to the grid
	dx = int( round(dx/distance) )
	dy = int( round(dy/distance) )

	var other_mob = parent.dungeon.check_for_mob(parent.pos.x+dx, parent.pos.y+dy)
	if other_mob == null:
		move(dx, dy, t)

func move(dx, dy, t):
	var parent = get_parent()
	if parent.dungeon.can_walk( parent.pos.x+dx, parent.pos.y+dy ):
		parent.set_position( Vector2(parent.pos.x+dx, parent.pos.y+dy) )

func distance_to(other):
	var parent = get_parent()
	#return the distance to another object
	var dx = other.pos.x - parent.pos.x
	var dy = other.pos.y - parent.pos.y
	return sqrt(dx*dx + dy*dy)
