extends Node
var pre_tilefactory = preload("res://scripts/factories/TileFactory.gd")
var charmap = Array()
var clear_charmap = Array()
var mw = 0
var mh = 0

# move this into text factory
func write(string):
	for i in range(string.length()):
		charmap[i] = utils.ascii(string[i])

func _init(w=1, h=1):
	mw = w
	mh = h
	create_charmap()

func create_charmap():
	for i in range(mw*mh):
		clear_charmap.append(0)
	charmap = Array(clear_charmap)

func clear():
	charmap = Array(clear_charmap)

func get_finished(parent, fg, bg, is_cell=false):
	var fac = pre_tilefactory.new()
	return fac.make_tiles(charmap, mw, mh, parent, fg, bg, is_cell)


func plot(char, x, y):
	charmap[x+y*mw] = char

#######################################################
# Draws a line to the charmap.
# -----------------------------------------------------
func line(x, y, orientation, length=0, erase=false):
	if length:
		if orientation in ['horizontal', 'h']:
			__lineh(x, y, min(x+length, mw), erase)
		elif orientation in ['vertical', 'v']:
			__linev(x, y, min(y+length, mh), erase)

func __lineh(x, y, x2, erase):
	for i in range(x, x2):
		if not erase: charmap[i+y*mw] = charcodes.HL
		else:         charmap[i+y*mw] = 0

func __linev(x, y, y2, erase):
	for j in range(y, y2):
		if not erase: charmap[x+j*mw] = charcodes.VL
		else:         charmap[x+j*mw] = 0

#######################################################
# draws a rectangle shape to the charmap
# complete with corners, using ascii line art.
# -----------------------------------------------------
func rect(x=0, y=0, w=0, h=0):
	if w == 0: w = mw
	if h == 0: h = mh

	var x2 = min(x+w, mw)
	var y2 = min(y+h, mh)

	for j in range(y, y2):
		for i in range(x, x2):
			if   i == x    and j == y:      charmap[i+j*mw] = charcodes.TL  # Top Left
			elif i == x2-1 and j == y:      charmap[i+j*mw] = charcodes.TR  # Top Right
			elif i == x    and j == y2-1:   charmap[i+j*mw] = charcodes.BL  # Bottom Left
			elif i == x2-1 and j == y2-1:   charmap[i+j*mw] = charcodes.BR  # Bottom Right

			elif (i  > x and i  < x2-1) \
			and  (j == y or  j == y2-1):    charmap[i+j*mw] = charcodes.HL  # Top/Bottom Walls

			elif (j  > y and j  < y2-1) \
			and  (i == x or  i == x2-1):    charmap[i+j*mw] = charcodes.VL  # Left/Right Walls

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
					if   i == x    and j == y:      charmap[i+j*mw] = charcodes.TL  # Top Left
					elif i == x2-1 and j == y:      charmap[i+j*mw] = charcodes.TR  # Top Right
					elif i == x    and j == y2-1:   charmap[i+j*mw] = charcodes.BL  # Bottom Left
					elif i == x2-1 and j == y2-1:   charmap[i+j*mw] = charcodes.BR  # Bottom Right

					elif (i  > x and i  < x2-1) \
					and  (j == y or  j == y2-1):    charmap[i+j*mw] = charcodes.HL  # Top/Bottom Walls

					elif (j  > y and j  < y2-1) \
					and  (i == x or  i == x2-1):    charmap[i+j*mw] = charcodes.VL  # Left/Right Walls
			# if either w or h are not > 1, make a line and cap the ends with T-junctions
				else:
					if i == x:                  charmap[i+j*mw] = charcodes.LJ  # Left Junction/Cap
					elif i > x and i < x2-1:    charmap[i+j*mw] = charcodes.HL      # Row
					elif i == x2-1:             charmap[i+j*mw] = charcodes.RJ  # Right Junction/Cap
			else:
				if h > 1:
					if j == y:                  charmap[i+j*mw] = charcodes.TJ  # Top Junction/Cap
					elif j > y and j < y2-1:    charmap[i+j*mw] = charcodes.VL      # Collumn
					elif j == y2-1:             charmap[i+j*mw] = charcodes.BJ  # Bottom Junction/Cap
			# if neither w or h are > 1, make a single cross junction
				else:
					charmap[i+j*mw] = charcodes.XJ  # Cross Junction/Full Block

# filled rect
func frect(char, x=0, y=0, w=0, h=0):   # add support alpha value
	if w == 0: w = mw
	if h == 0: h = mh

	var x2 = min(x+w, mw)
	var y2 = min(y+h, mh)

	for j in range(y, y2):
		for i in range(x, x2):
			charmap[i+j*mw] = char
