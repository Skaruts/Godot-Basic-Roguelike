extends Node2D

#################################################################
# Other factory classes inherit from this one, so that they
# can access these variables directly, instead of having
# to use fully qualified names such as "Factory.SEED".
#################################################################

var SEED
var TS 		= textures.get_tile_size()

# tile types
# -------------------------
# May be redundant to separate room and hallway floors, but just in case it isn't...
var RFLOOR_ID	= 1		# room floor
var HFLOOR_ID	= 2		# hallway floor
var WALL_ID		= 3

func set_seed(custom_seed = null):
	if custom_seed != null:
		# if a custom seed that is not null was provided, use it
		SEED = custom_seed
	else:
		# if not, generate a new one randomly
		randomize()
		SEED = utils.irand(-200000000, 200000000)

	# then use the new seed
	seed(SEED)
	print("Factory.set_seed: | seed: ", SEED)

