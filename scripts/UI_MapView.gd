extends Node2D	# "res://scripts/ui/UI_Widget.gd"

func set_size(w, h):
	# self.w = w
	# self.h = h
	var TW = textures.get_tile_width()
	var TH = textures.get_tile_height()
	get_node("Viewport").set_rect( Rect2(Vector2(), Vector2(w*TW, h*TH)) )

func reposition():
	var TW = textures.get_tile_width()
	var TH = textures.get_tile_height()
	var pos
	if settings.INVERT_UI == 0:     pos = Vector2(12, 0)
	else:                           pos = Vector2(18, 0)
	set_pos( Vector2(pos.x*TW, pos.y*TH) )

	set_size(34, 34)

