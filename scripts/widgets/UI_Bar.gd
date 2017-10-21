extends "res://scripts/widgets/UI_Widget.gd"

var pre_text_factory = preload("res://scripts/factories/TextFactory.gd")

var tilemap = []
var glyph = 0

func _init(pos, w, glyph, fg, bg):
	set_position(pos)
	set_size(w, 1)
	self.glyph = glyph
	set_fg(fg)
	set_bg(bg)

func _ready():
	global.addf(self, "set_value")
	build_bar()

func build_bar():
	var tfac = pre_text_factory.new()
	tilemap = tfac.create_bar(w, self, glyph, fg, bg)

func set_value(val, max_val):
	var length = int(float(val) / max_val * w)
	for i in range( tilemap.size() ):
		if i > length:
			tilemap[i].set_fg(bg)
		elif i == length:
			# find the difference between one point and the other
			# and change the alpha based on that
			var remainder = float(val) / max_val * w - length
			tilemap[i].set_fg( Color(fg.r, fg.g, fg.b, fg.a*remainder) )
			pass
		else:
			tilemap[i].set_fg(fg)

