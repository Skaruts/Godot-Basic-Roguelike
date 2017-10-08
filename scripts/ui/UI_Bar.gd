extends "res://scripts/ui/UI_Widget.gd"

var pre_tilefactory = preload("res://scripts/TileFactory.gd")
var tilemap = []

var name
var value
var max_value


# var max_width
var length;

func _init(name, pos, w, fg, bg=null):
	self.name = name

	set_position(pos)
	set_size(w, 1)

	set_foreground(fg)
	set_background(bg)

	# background
	var tile_fac = pre_tilefactory.new(w, h)
	print("pos: ", pos)
	print("w, h: ", w, ", ", h)
	# tile_fac.frect(219)
	# tilemap_bg = tile_fac.make_tiles(self)
	# tile_fac.clear()

	# foreground
	if w > 0:
		tile_fac.frect(219)
		tilemap = tile_fac.make_tiles(self, colors.GREEN4, colors.BLACK, true)


func set_value(value=100, max_value=100):
	length = int( value / max_value * w )
	var remainder = (value / max_value * w) - w

	# for t in tilemap:

func set_foreground(foreground):
	pass

func set_background(background):
	pass
