extends Node
# var pre_tilefactory = preload("res://scripts/factories/TileFactory.gd")
var pre_tile = preload("res://scripts/factories/Tile.gd")
var charmap = Array()
var clear_charmap = Array()


var fg = colors.UI_FG
var bg = colors.UI_BG

var mw = 0
var mh = 0

var HL
var VL
var TL
var TR
var BL
var BR
var LJ
var RJ
var TJ
var BJ
var XJ
var CAP

func set_colors(fg = colors.UI_FG, bg = colors.UI_BG):
	self.fg = fg
	self.bg = bg

# move this into text factory
func write(string):
	for i in range(string.length()):
		charmap[i] = utils.ascii(string[i])

func _init(w=1, h=1, thickness=0):
	mw = w
	mh = h
	set_brush(thickness)
	create_charmap()

func create_charmap():
	for i in range(mw*mh):
		clear_charmap.append([0, fg, bg])
	charmap = Array(clear_charmap)

func clear():
	charmap = Array(clear_charmap)

func get_finished(parent):
	return make_tiles(parent)

func make_tiles(parent):
	var tilemap = Array()
	for j in range(mh):
		for i in range(mw):
			if charmap[i+j*mw][0] > 0:
				tilemap.append( _create_tile( i, j, charmap[i+j*mw][0], parent, charmap[i+j*mw][1], charmap[i+j*mw][2] ) )
	return tilemap

func _create_tile(x, y, char, parent, fg, bg ):
	var tile = pre_tile.new()
	parent.add_child( tile )
	tile.set_owner( parent )
	tile.init( Vector2(x, y), char, fg, bg )
	return tile

func set_brush(thickness):
	if thickness == 0:
		HL = charcodes.HL
		VL = charcodes.VL
		TL = charcodes.TL
		TR = charcodes.TR
		BL = charcodes.BL
		BR = charcodes.BR
		LJ = charcodes.LJ
		RJ = charcodes.RJ
		TJ = charcodes.TJ
		BJ = charcodes.BJ
		XJ = charcodes.XJ
	else:
		HL = charcodes.HL2
		VL = charcodes.VL2
		TL = charcodes.TL2
		TR = charcodes.TR2
		BL = charcodes.BL2
		BR = charcodes.BR2
		LJ = charcodes.LJ2
		RJ = charcodes.RJ2
		TJ = charcodes.TJ2
		BJ = charcodes.BJ2
		XJ = charcodes.XJ2
	CAP = charcodes.CAP



#######################################################
# Draws a single glyph to the charmap.
# -----------------------------------------------------
func plot(char, x, y):
	charmap[x+y*mw] = [char, fg, bg]



#######################################################
# Draws a line to the charmap.
# -----------------------------------------------------
# @erase - acts as an eraser instead
func line(x, y, orientation, length=0, erase=false):
	if length:
		if orientation in ['horizontal', 'h']:
			__lineh(x, y, min(x+length, mw), erase)
		elif orientation in ['vertical', 'v']:
			__linev(x, y, min(y+length, mh), erase)

func __lineh(x, y, x2, erase):
	for i in range(x, x2):
		if not erase:    charmap[i+y*mw] = [HL, fg, bg]
		else:            charmap[i+y*mw] = [ 0, fg, bg]

func __linev(x, y, y2, erase):
	for j in range(y, y2):
		if not erase:    charmap[x+j*mw] = [VL, fg, bg]
		else:            charmap[x+j*mw] = [ 0, fg, bg]



