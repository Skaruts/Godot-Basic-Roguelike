extends Node
var pre_cell = preload("res://scenes/Cell.tscn")

func create_charmap(w, h):
	var charmap = Array()
	for i in range(w*h):
		charmap.append(0)
	return charmap

#######################################################
# prints one line to the charmap.
# -----------------------------------------------------
func printl( string, parent, fg, bg ):
	var len = string.length()
	var charmap = create_charmap( len, 1)

	for i in range( len ):
		charmap[i] = utils.ascii( string[i] )

	return __make_cells(charmap, len, 1, parent, fg, bg)


func __make_cells(charmap, w, h, parent, fg, bg):
	var cellmap = []
	for j in range( h ):
		for i in range( w ):
			if charmap[i+j*w] > 0:
				cellmap.append( __create_cell( i, j, charmap[i+j*w], parent, fg, bg ) )
	return cellmap

func __create_cell(x, y, char, parent, fg, bg ):
	var cell = pre_cell.instance()
	parent.add_child( cell )
	cell.set_owner( parent )

	cell.init( Vector2(x, y), char )
	cell.set_fg( fg )
	cell.set_bg( bg )

	return cell
