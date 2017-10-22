#######################################################
# Map tile, for walls and floors
#######################################################
extends "res://scripts/factories/Cell.gd"

var fg_dark
var discovered = false
var darkened = false
var is_solid = false

func set_fg(fg):
	.set_fg(fg)
	var mult = settings.TILE_DARK_MULT
	fg_dark = Color(fg.r*mult, fg.g*mult, fg.b*mult)

func set_visible(vis):
	if discovered:
		set_dark(!vis)
	else:
		set_hidden(!vis)
		discovered = vis

func set_dark(dark):
	if dark and not darkened:
		set_modulate( fg_dark )
		darkened = true
	elif not dark and darkened:
		set_modulate( fg )
		darkened = false
