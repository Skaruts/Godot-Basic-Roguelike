extends Node2D

var pre_tilefactory = preload("res://scripts/TileFactory.gd")
var tilemap = []


func _ready():
	build_frame()

func build_frame():
	var w = settings.GRID_WIDTH
	var h = settings.GRID_HEIGHT
	var TS = textures.get_tile_size()

	var tile_fac = pre_tilefactory.new(settings.GRID_WIDTH, settings.GRID_HEIGHT)
	tile_fac.rect()
	tile_fac.line(49, 1, 'v', settings.GRID_HEIGHT-2)
	tilemap = tile_fac.make_tiles(self)

#func clear_map():
#	for i in tilemap:
#		for t in i:
#			t.get_parent().remove_child(t)
#			t.free()
#	tilemap = []

func switch_texture():
	var TS = textures.get_tile_size()

	for j in range( tilemap.size() ):
		for i in range( tilemap[j].size() ):
			#var x = tilemap[j][i].pos.x
			#var y = tilemap[j][i].pos.y

			tilemap[j][i].switch_texture()
			# tilemap[j][i].set_global_pos( Vector2(x*TS, y*TS) )