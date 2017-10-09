# AutoLoaded script
extends Node

var _currTexIndex = 0
var _currTexture
var _textures = []  # store preloaded textures

func _init():
	load_textures()

# tileset must have 16x16 tiles
func get_tile_sizes():  return [get_tile_width(), get_tile_height()]
func get_tile_width():  return _currTexture.get_width()/16
func get_tile_height(): return _currTexture.get_height()/16

func get_texture():
	return _currTexture

func load_textures():
	var files = utils.list_files("res://fonts/", "png")
	print(files)
	for f in files:
		# print("f: ", f)
		_textures.append( load("res://fonts/" + f) )
	set_texture(_currTexIndex)

func set_texture(ct):
	_currTexture = _textures[_currTexIndex]

func switch_texture(dir):   # -1 up | 1 down
	var old_index = _currTexIndex
	_currTexIndex += dir

	if _currTexIndex >= _textures.size():
		_currTexIndex = 0

	if _currTexIndex < 0:
		_currTexIndex = _textures.size()-1

	if _currTexIndex != old_index:
		set_texture(_currTexIndex)
		return true

	return false
