#######################################################################
# This BSP Dungeon Generation code was based off of the code from:
# https://gamedevelopment.tutsplus.com/tutorials/how-to-use-bsp-trees-to-generate-game-maps--gamedev-12268
#
# Some useful resources:
# http://www.futuredatalab.com/proceduraldungeon/
# http://www.emanueleferonato.com/2009/06/02/understanding-roguelike-dungeons/
#######################################################################

extends "res://scripts/WorldGen/Factory.gd"

var MW = settings.MAP_WIDTH
var MH = settings.MAP_HEIGHT

var MAX_LEAF_SIZE 	= 25
var MIN_LEAF_SIZE 	= 7

var MAX_ROOM_SIZE 	= 20
var MIN_ROOM_SIZE 	= 5

var MAX_ROOM_MONSTERS = 3

# debug stuff
var _room_id = -1
func next_room_id():
	_room_id += 1
	return _room_id

