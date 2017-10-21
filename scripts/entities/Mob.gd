extends "res://scripts/entities/Entity.gd"

#debug stuff
var debug
var label

# components
var ai = null
var combat = null
var controls = null

# properties
var alive = true
var sight_range

func _ready():
	set_z(5)
	add_to_group("MOBS")
	label = get_node("Label")
	set_debug( settings.SHOW_MOB_HP )
	is_mob = true

	var TW = textures.get_tile_width()
	if debug:
		# label.set_text(str(hp))
		label.set_pos( Vector2(0, -TW/2) )

func take_turn(player):
	# print ("ai taking turns")
	ai.take_turn(player)

func die():
	is_obstacle = false
	alive = false
	set_glyph(0)
	dungeon.add_corpse(name, pos)
	dungeon.kill_entity(self, 'mob')

func set_label_text(text):
	label.set_text(text)

func set_debug(d):
	debug = d
	show_label(d)

func show_label(l):
	# invert the bool so that true makes it visible
	# instead of hiding it, and vice versa
	label.set_hidden(not l)

func toggle_debug():
	label.set_hidden( not label.is_hidden() )

