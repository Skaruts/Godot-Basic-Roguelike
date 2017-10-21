extends Node
var pre_cell = preload("res://scripts/factories/Cell.gd")

var fg = colors.UI_TEXT_FG
var bg = colors.UI_BG

func create_cellmap(w, h):
	var cellmap = Array()
	for i in range(w*h):
		cellmap.append([0, fg, bg])
	return cellmap

#######################################################
# prints one line to the cellmap.
# -----------------------------------------------------
func printl( string, parent ):
	var cellmap = parse_string(string)
	return __make_tiles(cellmap, 0, parent)

func create_bar(w, parent, glyph, fg, bg):
	var cellmap = Array()
	for i in range(w):
		cellmap.append( [ glyph, fg, bg ] )

	return __make_tiles(cellmap, 0, parent)

#######################################################
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
func parse_string(string):
	var cellmap = Array()
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
						get_colors( clrs, string[i+1] )
						skip = true
					else:
						clrs = [fg, bg]
					continue

			cellmap.append( [ utils.ascii( string[i] ), clrs[0], clrs[1] ] )
		else:
			skip = false

	return cellmap

# TODO: put the colors in an array or enum, for easier access.
func get_colors(clrs, c):
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
func __make_tiles(cellmap, line, parent):
	var tilemap = []

	for i in range( cellmap.size() ):
		if cellmap[i][0] > 0:
			tilemap.append( __create_tile( i, line, cellmap[i][0], parent, cellmap[i][1], cellmap[i][2] ) )

	return tilemap

func __create_tile(x, y, char, parent, fg, bg):
	var cell = pre_cell.new()
	parent.add_child( cell )
	cell.set_owner( parent )
	cell.init( Vector2(x, y), char, fg, bg)

	return cell
