# AutoLoaded script
extends Node


##############################################################
# helper function to return a random int between imin and imax
#-------------------------------------------------------------
func irand(imin, imax):
	return randi() % int(imax - imin) + imin

##############################################################
# Helper fucntion that returns an array of Vector2 points
# using Bresenham's or Red Blob Games's line algorithms
#-------------------------------------------------------------
func line(p0, p1, simple = true):
	if simple: 	return red_blob_line(p0, p1)
	else:		return bresenham(p0, p1)


##############################################################
# Adapted from Red Blob Games's line drawing implementation:
# https://www.redblobgames.com/grids/line-drawing.html
#-------------------------------------------------------------
func red_blob_line(p0, p1):
    var points = []
    var N = diagonal_distance(p0, p1)
    for step in range(N): # (var step = 0; step <= N; step++):
        var t
        if N == 0: 	t = 0.0
        else: 		t = step / N
        points.append( round_point( utils.lerp_point(p0, p1, t) ) )
    return points

func lerp_point(p0, p1, t):
    return Vector2( lerp(p0.x, p1.x, t), lerp(p0.y, p1.y, t) )

func diagonal_distance(p0, p1):
    var dx = p1.x - p0.x
    var dy = p1.y - p0.y
    return max( abs(dx), abs(dy) )

func round_point(p):
    return Vector2( round(p.x), round(p.y) )


##############################################################
# Adapted from Luke M.'s python implementation:
# https://gist.github.com/flags/1132363
#-------------------------------------------------------------
func bresenham(p0, p1):
	var points = []

	var steep = abs(p1.y-p0.y) > abs(p1.x-p0.x)
	if steep:
		p0 = utils.vswap(p0)
		p1 = utils.vswap(p1)

	if p0.x > p1.x:
		# 'flippin and floppin'
		var _x0 = int(p0.x)
		var _x1 = int(p1.x)
		p0.x = _x1
		p1.x = _x0

		var _y0 = int(p0.y)
		var _y1 = int(p1.y)
		p0.y = _y1
		p1.y = _y0

	var dx = p1.x - p0.x
	var dy = abs(p1.y - p0.y)
	var error = 0
	var derr = dy/float(dx)

	var ystep = 0
	var y = p0.y

	if p0.y < p1.y: ystep = 1
	else: 			ystep = -1

	for x in range( p0.x, p1.x+1):
		if steep:
			points.append( Vector2(y,x) )
		else:
			points.append( Vector2(x,y) )

		error += derr
		if error >= 0.5:
			y += ystep
			error -= 1.0

	return points

# swap the x and y values of a Vector2
func vswap(vec2):
	return Vector2(vec2.y, vec2.x)


##############################################################
# Helper functions that round a number (num) to a multiple (mult)
#-------------------------------------------------------------
# automatically rounds to the nearest multiple
func mult(num, mult):
	if mult == 0: return num
	var remainder = num % mult
	if remainder == 0: return num

	var diff1 = num - fmult(num, mult)
	var diff2 = cmult(num, mult) - num

	if diff1 < diff2:	return num + mult - remainder
	else:				return num + mult + remainder

# ceil to multiple of mult
func cmult(num, mult):
	if mult == 0: return num
	var remainder = num % mult
	if remainder == 0: return num	# remainder of 0 = num is multiple of mult, so return it (not needed in fmult)
	return num + mult - remainder

# floor to multiple of mult
func fmult(num, mult):
	if mult == 0: return num
	var remainder = num % mult
	return num - remainder

# nmult() should round to next multiple of mult
# with the option of the specified dir (ceil or floor)
# and of excluding mult (never allows rounding
# to itself if 'true')
func nmult(num, mult, dir = null, exc = true):
	# problem:
	#	ceil always excludes num by default
	#	floor always includes num by default
	#
	# I don't yet know how to turn either of them around
	#
	# return num + mult - remainder		# this only works for ceil excluding num
	# return num - mult + remainder		# this only works for floor including num
	pass