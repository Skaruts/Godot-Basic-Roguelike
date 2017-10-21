# AutoLoaded script
extends Node

var _default_font = 6
var __fonts_file = "res://data/fonts/fonts.xt"
var __fonts_path = "res://data/fonts/"

var _fonts = {}  # stores preloaded textures
var _fnames = [] # stores the name of each font set

var _current_font_idx = _default_font
var _currentFontName
var _currTxt
var _currTexture

var use_ascii = true		# not useful yet (but being used already)

func _init():
	_load_fonts()
	_set_font( _current_font_idx )

func _load_fonts():
	for l in utils.get_data_file( __fonts_file ):
		var fname = l[0]
		var ftxt = load( __fonts_path + l[1] + '.png' )
		var fasc = load( __fonts_path + l[2] + '.png' )
		# var fgfx = load( __fonts_path + l[3] + '.png' )

		_fnames.append( fname )
		_fonts[fname] = [ ftxt, fasc ] #, fgfx ]

func _set_font(cf):
	_currentFontName = _fnames[_current_font_idx]
	_currTxt = _fonts[_currentFontName][0]
	if use_ascii: _currTexture = _fonts[_currentFontName][1]
	# else:         _currTexture = _fonts[_currentFontName][2]




####################################################
# Interface
#---------------------------------------------------
func switch_font(dir):   # -1 up | 1 down
	var old_index = _current_font_idx
	_current_font_idx += dir

	if _current_font_idx >= _fnames.size():
		_current_font_idx = 0

	if _current_font_idx < 0:
		_current_font_idx = _fnames.size()-1

	if _current_font_idx != old_index:
		_set_font( _current_font_idx )
		return true

	return false

# tileset must have 16x16 tiles
func get_tile_sizes():  return Vector2(get_tile_width(), get_tile_height())
func get_tile_width():  return _currTexture.get_width()/16
func get_tile_height(): return _currTexture.get_height()/16

func get_font_sizes():  return Vector2(get_font_width(), get_font_height())
func get_font_width():  return _currTxt.get_width()/16
func get_font_height(): return _currTxt.get_height()/16

func get_texture():	return _currTexture
func get_font():	return _currTxt


