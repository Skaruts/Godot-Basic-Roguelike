# AutoLoaded script
extends Node

var _texture_names = []
var currTexIndex = 2
var currTexture

func _init():
	load_texture_names()

func get_texture():
	return currTexture

func set_texture(ct):
	currTexture = load("res://fonts/" + _texture_names[currTexIndex])

func load_texture_names():
	var files = list_files_in_directory("res://fonts/")
	for f in files:
#		print(f)
		_texture_names.append(f)
	set_texture(currTexIndex)

func list_files_in_directory(path):
    var files = []
    var dir = Directory.new()
    dir.open(path)
    dir.list_dir_begin()

    while true:
        var file = dir.get_next()
        if file == "":
            break
        elif file.ends_with(".png"):
            files.append(file)

    dir.list_dir_end()
    return files

func switch_texture(dir):
	currTexIndex += dir

	if currTexIndex >= _texture_names.size(): currTexIndex = 0
	if currTexIndex < 0: currTexIndex = _texture_names.size()-1
	set_texture(currTexIndex)

func get_tile_size():
	return currTexture.get_width()/16 	# tileset must have 16x16 tiles