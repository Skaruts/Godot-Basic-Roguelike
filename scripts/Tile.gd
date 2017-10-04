extends Sprite

# var type
var TS = textures.get_tile_size()
var pos = Vector2()

var glyph
var fg; var fg_dark; var bg
var tex_x; var tex_y; var tex_w; var tex_h
var TW; var TH	# tile width, height

var discovered = false
var darkened = false

func _ready():
	set_centered(false)
	set_region(true)
	set_process(true)

func init(x, y, g):
	glyph = g
	pos = Vector2(x, y)
	switch_texture()

func set_position(p):
	pos = p
	set_global_pos(pos*TS)

func switch_texture():
	set_texture( textures.get_texture() )
	TS = textures.get_tile_size()
	set_glyph(glyph)
	set_position(pos)

func set_glyph(g):
	glyph = g
	var tex_x = (glyph % 16) * TS
	var tex_y = int(glyph / 16) * TS
	set_region_rect( Rect2( Vector2(tex_x, tex_y), Vector2(TS, TS) ) )

func set_foreground(foreground):
	var mult = settings.TILE_DARK_MULT
	fg = foreground
	fg_dark = Color(fg.r*mult, fg.g*mult, fg.b*mult)
	set_modulate(fg)

func set_background(background):
	# Not sure how this will work. May need an entirely new
	# layer of tiles for the background colors.
	pass

func set_visible(show):
	if show:	# show
		if discovered:	set_dark(false)
		else:
			set_hidden(false)
			discovered = true
	else:	# hide
		if discovered:	set_dark(true)
		else:			set_hidden(true)

func set_dark(dark):
	var color = get_modulate()
	var r = color.r
	var g = color.g
	var b = color.b

	if dark and not darkened:
		set_modulate( fg_dark )
		darkened = true
	elif not dark and darkened:
		set_modulate( fg )
		darkened = false

