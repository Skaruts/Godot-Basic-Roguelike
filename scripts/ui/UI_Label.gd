extends "res://scripts/ui/UI_Widget.gd"

var tiles = []

func init(pos, text):
	set_position(pos)
	w = text.length()
	h = 1
	set_text(text)

func set_text(text):
	var fac = load("res://scripts/TileFactory.gd").new(w, h)
	fac.write(text)
	tiles = fac.make_tiles(self, colors.GRAY3, colors.BLACK, true)