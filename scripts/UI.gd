extends Node2D

var ui_panels = {}
var world

func _ready():
	ui_panels["panel1"] = load("res://scripts/ui/Panel1.gd").new()   # left
	ui_panels["panel2"] = load("res://scripts/ui/Panel2.gd").new()   # log
	ui_panels["panel3"] = load("res://scripts/ui/Panel3.gd").new()   # right
	ui_panels["panel1"].init(0, 0, 12, settings.GRID_HEIGHT-6)
	ui_panels["panel2"].init(0, 0, 18, settings.GRID_HEIGHT)
	ui_panels["panel3"].init(0, 0, 46, 6)
	add_child( ui_panels["panel1"] )
	add_child( ui_panels["panel2"] )
	add_child( ui_panels["panel3"] )

	# settings.INVERT_UI = 1
	if settings.INVERT_UI == 0:
		ui_panels["panel1"].set_position( Vector2(0, 0) )
		ui_panels["panel2"].set_position( Vector2(46, 0) )
		ui_panels["panel3"].set_position( Vector2(0, settings.GRID_HEIGHT-6) )
	else:
		ui_panels["panel1"].set_position( Vector2(52, 0) )
		ui_panels["panel2"].set_position( Vector2(0, 0) )
		ui_panels["panel3"].set_position( Vector2(18, settings.GRID_HEIGHT-6) )

func reposition():
	for u in get_tree().get_nodes_in_group("UI_ELEMENTS"):
		u.set_position(u.pos)

