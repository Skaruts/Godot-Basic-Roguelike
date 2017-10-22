extends Node
var pre_char = preload("res://scripts/factories/Char.gd")

var fg = colors.UI_TEXT_FG
var bg = colors.UI_BG

#####################################################################################
#                                     INTERFACE
#####################################################################################
# -----------------------------------------------------
# "prints" one line to the charmap.
# -----------------------------------------------------
func printl( string, parent ):
	var charmap = __parse_string(string)
	return __make_sprites(charmap, 0, parent)


# -----------------------------------------------------
# Creates a progress bar kind of thing
# -----------------------------------------------------
func create_bar(w, parent, glyph, fg, bg):
	var charmap = Array()
	for i in range(w):
		charmap.append( [ glyph, fg, bg ] )

	return __make_sprites(charmap, 0, parent)


#####################################################################################
#                               PRIVATE CLASS MEMBERS
#####################################################################################
# -----------------------------------------------------
# Creates a new array of empty chars (0) using
# default colors
# -----------------------------------------------------
func __create_charmap(w, h):
	var charmap = Array()
	for i in range(w*h):
		charmap.append([0, fg, bg])
	return charmap


# -----------------------------------------------------
# Checks strings for color codes
# -----------------------------------------------------
# Syntax: a ^ followed by a number 0-9 colors the text
# next to it. Currently only supports a single digit number.
#
# ^7 uses "colors.TEXT_COLOR_6" for the text that follows it.
# A single ^ reverts back to default text color.
# To use the symbol ^ you must escape it with a forward
# slash, /^
#
# Examples:
# ^3This entire line is yellow
# ^7This is purple, ^2this blue, ^and this the default color
# You can also make ^0m^1u^2l^3t^4i^5c^6o^7l^8o^9r ^words (<- that's multicolor words)
func __parse_string(string):
	var charmap = Array()
	var clrs = [fg, bg]
	var skip = false

	for i in range( string.length() ):
		if not skip:
			if string[i] == '/':
				if i+1 < string.length() and string[i+1] == '^':
					continue

			if string[i] == '^':
				if string[i-1] != '/':
					if i+1 < string.length() and string[i+1] in ['0', '1', '2', '3', '4', '5', '6', '7', '8', '9']:
					#if string[i+1] == ' ':
						__get_colors( clrs, string[i+1] )
						skip = true
					else:
						clrs = [fg, bg]
					continue

			charmap.append( [ utils.ascii( string[i] ), clrs[0], clrs[1] ] )
		else:
			skip = false

	return charmap

# TODO: put the colors in an array or enum, for easier access.
func __get_colors(clrs, c):
	if   c == '0': clrs[0] = colors.TEXT_COLOR_0
	elif c == '1': clrs[0] = colors.TEXT_COLOR_1
	elif c == '2': clrs[0] = colors.TEXT_COLOR_2
	elif c == '3': clrs[0] = colors.TEXT_COLOR_3
	elif c == '4': clrs[0] = colors.TEXT_COLOR_4
	elif c == '5': clrs[0] = colors.TEXT_COLOR_5
	elif c == '6': clrs[0] = colors.TEXT_COLOR_6
	elif c == '7': clrs[0] = colors.TEXT_COLOR_7
	elif c == '8': clrs[0] = colors.TEXT_COLOR_8
	elif c == '9': clrs[0] = colors.TEXT_COLOR_9


# makes only a line at a time
func __make_sprites(charmap, line, parent):
	var sprite_map = []

	for i in range( charmap.size() ):
		if charmap[i][0] > 0:
			sprite_map.append( __create_sprite( i, line, charmap[i][0], parent, charmap[i][1], charmap[i][2] ) )

	return sprite_map

func __create_sprite(x, y, glyph, parent, fg, bg):
	var char = pre_char.new()
	parent.add_child( char )
	char.set_owner( parent )
	char.init( Vector2(x, y), glyph, fg, bg)

	return char
