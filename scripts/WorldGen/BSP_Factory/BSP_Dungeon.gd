extends "res://scripts/WorldGen/BSP_Factory/BSP_DungeonFactory.gd"

var show_all_tiles = false  # show all the tiles for testing purposes
var use_bresenham = false   # use Bresenham or RedBlobGames line algorithm

var pre_corpse = preload("res://scenes/entities/Corpse.tscn")
var pre_tile = preload("res://scenes/Tile.tscn")

var tilemap = []    # array of Tile objects
var fovmap  = Array()       # field of view map - array of bytes (RawArray)
var clear_fovmap = Array()  # same as fovmap, but stays clear (so I don't need to keep recreating the fovmap)
var leaves  = []    # BSP Leaves
var rooms   = []    # Rooms
var halls   = []    # Hallways
var mobs    = []    # Mobs
var corpses = []
var debug_stuff = []    # stoof

var w
var h
var player_starting_pos

func _init(w, h):
	self.w = w
	self.h = h

func build_map( map ):
	if tilemap.size(): clear_map()
	w = int(w)
	for j in range(h):
		for i in range(w):
			var tile
			if map[i+j*w] in [RFLOOR_ID, HFLOOR_ID]:
				tile = pre_tile.instance()
				tile.init( Vector2(i, j), utils.ascii(charcodes.FLOOR) )
				tile.set_fg( colors.STONE_FLOOR )
			elif map[i+j*w] == WALL_ID:
				tile = pre_tile.instance()
				tile.init( Vector2(i, j), utils.ascii(charcodes.WALL) )
				tile.set_fg( colors.STONE_WALL )
				tile.is_solid = true

			# TODO: make doors

			tilemap.append( tile )
			add_child( tile )
			tile.set_owner( self )

	create_fovmap()     # REDUNDANT

func create_fovmap():
	for i in range( w*h ):
		clear_fovmap.append( 0 )

	fovmap = Array(clear_fovmap)

# calculate visibility map based on player location
func calc_fovmap(pos, vis_range):
	var LEFT    = clamp( pos.x-vis_range, 0, w )
	var RIGHT   = clamp( pos.x+vis_range, 0, w )
	var TOP     = clamp( pos.y-vis_range, 0, h )
	var BOTTOM  = clamp( pos.y+vis_range, 0, h )

	fovmap = Array(clear_fovmap)

	for j in range( TOP, BOTTOM ):
		for i in range( LEFT, RIGHT ):
			var points = utils.line(pos, Vector2(i, j), use_bresenham)
			fovmap[i+j*w] = 1
			for p in points:
				# print ("[", p.x, ", ", p.y, "], ")
				# print ("[", p.x + p.y * w, "], ")
				if tilemap[ p.x+p.y*w ].is_solid:
					fovmap[i+j*w] = 0
					break


	# make walls visible
	for j in range( TOP, BOTTOM ):
		for i in range( LEFT, RIGHT ):
			# if it's a wall, that isn't visible, and is next to a visible/revealed floor
			if tilemap[ i+j*w ].is_solid            \
			and not fovmap[i+j*w]               \
			and has_neighboring_floor(i, j):
				fovmap[i+j*w] = 1                # then show it too

			tilemap[ i+j*w ].set_visible(fovmap[i+j*w])

	# make the tiles visible
	for j in range( h ):
		for i in range( w ):
			if not show_all_tiles:
				tilemap[ i+j*w ].set_visible(fovmap[i+j*w])
			else:
				tilemap[ i+j*w ].set_visible(1)

func has_neighboring_floor(x, y):
	if is_visible_floor(x-1, y-1)   \
	or is_visible_floor(x  , y-1)   \
	or is_visible_floor(x+1, y-1)   \
	or is_visible_floor(x+1, y  )   \
	or is_visible_floor(x-1, y  )   \
	or is_visible_floor(x-1, y+1)   \
	or is_visible_floor(x  , y+1)   \
	or is_visible_floor(x+1, y+1):
		return true
	return false

func is_visible_floor(x, y):
	if (x > 0) and (x < MW) and (y > 0) and (y < MH):
		if not tilemap[ x+y*w ].is_solid    \
		and fovmap[x+y*w]:
			return true
	return false

func calc_mobs_vis():
	for e in get_tree().get_nodes_in_group("MAP_ENTITIES"):
		e.set_visible( fovmap[e.pos.x+e.pos.y*w] )

func take_turn(player):
	calc_fovmap(player.pos, player.sight_range)
	for e in get_tree().get_nodes_in_group("MAP_ENTITIES"):
		if e.is_in_group("MOBS"):
			e.take_turn(player)
		elif e.is_in_group("CORPSES"):
			e.take_turn()
		e.set_visible( fovmap[e.pos.x + e.pos.y*w] )

func can_walk(x, y):
	return not tilemap[ x+y*w ].is_solid

func check_for_mob(x, y):
	for m in mobs:
		if m.pos.x == x and m.pos.y == y    \
		and m.is_obstacle:
			return m
	return null

func kill_entity(ent, type):
	if   type == 'mob':     mobs.erase(ent)
	elif type == 'corpse':  corpses.erase(ent)
	ent.queue_free()

func add_corpse(cname, pos):
	var corpse = pre_corpse.instance()
	add_child(corpse)
	corpse.set_owner(self)

	corpse.init(pos, utils.ascii(charcodes.CORPSE))
	corpse.name = cname
	corpse.set_dungeon(self)
	corpses.append(corpse)


func clear_map():
	for t in tilemap:
		t.get_parent().remove_child(t)
		t.queue_free()
	tilemap = []
