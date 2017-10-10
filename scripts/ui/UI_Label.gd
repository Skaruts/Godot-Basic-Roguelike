extends "res://scripts/ui/UI_Widget.gd"
var pre_text_factory = preload("res://scripts/factories/TextFactory.gd")
var tiles = []

func init(pos, text, fg, bg):
	set_position(pos)
	w = text.length()
	h = 1
	set_fg(fg)
	set_bg(bg)
	__build(text)

func set_text(text):
	if tiles.size(): clear()
	w = text.length()
	__build(text)

func __build(text):
	var tfac = pre_text_factory.new()
	tiles = tfac.printl(text, self, fg, bg)


func clear():
	for t in tiles:
		t.free()
	tiles = []