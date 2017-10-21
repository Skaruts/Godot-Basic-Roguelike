# AutoLoaded script
extends Node

# char/glyphs values
# -------------------------
var WALL    = '#'
var FLOOR   = '.'
var DOORC   = '+'
var DOORO   = '.'

var PLAYER  = '@'
var HUMAN   = 'h'
var ORC     = 'o'
var TROLL   = 't'

var CORPSE  = '&'

var HP_BAR = 219
# drawing lines
# -------------------------
# thin lines
var HL      = 196
var VL      = 179
var TL      = 218   # Top Left
var TR      = 191   # Top Right
var BL      = 192   # Bottom Left
var BR      = 217   # Bottom Right
var LJ      = 195   # Left T-junction/Cap
var RJ      = 180   # Right T-junction/Cap
var TJ      = 194   # Top T-junction/Cap
var BJ      = 193   # Bottom T-unction/Cap
var XJ      = 197   # Cross Junction (or Full Block?)

# thick lines
var HL2		= 205
var VL2		= 186
var TL2		= 201   # Top Left
var TR2		= 187   # Top Right
var BL2		= 200   # Bottom Left
var BR2		= 188   # Bottom Right
var LJ2		= 204   # Left T-junction/Cap
var RJ2		= 185   # Right T-junction/Cap
var TJ2		= 203   # Top T-junction/Cap
var BJ2		= 202   # Bottom T-unction/Cap
var XJ2		= 206   # Cross Junction (or Full Block?)

var CAP     = 255
