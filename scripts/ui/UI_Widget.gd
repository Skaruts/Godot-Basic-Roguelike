extends Node2D

var parent
var pos = Vector2()
var w = 1
var h = 1
var fg
var bg

func _ready():
	add_to_group("UI_ELEMENTS")

func set_position(p):
	var TS = textures.get_tile_size()
	pos = p
	set_pos( pos*TS )

func set_size(w, h):
	self.w = w
	self.h = h

func set_fg(fg):    self.fg = fg
func set_bg(bg):    self.bg = bg
