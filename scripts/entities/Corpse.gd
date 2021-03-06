extends "res://scripts/entities/Entity.gd"

#######################################################################
# I have no clue how to properly work with colors programatically,
# this is the best I could come up with to make the bones decay.
# It's confusing and by now not even I know how it works...
#######################################################################

var base_desc = "Remains of "

var turns = 100 # find way to set this based on how big the mob was
var decay_turns = turns/10
var alpha_decay_turns = turns - decay_turns

func _ready():
	set_z(1)
	add_to_group("CORPSES")
	add_to_group("MAP_ENTITIES")
	is_obstacle = false

	set_fg( colors.CORPSE )

func get_description():
	return base_desc + name

func die():
	dungeon.kill_entity(self, 'corpse')

func take_turn():
	if turns > 0:   decay()
	else:           die()

func decay():
	var r = fg.r*255    # convert to 0-255 range
	var g = fg.g*255
	var b = fg.b*255
	var a = fg.a*255

	r = r + ( (144-r) / decay_turns )
	g = g + ( (136-g) / decay_turns )
	b = b + ( (128-b) / decay_turns )
	if decay_turns <= 1:
		a = a - int( 255/alpha_decay_turns )
		if a < 0:
			a = 0
	else:
		a = 255

	turns -= 1
	if decay_turns > 1: decay_turns -= 1
	set_fg( Color(r/255, g/255, b/255, a/255) ) # re-convert to 0-1 float range


# func resurect():
	# if someone near can necromance