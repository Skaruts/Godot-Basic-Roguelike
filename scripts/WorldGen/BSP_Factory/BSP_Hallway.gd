extends "res://scripts/WorldGen/BSP_Factory/BSP_DungeonFactory.gd"

var p1 = Vector2()
var p2 = Vector2()
var p3 = Vector2()

func _init(p1, p2, p3):
	self.p1 = p1
	self.p2 = p2
	self.p3 = p3




# Debug stuff
# ---------------------
var debug = false
var debug_color = Color(0.1, 0.1, 1, 1)

func _ready():
	set_z(100)
	if settings.DEBUG:
		set_debug(settings.DEBUG_HALL)

func _process(delta):
	update()    # to _draw() the bounding boxes
	set_process(false)

func _draw():
	if debug:
		draw_line( Vector2((p1.x+0.5)*TS, (p1.y+0.5)*TS), Vector2((p2.x+0.5)*TS, (p2.y+0.5)*TS), debug_color, 1 )
		draw_line( Vector2((p2.x+0.5)*TS, (p2.y+0.5)*TS), Vector2((p3.x+0.5)*TS, (p3.y+0.5)*TS), debug_color, 1 )

func set_debug(d):
	debug = d
	set_process(true)

func toggle_debug():
	set_debug(not debug)