extends "res://scripts/ui/UI_Widget.gd"

var frame = []

func init(w=1, h=1):
	# set_position(pos)
	set_size(w, h)

func build_frame():
	var dt = load("res://scripts/factories/DrawTool.gd").new(w, h)
	# var TS = textures.get_tile_size()
	dt.rect()
	frame = dt.get_finished(self, colors.UI_FG, colors.UI_BG, true)

func set_size(w, h):
	.set_size(w, h)
	build_frame()