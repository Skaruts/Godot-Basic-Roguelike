# attached World.tscn
extends Node2D

var bspgen = preload("res://scripts/WorldGen/BSP_Factory/BSP_DungeonGenerator.gd")
# var pre_mobfactory = preload("res://scripts/WorldGen/MobFactory.gd")
var pre_player = preload("res://scenes/entities/Player.tscn")

var player = null
var dungeon
var took_turn = true

func _ready():
	create_map()
	set_fixed_process(true)

func _fixed_process(delta):
	took_turn = false
	if player.alive:
		if player.controls.handle_keys(delta):
			dungeon.take_turn(player)
			took_turn = true

func create_map():
	dungeon = bspgen.new().generate( settings.DEBUG_SEED )
	dungeon.set_name("dungeon")
	add_child(dungeon)
	dungeon.set_owner(self)

	create_player()

	dungeon.calc_fovmap(player.pos, player.sight_range)
	dungeon.calc_mobs_vis()

func create_player():
	if player != null: player.free()
	player = pre_player.instance()
	player.init(dungeon.player_starting_pos, utils.ascii(charcodes.PLAYER))
	player.set_dungeon(dungeon)
	add_child(player)
	player.set_owner(self)

func rebuild_map():
	var d = get_node("dungeon")
	remove_child(d)
	d.free()
	create_map()






# debug stuff
# ----------------------------------
func toggle_debug_hp():
	settings.SHOW_MOB_HP = not settings.SHOW_MOB_HP
	if settings.DEBUG:
		player.toggle_debug()
		for m in dungeon.mobs:      m.toggle_debug()

func toggle_debug_leaves():
	settings.DEBUG_LEAF = not settings.DEBUG_LEAF
	if settings.DEBUG:
		for l in dungeon.leaves:    l.toggle_debug()

func toggle_debug_rooms():
	settings.DEBUG_ROOM = not settings.DEBUG_ROOM
	if settings.DEBUG:
		for r in dungeon.rooms:     r.toggle_debug()

func toggle_debug_halls():
	settings.DEBUG_HALL = not settings.DEBUG_HALL
	if settings.DEBUG:
		for h in dungeon.halls:     h.toggle_debug()

func toggle_debug_room_info():
	settings.SHOW_ROOM_LABELS = not settings.SHOW_ROOM_LABELS
	if settings.DEBUG:
		for r in dungeon.rooms:     r.toggle_info()

func toggle_debug():
	settings.DEBUG = not settings.DEBUG

	if settings.DEBUG:
		player.set_debug(settings.SHOW_MOB_HP)
		for m in dungeon.mobs:      m.set_debug(settings.SHOW_MOB_HP)
		for l in dungeon.leaves:    l.set_debug(settings.DEBUG_LEAF)
		for r in dungeon.rooms:     r.set_debug(settings.DEBUG_ROOM)
		for h in dungeon.halls:     h.set_debug(settings.DEBUG_HALL)
		for r in dungeon.rooms:     r.show_info(settings.SHOW_ROOM_LABELS)
	else:
		player.set_debug(false)
		for m in dungeon.mobs:      m.set_debug(false)
		for l in dungeon.leaves:    l.set_debug(false)
		for r in dungeon.rooms:     r.set_debug(false)
		for h in dungeon.halls:     h.set_debug(false)
		for r in dungeon.rooms:     r.show_info(false)








# The code below is just leftover code from a previous project that
# I had for a space game. This World class was adapted from its
# Universe class. I kept it here for reference, in case I want to do some
# similar chunk generation code, and loading/unloading for big maps.

#func create_sector(x, y):
#   var sector = pre_sector.instance()
#   sector.init( x, y )
#   add_child(sector)
#   sector.set_owner(self)
#   return sector
#
#func create_starting_sectors():
#   for j in range(3):
#       var inner = []
#       for i in range(3):
#           inner.append( get_sector(i-1, j-1) )
#
#       sectors.append(inner)
#       map_size = Vector2(3, 3)
#
#func _process(delta):
#   var pp = get_player_gpos()
#   # print (pp)
#
#   if pp.x < sectors[1][1].get_gpos().x:   gen_sectors("left")     # generate more sectors to the WEST
#   elif pp.x > sectors[1][1].get_gpos().x: gen_sectors("right")    # generate more sectors to the EAST
#
#   if pp.y < sectors[1][1].get_gpos().y:   gen_sectors("up")       # generate more sectors to the SOUTH
#   elif pp.y > sectors[1][1].get_gpos().y: gen_sectors("down")     # generate more sectors to the NORTH
#
#func free_sector(sector):
#   saver.save_sector(sector, self) # new form
#   saver.save_sector(sector) # old form
#
#
#func get_sector(x, y):
#   var sector = saver.load_sector(x, y, self)
#   if sector != null:
#       return sector
#   else:
#       return create_sector(x, y)
#
#
#
#func get_neighbor(y, x):
#   return sectors[y][x]
#
#func get_player_gpos():
#   var p = Vector2( player.get_pos().x / SS , player.get_pos().y / SS )
#   if p.x < 0: p.x -= 1
#   if p.y < 0: p.y -= 1
#   p.x = int(p.x)
#   p.y = int(p.y)
#   return p


#func print_sectors():
#   print ("~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~")
#   # print (sectors)
#   var out = []
#   for r in sectors:
#       var inr = []
#       for s in r:
#           inr.append(s.get_gpos())
#       out.append(inr)
#   print(out)

