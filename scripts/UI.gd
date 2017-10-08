extends Node2D

var ui_panels = {}
var world

func init(world):
    self.world = world

    ui_panels["panel1"] = load("res://scripts/ui/UI_Panel1.gd").new()
    ui_panels["panel2"] = load("res://scripts/ui/UI_Panel2.gd").new()
    ui_panels["panel3"] = load("res://scripts/ui/UI_Panel3.gd").new()
    ui_panels["panel1"].init(world, 12, settings.GRID_HEIGHT-6)
    ui_panels["panel2"].init(world, 18, settings.GRID_HEIGHT)
    ui_panels["panel3"].init(world, 46, 6)
    add_child( ui_panels["panel1"] )
    add_child( ui_panels["panel2"] )
    add_child( ui_panels["panel3"] )

    if settings.INVERT_UI == 0:
        ui_panels["panel1"].set_position( Vector2(0, 0) )
        ui_panels["panel2"].set_position( Vector2(46, 0) )
        ui_panels["panel3"].set_position( Vector2(0, settings.GRID_HEIGHT-6) )
    else:
        ui_panels["panel1"].set_position( Vector2(52, 0) )
        ui_panels["panel2"].set_position( Vector2(0, 0) )
        ui_panels["panel3"].set_position( Vector2(18, settings.GRID_HEIGHT-6) )

func reposition():
    # settings.INVERT_UI = 1
    for u in get_tree().get_nodes_in_group("UI_ELEMENTS"):
        u.set_position(u.pos)


