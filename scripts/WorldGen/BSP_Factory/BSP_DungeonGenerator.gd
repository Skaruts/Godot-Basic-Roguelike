extends "res://scripts/WorldGen/BSP_Factory/BSP_DungeonFactory.gd"

#var premob = preload("res://scenes/entities/Mob.tscn")

var pre_mobfactory = preload("res://scripts/WorldGen/MobFactory.gd")
var pre_bsp_dungeon = preload("res://scripts/WorldGen/BSP_Factory/BSP_Dungeon.gd")
var pre_leaf = preload("res://scripts/WorldGen/BSP_Factory/BSP_Leaf.gd")

var map 	= []
var leaves 	= []
var rooms 	= []
var halls 	= []
var mobs 	= []
var debug_stuff = []

var player_starting_pos = Vector2()
var dungeon


func generate(custom_seed = null):
	# create a new dungeon object
	dungeon = pre_bsp_dungeon.new( MW, MH )
	set_seed(custom_seed)

	# create stuff
	create_map()
	create_leaves()
	create_halls()

	# build stuff
	carve_rooms()
	carve_hallways()

	# finish stuff
	var start_room = rooms[ utils.irand( 0, rooms.size() ) ]
	player_starting_pos = Vector2( start_room.cx, start_room.cy )

	build_dungeon()
	populate_dungeon()

	return dungeon

func create_map():					# 1
	for j in range( MW*MH ):
		map.append( WALL_ID )

func create_leaves():
	var root_leaf = pre_leaf.new( 0, 0, MW, MH )
	dungeon.add_child( root_leaf )
	leaves.append( root_leaf )

	var can_split = true
	while can_split:
		can_split = false
		for l in leaves:
			if not l.is_split:
				if l.split():
					leaves.append( l.child1 )
					leaves.append( l.child2 )
					dungeon.add_child( l.child1 )
					dungeon.add_child( l.child2 )
					can_split = true

	root_leaf.create_room( rooms )

	for r in rooms:
		dungeon.add_child( r )
		r.set_owner( dungeon )

func create_halls():
	for leaf in leaves:
		leaf.create_hall( halls )

	for hall in halls:
		dungeon.add_child( hall )
		hall.set_owner( dungeon )

func carve_rooms():
	for r in rooms:
		for j in range( r.y, r.y2 ):
			for i in range( r.x, r.x2 ):
				map[i+j*MW] = RFLOOR_ID

func carve_hallways():
	for hall in halls:
		var p1 = hall.p1; var p2 = hall.p2;  var p3 = hall.p3

		if rand_range(0, 1) < 0.5:
			h_tunnel( p1.x, p3.x, p2.y )
			v_tunnel( p1.y, p3.y, p2.x )
		else:
			h_tunnel( p3.x, p1.x, p2.y )
			v_tunnel( p3.y, p1.y, p2.x )

func h_tunnel(x1, x2, y):
	for x in range( min(x1, x2), max(x1, x2) + 1 ):
		map[x+y*MW] = HFLOOR_ID

func v_tunnel(y1, y2, x):
	for y in range( min(y1, y2), max(y1, y2) + 1 ):
		map[x+y*MW] = HFLOOR_ID

func build_dungeon():
	# dungeon.map 				= map
	dungeon.leaves 				= leaves
	dungeon.rooms 				= rooms
	dungeon.halls 				= halls
	dungeon.player_starting_pos = player_starting_pos
	dungeon.debug_stuff 		= debug_stuff

	dungeon.build_map( map )

func populate_dungeon():
	for r in rooms:
		place_mobs(r)

func place_mobs(room):
	var numMonsters = utils.irand( 1, MAX_ROOM_MONSTERS )
	for i in range(numMonsters):
		var x = utils.irand( room.x+1, room.x2-1 )
		var y = utils.irand( room.y+1, room.y2-1 )

		# if position is blocked (by pillars or other), try a new one (recursion)
		if check_for_obstacle(x, y):
			place_mobs(room)
			return

		var monster = create_mob(x, y)

		mobs.append(monster)
	dungeon.mobs = mobs

func create_mob(x, y):
	var mob
	var mob_fac = pre_mobfactory.new()

	if rand_range(0, 1) < 0.3:
		mob = mob_fac.create_mob( Vector2(x, y), 'troll', dungeon )
	else:
	 	mob = mob_fac.create_mob( Vector2(x, y), 'orc', dungeon )

	dungeon.add_child(mob)
	mob.set_owner(dungeon)

	return mob

# func create_mob(x, y):
# 	# var mob = load("res://scenes/Mob.tscn").instance()
# 	var mob = premob.instance()
# 	if rand_range(0, 1) < 0.3:
# 	 	mob.set_script( load("res://scripts/troll.gd") )
# 	else:
# 	 	mob.set_script( load("res://scripts/orc.gd") )
#
# 	mob.set_dungeon(dungeon)
# 	mob.set_position( Vector2(x, y) )
# 	dungeon.add_child(mob)
# 	mob.set_owner(dungeon)
#
# 	return mob

func check_for_obstacle(x, y):
	if x == player_starting_pos.x and y == player_starting_pos.y:
		return true

	for m in mobs:
		if x == m.pos.x and y == m.pos.y:
			return true

	# TODO - CHECK FOR OTHER ENTITIES

	return false