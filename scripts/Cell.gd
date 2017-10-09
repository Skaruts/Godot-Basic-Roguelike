extends Node2D

var pos = Vector2()
var fore
var back
var glyph = 0
var fg = Color('000000')
var bg = Color('000000')

func init(pos, g=0):
	add_to_group("CELLS")
	fore = get_node("Foreground")
	back = get_node("Background")
	set_position(pos)
	switch_texture()
	set_glyph(g)

func _ready():
	pass

func set_position(p):
	var TW = textures.get_tile_width()
	var TH = textures.get_tile_height()
	pos = p
	set_pos( Vector2(pos.x*TW, pos.y*TH) )

func switch_texture():
	get_node("Foreground").set_texture( textures.get_texture() )
	get_node("Background").set_texture( textures.get_texture() )
	set_position(pos)

func set_glyph(g):
	glyph = g
	get_node("Foreground").set_frame(g)

func set_fg(fg):
	self.fg = fg
	get_node("Foreground").set_modulate(fg)

func set_bg(bg):
	self.bg = bg
	get_node("Background").set_modulate(bg)

func set_visible(show):
	set_hidden( not show )  # invert bool

func toggle_visible():
	set_hidden( not is_hidden() )


