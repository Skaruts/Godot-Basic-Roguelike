# AutoLoaded script
extends Node

var _currTexIndex = 4
var _currTexture
var _textures = []	# store preloaded textures

func _init():
	load_textures()

func get_texture():
	return _currTexture

func set_texture(ct):
	_currTexture = _textures[_currTexIndex]

func load_textures():
	var files = utils.list_files("res://fonts/", "png")
	for f in files:
		print("f: ", f)
		_textures.append( load("res://fonts/" + f) )
	set_texture(_currTexIndex)

func switch_texture(dir):	# -1 up | 1 down
	_currTexIndex += dir

	if _currTexIndex >= _textures.size(): _currTexIndex = 0
	if _currTexIndex < 0: _currTexIndex = _textures.size()-1
	set_texture(_currTexIndex)

func get_tile_size():
	return _currTexture.get_width()/16 	# tileset must have 16x16 tiles