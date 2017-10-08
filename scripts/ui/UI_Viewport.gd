extends "res://scripts/ui/UI_Widget.gd"



func set_size(w, h):
    var TS = textures.get_tile_size()
    .set_size(w, h)
    get_node("Viewport").set_rect( Rect2(Vector2(), Vector2(w*TS, h*TS)) )

