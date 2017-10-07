extends Node2D

var parent
var pos = Vector2()
var w = 1
var h = 1


func set_position(p):
	var TS = textures.get_tile_size()
	pos = p
	set_pos( pos*TS )


func set_size(w, h):
	self.w = w
	self.h = h
