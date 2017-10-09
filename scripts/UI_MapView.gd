extends Node2D	# "res://scripts/ui/UI_Widget.gd"

func _ready():
	callbacks.add(self, "get_world")

func set_size(w, h):
	# self.w = w
	# self.h = h
	var TS = textures.get_tile_size()
	get_node("Viewport").set_rect( Rect2(Vector2(), Vector2(w*TS, h*TS)) )

func reposition():
	var TS = textures.get_tile_size()
	var pos
	if settings.INVERT_UI == 0:     pos = Vector2(12, 0)
	else:                           pos = Vector2(18, 0)
	set_pos( pos*TS )

	set_size(34, 34)

func get_world():
	var v = get_node("Viewport")
	#print("V: ", v.get_name())
	var world = v.get_node("World")
	#print("W: ", world.get_name())
	return world
