extends "res://scripts/ui/UI_Widget.gd"

var frame = []

func _init(pos, w=0, h=0):
	set_position(pos)
	set_size(w, h)

func build_frame():
	var tile_fac = load("res://scripts/TileFactory.gd").new(w, h)
	var TS = textures.get_tile_size()
	tile_fac.rect()
	frame = tile_fac.make_tiles(self)

func set_size(w, h):
	.set_size(w, h)
	build_frame()