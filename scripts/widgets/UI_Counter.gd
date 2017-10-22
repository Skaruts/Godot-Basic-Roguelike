extends "res://scripts/widgets/UI_Widget.gd"

var pre_char = preload("res://scripts/factories/Char.gd")   # USE TextTool FOR THIS

var digits = Array()
var val = 0
var string = str(val)
var align = "right"
var occlude = true
var timer = 0
var wrap = false

func _init( pos, width, initial_val=0, wrap=false, occlude=true, align="right" ):
	w = width
	h = 1
	set_position(pos)
	self.occlude = occlude
	self.align = align
	self.wrap = wrap
	val = initial_val

	if val < 0:                val = 0
	elif val > pow(10, w)-1:   val = pow(10, w)-1

	__make_digits()
	set_value(val)

	# debug
	set_process(false)


# USE TextTool FOR THIS
func __make_digits():
	for i in range( w ):
		var digit = pre_char.new()

		add_child( digit )
		digit.set_owner( self )
		digit.init( Vector2(i, 0), 0, colors.GRAY4, colors.BLACK)

		digits.append( digit )

func _process(delta):
	timer += delta
	var i = 0.25
	if timer >= i:
		var diff = timer - i
		timer = diff
		inc(10)

# "%-10d" % val     # "123       "   # align left
# "%10d" % val      # "       123"   # align right
# "%*d" % [x, val]  # "       123"   # x leading spaces
# "%0*d" % [5, 3]   # "00003"        # fill with 0s
func set_value(v):
	val = v
	if align in ['left', 'l']:
		string = "%-*d" % [w, val]
	elif align in ['right', 'r']:
		if occlude:   string = "%*d" % [w, val]
		else:         string = "%0*d" % [w, val]

	for i in range( digits.size() ):
		digits[i].set_glyph( utils.ascii(string[i]) )

func reset():
	set_value(0)

func set_fg(fg):
	for d in digits:    d.set_fg(fg)

func set_bg(bg):
	for d in digits:    d.set_bg(bg)

func inc(v=1):
	var limit = pow(10, w)
	val += v
	if val >= limit:
		if wrap:   val -= limit
		else:      val = limit
	set_value(val)

func dec(v=1):
	var limit = pow(10, w)
	val -= v
	if val < 0:
		if wrap:   val += limit # - abs(val) +1
		else:      val = 0
	set_value(val)
