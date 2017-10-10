# AutoLoaded script
extends Node

# debug stuff
# ------------------------------------------------------------
var DEBUG_SEED = 0  # overrides factory random seed generation

var DEBUG_LEAF = false
var DEBUG_HALL = false
var DEBUG_ROOM = false
var SHOW_ROOM_LABELS = false
var SHOW_MOB_HP = false

# master flag, overrides all of the above, although they
# can still be set to true in each class, overriding this
var DEBUG = false

# settings
# ------------------------------------------------------------
var TILE_DARK_MULT      = 0.4       # multiplier for darkening tile colors (used in Tile.set_foreground())
var GRID_WIDTH          = 64
var GRID_HEIGHT         = 40
var MAP_WIDTH           = 48
var MAP_HEIGHT          = 48
var KEY_REPEAT          = true      # if false, you move once per key press
var KEY_COOLDOWN        = 0.10
var KEY_1ST_COOLDOWN    = 0.250
var INVERT_UI           = false
var KERNING				= 4
# func _init():
