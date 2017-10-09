extends "res://scripts/WorldGen/BSP_Factory/BSP_DungeonFactory.gd"

var id
var x; var y; var w; var h
var x2; var y2; var cx; var cy
var label

func _init(id, x, y, w, h):
	self.id     = id
	self.x      = x
	self.y      = y
	self.w      = w
	self.h      = h

	x2  = x + w
	y2  = y + h
	cx  = int( x+ (w-1)/2 )
	cy  = int( y+ (h-1)/2 )

# debug stuff
# --------------------
var debug = false
var debug_color = Color(1, 1, 1, 0.5)
# var show_label = false

func _ready():
	set_z(100)
	if settings.DEBUG:
		set_debug( settings.DEBUG_ROOM )

	create_label()

func _process(delta):
	update()    # to _draw() the bounding boxes
	set_process(false)

func _draw():
	if debug:
		draw_line( Vector2(x *TS,  y*TS),   Vector2(x2*TS,  y*TS), debug_color, 1 )
		draw_line( Vector2(x2*TS,  y*TS),   Vector2(x2*TS, y2*TS), debug_color, 1 )
		draw_line( Vector2(x2*TS, y2*TS),   Vector2( x*TS, y2*TS), debug_color, 1 )
		draw_line( Vector2(x *TS, y2*TS),   Vector2( x*TS,  y*TS), debug_color, 1 )

func set_debug(d):
	debug = d
	set_process(true)

func toggle_debug():
	set_debug(not debug)

func create_label():
	label = Label.new()
	label.set_pos( Vector2(x*TS+5, y*TS+5) )
	label.set_text( "R:  " + str(id) + "\nP: " + str( Vector2(x, y) ) + "\nS: " + str( Vector2(w, h) ) + "\nC:  " + str( Vector2(cx, cy) ) )

	add_child(label)
	label.set_owner(self)
	show_info(settings.SHOW_ROOM_LABELS)

func show_info(l):
	# invert the bool so that true makes it visible
	# instead of hiding it, and vice versa
	label.set_hidden(not l)

func toggle_info():
	label.set_hidden( not label.is_hidden() )