#######################################################
# draws a rectangle shape to the charmap
# complete with corners, using ascii line art.
# -----------------------------------------------------
# if corners = false it leaves spaces, unless
# caps = true, in which case it caps the corners
# -----------------------------------------------------
func rect(x=0, y=0, w=0, h=0, corners=true, caps=false):
	if w == 0: w = mw
	if h == 0: h = mh
	var x2 = min(x+w, mw)
	var y2 = min(y+h, mh)

	var rTL; var rTR; var rBL; var rBR
	if caps:
		rTL = CAP
		rTR = CAP
		rBL = CAP
		rBR = CAP
	elif corners:
		rTL = TL
		rTR = TR
		rBL = BL
		rBR = BR

	for j in range(y, y2):
		for i in range(x, x2):
			if corners or caps:
				if   i == x    and j == y:      charmap[i+j*mw] = [rTL, fg, bg]  # Top Left
				elif i == x2-1 and j == y:      charmap[i+j*mw] = [rTR, fg, bg]  # Top Right
				elif i == x    and j == y2-1:   charmap[i+j*mw] = [rBL, fg, bg]  # Bottom Left
				elif i == x2-1 and j == y2-1:   charmap[i+j*mw] = [rBR, fg, bg]  # Bottom Right

			if (i  > x and i  < x2-1) \
			and  (j == y or  j == y2-1):    charmap[i+j*mw] = [HL, fg, bg]  # Top/Bottom Walls

			elif (j  > y and j  < y2-1) \
			and  (i == x or  i == x2-1):    charmap[i+j*mw] = [VL, fg, bg]  # Left/Right Walls

# filled rect
func frect(char, x=0, y=0, w=0, h=0):   # add support alpha value
	if w == 0: w = mw
	if h == 0: h = mh

	var x2 = min(x+w, mw)
	var y2 = min(y+h, mh)

	for j in range(y, y2):
		for i in range(x, x2):
			charmap[i+j*mw] = [char, fg, bg]



#######################################################
# Convoluted version of rect. Does more stuff...
# -----------------------------------------------------
# Checks w and h, to decide whether to draw a rect,
# a capped line or a single X-junction.
#
# I have NOT FULLY TESTED this function.
# Should be able to create lines if w or h = 1
#
# @cap - if h=1 or w=1, caps the edges of the
# resulting line with junctions, to connect to
# perpendicular lines (good for making separators)
# -----------------------------------------------------
func crect(x=0, y=0, w=0, h=0, cap = false):
	if w == 0: w = mw
	if h == 0: h = mh

	var x2 = min(x+w, mw)
	var y2 = min(y+h, mh)

	for j in range(y, y2):
		for i in range(x, x2):
			# if w and h are > 1, make a rect as normal
			if w > 1:
				if h > 1:
					if   i == x    and j == y:      charmap[i+j*mw] = [TL, fg, bg]  # Top Left
					elif i == x2-1 and j == y:      charmap[i+j*mw] = [TR, fg, bg]  # Top Right
					elif i == x    and j == y2-1:   charmap[i+j*mw] = [BL, fg, bg]  # Bottom Left
					elif i == x2-1 and j == y2-1:   charmap[i+j*mw] = [BR, fg, bg]  # Bottom Right

					elif (i  > x and i  < x2-1) \
					and  (j == y or  j == y2-1):    charmap[i+j*mw] = [HL, fg, bg]  # Top/Bottom Walls

					elif (j  > y and j  < y2-1) \
					and  (i == x or  i == x2-1):    charmap[i+j*mw] = [VL, fg, bg]  # Left/Right Walls
			# if either w or h are not > 1, make a line and cap the ends with T-junctions
				else:
					if cap:
						if i == x:                  charmap[i+j*mw] = [LJ, fg, bg]  # Left Junction/Cap
						elif i == x2-1:             charmap[i+j*mw] = [RJ, fg, bg]  # Right Junction/Cap
						elif i > x and i < x2-1:    charmap[i+j*mw] = [HL, fg, bg]      # Row
					else:
						charmap[i+j*mw] = [HL, fg, bg]      # Row
			else:
				if h > 1:
					if cap:
						if j == y:                  charmap[i+j*mw] = [TJ, fg, bg]  # Top Junction/Cap
						elif j == y2-1:             charmap[i+j*mw] = [BJ, fg, bg]  # Bottom Junction/Cap
						elif j > y and j < y2-1:    charmap[i+j*mw] = [VL, fg, bg]      # Collumn
					else:
						charmap[i+j*mw] = [VL, fg, bg]      # Collumn
			# if neither w or h are > 1, make a single cross junction
				else:
					charmap[i+j*mw] = [XJ, fg, bg]  # Cross Junction/Full Block



