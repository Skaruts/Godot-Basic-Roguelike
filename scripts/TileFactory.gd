extends Node

var charmap = []
var mw = 0
var mh = 0

func _init(w, h):
	mw = w
	mh = h
	create_charmap()

func create_charmap():
	for j in range(mh):
		var inner = []
		for i in range(mw):
			inner.append(0)
		charmap.append(inner)

func line(x, y, orientation, length=0, erase=false):
	if length:
		if orientation in ['horizontal', 'h']:
			__lineh(x, y, min(x+length, mw), erase)
		elif orientation in ['vertical', 'v']:
			__linev(x, y, min(y+length, mh), erase)

func __lineh(x, y, x2, erase):
	for i in range(x, x2):
		if not erase: charmap[y][i] = charcodes.HL
		else: 		  charmap[y][i] = 0

func __linev(x, y, y2, erase):
	for j in range(y, y2):
		if not erase: charmap[j][x] = charcodes.VL
		else: 		  charmap[j][x] = 0

#######################################################
# draws a rectangle shape to the charmap
# complete with corners.
# -----------------------------------------------------
func rect(x=0, y=0, w=0, h=0):
	if w == 0: w = mw
	if h == 0: h = mh

	var x2 = min(x+w, mw)
	var y2 = min(y+h, mh)

	for j in range(y, y2):
		for i in range(x, x2):
			if   i == x    and j == y:		charmap[j][i] = charcodes.TL	# Top Left
			elif i == x2-1 and j == y:		charmap[j][i] = charcodes.TR	# Top Right
			elif i == x	   and j == y2-1:	charmap[j][i] = charcodes.BL	# Bottom Left
			elif i == x2-1 and j == y2-1:	charmap[j][i] = charcodes.BR	# Bottom Right

			elif (i  > x and i  < x2-1)	\
			and  (j == y or  j == y2-1):	charmap[j][i] = charcodes.HL	# Top/Bottom Walls

			elif (j  > y and j  < y2-1)	\
			and  (i == x or  i == x2-1):	charmap[j][i] = charcodes.VL	# Left/Right Walls

#######################################################
# Convoluted version of rect. Does more stuff...
# -----------------------------------------------------
# Checks w and h, to decide whether to draw a rect,
# a line or a single X-junction.
#
# I have NOT TESTED this function.
# Should be able to make intersecting lines and rects
# and connect them to existing lines.
# -----------------------------------------------------
func crect(x=0, y=0, w=0, h=0):
	if w == 0: w = mw
	if h == 0: h = mh

	var x2 = min(x+w, mw)
	var y2 = min(y+h, mh)

	for j in range(y, y2):
		for i in range(x, x2):
			# if w and h are > 1, make a rect as normal
			if w > 1:
				if h > 1:
					if   i == x    and j == y:		charmap[j][i] = charcodes.TL	# Top Left
					elif i == x2-1 and j == y:		charmap[j][i] = charcodes.TR	# Top Right
					elif i == x    and j == y2-1: 	charmap[j][i] = charcodes.BL	# Bottom Left
					elif i == x2-1 and j == y2-1:	charmap[j][i] = charcodes.BR	# Bottom Right

					elif (i  > x and i  < x2-1)	\
					and  (j == y or  j == y2-1):	charmap[j][i] = charcodes.HL	# Top/Bottom Walls

					elif (j  > y and j  < y2-1)	\
					and  (i == x or  i == x2-1):	charmap[j][i] = charcodes.VL	# Left/Right Walls
			# if either w or h are not > 1, make a line and cap the ends with T-junctions
				else:
					if i == x:					charmap[j][i] = charcodes.LJ	# Left Junction/Cap
					elif i > x and i < x2-1:	charmap[j][i] = charcodes.HL		# Row
					elif i == x2-1:				charmap[j][i] = charcodes.RJ	# Right Junction/Cap
			else:
				if h > 1:
					if j == y:					charmap[j][i] = charcodes.TJ	# Top Junction/Cap
					elif j > y and j < y2-1:	charmap[j][i] = charcodes.VL		# Collumn
					elif j == y2-1:				charmap[j][i] = charcodes.BJ	# Bottom Junction/Cap
			# if neither w or h are > 1, make a single cross junction
				else:
					charmap[j][i] = charcodes.XJ	# Cross Junction/Full Block

func make_tiles(parent):
	var tilemap = []
	for j in range(mh):
		var inner = []
		for i in range(mw):
			if charmap[j][i] > 0:
				inner.append( create_tile( i, j, charmap[j][i], parent ) )
		tilemap.append(inner)
	return tilemap

func create_tile(x, y, char, parent):
	var tile = load("res://scripts/Tile.gd").new()

	tile.init( x , y, char )
	tile.set_foreground( colors.UI_FRAMES )

	parent.add_child( tile )
	tile.set_owner( parent )

	return tile
