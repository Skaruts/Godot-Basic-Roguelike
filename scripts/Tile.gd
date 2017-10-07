extends Sprite

# var type
var TS = textures.get_tile_size()
var pos = Vector2()

var glyph
var fg; var fg_dark; var bg
var tex_x; var tex_y; var tex_w; var tex_h

var discovered = false
var darkened = false
var is_solid = false

func _ready():
	add_to_group("TEXTURED")
	set_centered(false)
	set_region(true)
	set_process(true)

func init(x, y, g):
	glyph = g
	pos = Vector2(x, y)
	switch_texture()

func set_position(p):
	pos = p
	set_pos(pos*TS)

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
	bg = background
	# need to add a second sprite for this

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
	if dark and not darkened:
		set_modulate( fg_dark )
		darkened = true
	elif not dark and darkened:
		set_modulate( fg )
		darkened = false

