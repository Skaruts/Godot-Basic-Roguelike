extends "res://scripts/WorldGen/BSP_Factory/BSP_DungeonFactory.gd"

var show_all_tiles = false	# show all the tiles for testing purposes
var use_bresenham = true 	# use Bresenham or RedBlobGames line algorithm

var pre_corpse = preload("res://scenes/entities/Corpse.tscn")

var tilemap = []	# array of Tile objects
var collmap = []	# collision map - array of ints
var fovmap 	= []	# field of view map - array of bytes
var leaves 	= []	# BSP Leaves
var rooms 	= []	# Rooms
var halls 	= []	# Hallways
var mobs 	= []	# Mobs
var corpses	= []
var debug_stuff = []	# stoof

var w
var h
var player_starting_pos

func _init(w, h):
	self.w = w
	self.h = h

func build_map():
	if tilemap.size(): clear_map()
	w = int(w)
	for j in range( h ):
		var inner = []
		for i in range( w ):
			var tile = load("res://scripts/Tile.gd").new()
			# var tile = pre_tile.instance()

			if collmap[j][i] in [RFLOOR_ID, HFLOOR_ID]:
				tile.init( i, j, charcodes.FLOOR)
				tile.set_foreground( colors.STONE_FLOOR )
			elif collmap[j][i] == WALL_ID:
				tile.init( i , j, charcodes.WALL)
				tile.set_foreground( colors.STONE_WALL )
			else: 										# door
				pass

			inner.append(tile)
			add_child( tile )
			tile.set_owner( self )
		tilemap.append( inner )

	create_fovmap()

func create_fovmap():
	fovmap 	= []
	for j in range( h ):
		var inner = RawArray()
		for i in range( w ):
			inner.append(0)
		fovmap.append( inner )

# calculate visibility map based on player location
func calc_fovmap(pos, vis_range):
	var LEFT	= clamp(pos.x-vis_range, 0, w)
	var RIGHT	= clamp(pos.x+vis_range, 0, w)
	var TOP		= clamp(pos.y-vis_range, 0, h)
	var BOTTOM	= clamp (pos.y+vis_range, 0, h )

	create_fovmap()

	for j in range( TOP, BOTTOM ):
		var inner = RawArray()
		for i in range( LEFT, RIGHT ):
			var points = utils.line(pos, Vector2(i, j), use_bresenham)
			var vis = 1
			for p in points:
				if not (collmap[p.y][p.x] in [RFLOOR_ID, HFLOOR_ID]):
					vis = 0
			fovmap[j][i] = vis

	# make walls visible
	for j in range( TOP, BOTTOM ):
		for i in range( LEFT, RIGHT ):
			# if it's a wall, that isn't visible, and is next to a visible/revealed floor
			if collmap[j][i] == WALL_ID		\
			and not fovmap[j][i]				\
			and has_neighboring_floor(i, j):
				fovmap[j][i] = 1                # then show it too

	# make the tiles visible

	for j in range( h ):
		for i in range( w ):
			if not show_all_tiles:
				tilemap[j][i].set_visible(fovmap[j][i])
			else:
				tilemap[j][i].set_visible(1)

func has_neighboring_floor(x, y):
	if is_visible_floor(x-1, y-1)	\
    or is_visible_floor(x  , y-1)	\
    or is_visible_floor(x+1, y-1)	\
    or is_visible_floor(x+1, y  )	\
    or is_visible_floor(x-1, y  )	\
    or is_visible_floor(x-1, y+1)	\
    or is_visible_floor(x  , y+1)	\
    or is_visible_floor(x+1, y+1):
		return true
	return false

func is_visible_floor(x, y):
    if (x > 0) and (x < MW) and (y > 0) and (y < MH):
        if collmap[y][x] in [RFLOOR_ID, HFLOOR_ID]	\
        and fovmap[y][x]:
            return true
    return false


func take_turn(player):
	calc_fovmap(player.pos, player.sight_range)
	for m in mobs:
		m.take_turn(player)
		m.set_visible( fovmap[m.pos.y][m.pos.x] )

	for c in corpses:
		c.take_turn()
		c.set_visible( fovmap[c.pos.y][c.pos.x] )

func can_walk(x, y):
	# implement solid property on tiles
	#return tilemap[y][x].is_solid
	return collmap[y][x] in [RFLOOR_ID, HFLOOR_ID]

func check_for_mob(x, y):
	for m in mobs:
		if m.pos.x == x and m.pos.y == y and m.is_obstacle:
			return m
	return null

func kill_entity(ent, type):
	if type == 'mob':
		for i in range(mobs.size()):
			if mobs[i] == ent:
				mobs.remove(i)
				break
	elif type == 'corpse':
		for i in range(corpses.size()):
			if corpses[i] == ent:
				corpses.remove(i)
				break
	ent.queue_free()

func add_corpse(cname, pos):
	var corpse = pre_corpse.instance()
	corpse.name = cname
	corpse.set_position( pos )
	corpse.set_dungeon(self)
	corpses.append(corpse)

	add_child(corpse)
	corpse.set_owner(self)

func clear_map():
	for i in tilemap:
		for t in i:
			t.get_parent().remove_child(t)
			t.free()
	tilemap = []

func switch_texture():
	var TS = textures.get_tile_size()

	for j in range( tilemap.size() ):
		for i in range( tilemap[0].size() ):
			tilemap[j][i].switch_texture()
			#tilemap[j][i].set_global_pos( Vector2(i, j) )

	for m in mobs:		m.switch_texture()
	for c in corpses:	c.switch_texture()



#func finalize():
#	for l in leaves():
#		add_child(l)