#######################################################
# Smart Rect.
# -----------------------------------------------------
# Merges a rect with existing geometry in the charmap,
# by comparing the exiting glyph at a given position
# with the glyph that is about to be drawn.
#
# Useful for composite panels with several parts.
# -----------------------------------------------------
func srect(x=0, y=0, w=0, h=0):
	if w == 0: w = mw
	if h == 0: h = mh
	var x2 = min(x+w, mw)
	var y2 = min(y+h, mh)

	for j in range(y, y2):
		for i in range(x, x2):
			if   i == x    and j == y:      charmap[i+j*mw] = [ compare( charmap[i+j*mw][0], TL ), fg, bg ]  # Top Left
			elif i == x2-1 and j == y:      charmap[i+j*mw] = [ compare( charmap[i+j*mw][0], TR ), fg, bg ]  # Top Right
			elif i == x    and j == y2-1:   charmap[i+j*mw] = [ compare( charmap[i+j*mw][0], BL ), fg, bg ]  # Bottom Left
			elif i == x2-1 and j == y2-1:   charmap[i+j*mw] = [ compare( charmap[i+j*mw][0], BR ), fg, bg ]  # Bottom Right

			if (i  > x and i  < x2-1) \
			and  (j == y or  j == y2-1):    charmap[i+j*mw] = [ compare( charmap[i+j*mw][0], HL ), fg, bg ]  # Top/Bottom Walls

			elif (j  > y and j  < y2-1) \
			and  (i == x or  i == x2-1):    charmap[i+j*mw] = [ compare( charmap[i+j*mw][0], VL ), fg, bg ]  # Left/Right Walls


# compares the existing glyph with the new one
# that's about to be placed
func compare(old, new):
	if old != 0 and new != old:
		if old == XJ:
			return old
		# if old is a junction
		if old == LJ or old == RJ or old == TJ or old == BJ:
			#    TOP   junction + any TOP  corner  ||  BOTTOM junction + any BOTTOM corner
			# || LEFT  junction + any LEFT corner  ||  RIGHT junction  + any RIGHT corner
			# || any H junction + HL               ||  any V junction  + VL
			#  =  original junction
			if ( old == TJ and ( new == TL or new == TR ) )    \
			or ( old == BJ and ( new == BL or new == BR ) )    \
			or ( old == LJ and ( new == TL or new == BL ) )    \
			or ( old == RJ and ( new == TR or new == BR ) )    \
			or ( new == HL and ( old == TJ or old == BJ ) )   \
			or ( new == VL and ( old == LJ or old == RJ ) ):
				return old
			# any junction + any corner not of same side = cross junction
			else: # new == TL or new == TR or new == BL or new == BR:
				return XJ
		# if old is NOT a junction
		else:
		# HL + VL OR any corner + opposite corner  =  cross junction
			if new == HL and old == VL	\
			or new == VL and old == HL	\
			or new == TL and old == BR	\
			or new == TR and old == BL	\
			or new == BL and old == TR	\
			or new == BR and old == TL:
				return XJ
		# HL + any TOP corner || TOP corner + opposite TOP corner  =  TOP junction
			if ( new == HL and ( old == TL or old == TR ) or old == HL and ( new == TL or new == TR ) )	\
			or ( new == TL and old == TR or new == TR and old == TL ):
				return TJ
		# HL + any BOTTOM corner || BOTTOM corner + opposite BOTTOM corner  =  BOTTOM junction
			if ( new == HL and ( old == BL or old == BR ) or old == HL and ( new == BL or new == BR ) )	\
			or ( new == BL and old == BR or new == BR and old == BL ):
				return BJ
		# VL + any LEFT corner || LEFT corner + opposite LEFT corner  =  LEFT junction
			if ( new == VL and ( old == TL or old == BL ) or old == VL and ( new == TL or new == BL ) )	\
			or ( new == TL and old == BL or new == BL and old == TL ):
				return LJ
		# VL + any RIGHT corner || RIGHT corner + opposite RIGHT corner  =  RIGHT junction
			if ( new == VL and ( old == TR or old == BR ) or old == VL and ( new == TR or new == BR ) )	\
			or ( new == BR and old == TR or new == TR and old == BR ):
				return RJ
	return new

