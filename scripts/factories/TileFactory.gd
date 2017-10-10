extends Node

var pre_tile = preload("res://scenes/Tile.tscn")
var pre_cell = preload("res://scenes/Cell.tscn")

func make_tiles(charmap, w, h, parent, fg, bg, is_cell=false):
	var tilemap = Array()
	for j in range(h):
		for i in range(w):
			if charmap[i+j*w] > 0:
				tilemap.append( _create_tile( i, j, charmap[i+j*w], parent, fg, bg, is_cell ) )
	return tilemap

func _create_tile(x, y, char, parent, fg, bg, is_cell ):
	var tile
	if is_cell: tile = pre_cell.instance()
	else:       tile = pre_tile.instance()
	parent.add_child( tile )
	tile.set_owner( parent )

	tile.init( Vector2(x, y), char )
	tile.set_fg( fg )
	tile.set_bg( bg )

	return tile




