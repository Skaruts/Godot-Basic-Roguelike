# AutoLoaded script
extends Node

# char/glyphs values
# -------------------------
var WALL	= 35	# '#'	- wall
var FLOOR	= 46	# '.'	- floor
# var DOORC	=		# '+'	- door closed
# var DOORO	=		# '/'	- door opened

var PLAYER 	= 64
var HUMAN 	= 72
var ORC		= 79
var TROLL	= 84

var CORPSE 	= 38

# drawing lines
var HL 		= 196
var VL 		= 179
var TL 		= 218	# Top Left
var TR 		= 191	# Top Right
var BL 		= 192	# Bottom Left
var BR 		= 217	# Bottom Right
var LT 		= 195	# Left T-junction/Cap
var RT 		= 180	# Right T-junction/Cap
var TT 		= 194	# Top T-junction/Cap
var BT 		= 193	# Bottom T-unction/Cap
var XJ 		= 197	# Cross Junction (or Full Block?)