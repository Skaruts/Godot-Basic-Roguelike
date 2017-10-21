extends Node

var pre_tile = preload("res://scripts/factories/Tile.gd")

func make_tiles(charmap, w, h, parent, fg, bg):
	var tilemap = Array()
	for j in range(h):
		for i in range(w):
			if charmap[i+j*w] > 0:
				tilemap.append( _create_tile( i, j, charmap[i+j*w], parent, fg, bg ) )
	return tilemap

func _create_tile(x, y, char, parent, fg, bg ):
	var tile = pre_tile.new()
	parent.add_child( tile )
	tile.set_owner( parent )
	tile.init( Vector2(x, y), char, fg, bg )
	return tile




