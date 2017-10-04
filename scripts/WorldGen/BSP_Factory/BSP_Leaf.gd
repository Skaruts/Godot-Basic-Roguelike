extends "res://scripts/WorldGen/BSP_Factory/BSP_DungeonFactory.gd"

# var pre_leaf = preload("res://scripts/WorldGen/BSP Factory/Leaf.gd")	# Parser Error: Can't preload itself (use 'get_script()').
var pre_room = preload("res://scripts/WorldGen/BSP_Factory/BSP_Room.gd")
var pre_hall = preload("res://scripts/WorldGen/BSP_Factory/BSP_Hallway.gd")

var x; var y; var w; var h
var x2; var y2

var is_split = false
# var color = ?
var child1 = null		# ( type<Leaf> ) 		the Leaf's left child Leaf
var child2 = null		# ( type<Leaf> ) 		the Leaf's right child Leaf
var room = null
var hall = null

func _init(x, y, w, h):
	self.x		= x
	self.y		= y
	self.w		= w
	self.h		= h
	x2 	= x + w
	y2 	= y + h
	#if DEBUG:

func split():
	if child1 != null and child2 != null:
		# redundant? is_split is tested in the generator
		return false

	var direction
	var max_size

	if w > h:	direction = 'H'
	if h > w:	direction = 'V'
	else:
		var r = rand_range(0, 1)
		if r > 0.5: 	direction = 'V'
		else:			direction = 'H'

	if direction == 'V':	max_size = h - MIN_LEAF_SIZE
	else:					max_size = w - MIN_LEAF_SIZE

	if max_size <= MIN_LEAF_SIZE:
		return false

	#var split = randi() % int(max_size - MIN_LEAF_SIZE) + MIN_LEAF_SIZE
	var split = utils.irand(MIN_LEAF_SIZE, max_size)

	if direction == 'V':
		child1 = get_script().new( x, y, w, split )
		child2 = get_script().new( x, y+split, w, h-split )
	else:
		child1 = get_script().new( x, y, split, h )
		child2 = get_script().new( x+split, y, w-split, h )

	is_split = true
	set_process(false)
	return true # split successful!

func create_room(rooms):
	if is_split:
		child1.create_room(rooms)
		child2.create_room(rooms)
	# 75% chance of creating a room, so not all leaves will have one
	elif rand_range(0, 1) < 0.75:
		var rw = int( rand_range( MIN_ROOM_SIZE, min(w-2, MAX_ROOM_SIZE) ) )
		var rh = int( rand_range( MIN_ROOM_SIZE, min(h-2, MAX_ROOM_SIZE) ) )
		var rx = int( rand_range( 1, w-rw ) )
		var ry = int( rand_range( 1, h-rh ) )

		var id = next_room_id()
		room = pre_room.new( id, x+rx, y+ry, rw, rh )
		rooms.append(room)

func create_hall(halls):
	# if this leaf has been split, and both children are there (as they should)
	if is_split		\
	and child1 != null and child2 != null:
		var r1 = child1.get_room()
		var r2 = child2.get_room()

		# if it has two rooms that we can connect to each other
		if r1 != null and r2 != null:
			# store the start and end points
			var p1 = Vector2( utils.irand( r1.x+1, r1.x2-1 ), utils.irand( r1.y+1, r1.y2-1 ) )
			var p2
			var p3 = Vector2( utils.irand( r2.x+1, r2.x2-1 ), utils.irand( r2.y+1, r2.y2-1 ) )

			# find the mid point (can only go in one of two directions)
			#  p1  ->  m?	(p3.x, p1.y)
			#  |       |
			#  v       v
			#  m?  ->  p3	(p1.x, p3.y)
			if rand_range(0, 1) < 0.5:	p2 = Vector2( p3.x, p1.y )
			else: 						p2 = Vector2( p1.x, p3.y )

			hall = pre_hall.new( p1 , p2 , p3 )
			halls.append(hall)

func get_room():
	# iterate all the way through these leafs to find a room, if one exists.
	if room != null:
		return room
	else:
		var room1
		var room2

		if child1 != null:		room1 = child1.get_room()
		if child2 != null:		room2 = child2.get_room()

		if room1 == null and room2 == null: return null
		elif room2 == null:				return room1
		elif room1 == null:				return room2
		elif rand_range(0, 1) < 0.5:	return room1
		else:							return room2




# debug stuff
# -----------------------
var debug = false
var debug_color = Color(0, 0.7, 1, 0.3)

func _ready():
	if settings.DEBUG:
		set_debug( settings.DEBUG_LEAF )

func _process(delta):
	update()	# to _draw() the bounding boxes
	set_process(false)

func _draw():
	if debug:
		draw_line( Vector2(x *TS,  y*TS), 	Vector2(x2*TS,  y*TS), debug_color, 1 )
		draw_line( Vector2(x2*TS,  y*TS), 	Vector2(x2*TS, y2*TS), debug_color, 1 )
		draw_line( Vector2(x2*TS, y2*TS), 	Vector2( x*TS, y2*TS), debug_color, 1 )
		draw_line( Vector2(x *TS, y2*TS), 	Vector2( x*TS,  y*TS), debug_color, 1 )

func set_debug(d):
	debug = d
	set_process(true)

func toggle_debug():
	set_debug(not debug)
