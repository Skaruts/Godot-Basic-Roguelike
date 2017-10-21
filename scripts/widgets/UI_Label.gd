extends "res://scripts/widgets/UI_Widget.gd"

# The label can't have a self background because when the texture changes,
# the label itself doesn't change.

var pre_text_factory = preload("res://scripts/factories/TextFactory.gd")

var tiles = Array()
var text = ""
var align = "left"

func _init( pos, width, text, align_text="left" ):
	h = 1
	set_position(pos)
	set_text(text, width, align_text)

func init(pos, width, text, align_text="left"):
	set_position(pos)
	set_text(text, width, align_text)

func set_text(text, width, align_text="left"):
	w = width
	self.text = text
	self.align = align_text

	align_text()

	if tiles.size(): clear()
	__build()

func __build():
	var tfac = pre_text_factory.new()
	tiles = tfac.printl(text, self)

func clear():
	for t in tiles:    t.free()
	tiles = Array()

func set_fg(fg):
	for t in tiles:    t.set_fg(fg)

func set_bg(bg):
	for t in tiles:		t.set_bg(bg)

func align_text():
	if w < text.length():
		w = text.length()
	elif w > text.length():
		if align in ['left', 'l']:
			text = "%-*s" % [w, text]
		elif align in ['right', 'r']:
			text = "%*s" % [w, text]

















