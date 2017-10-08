extends "res://scripts/Cell.gd"

var fg_dark
var discovered = false
var darkened = false
var is_solid = false

# func _init(pos, g):
# 	._init(pos, g)

func set_fg(fg):
	var mult = settings.TILE_DARK_MULT
	self.fg = fg
	fg_dark = Color(fg.r*mult, fg.g*mult, fg.b*mult)
	set_modulate(fg)

func set_bg(bg):
	self.bg = bg
	# I think I need to add a second sprite for this

func set_visible(show):
	if show:
		if discovered:	set_dark(false)
		else:
			set_hidden(false)
			discovered = true
	else:
		if discovered:	set_dark(true)
		else:			set_hidden(true)

func set_dark(dark):
	if dark and not darkened:
		set_modulate( fg_dark )
		darkened = true
	elif not dark and darkened:
		set_modulate( fg )
		darkened = false

