extends "res://scripts/ui/UI_Widget.gd"

var pre_tilefactory = preload("res://scripts/TileFactory.gd")
var tilemap = []
var glyph

func _init(pos, w):
	set_position(pos)
	set_size(w, 1)

func build_bar():
	var tile_fac = pre_tilefactory.new(w, h)

	tile_fac.frect(glyph)
	tilemap = tile_fac.make_tiles(self, fg, bg, true)

func set_val(val, max_val):
	var length = int(float(val) / max_val * w)
	# var remainder = float(val) / max_val * w - length
	# print (length)
	# tilemap[length].set_modulate( Color(fg.r, fg.g, fg.b, fg.a*remainder) )

	for i in range( tilemap.size() ):
		if i > length:
			tilemap[i].set_fg(bg)
		elif i == length:
			# find the difference between one point and the other
			# and change color alpha based on that
			var remainder = float(val) / max_val * w - length
			tilemap[i].set_fg( Color(fg.r, fg.g, fg.b, fg.a*remainder) )
			pass
		else:
			tilemap[i].set_fg(fg)

