extends Sprite

var pos = Vector2()
var glyph = 0
var fg = Color('000000')
var bg = Color('000000')

func init(pos, g=0):
	add_to_group("CELLS")
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
	set_texture( textures.get_texture() )
	set_position(pos)

func set_glyph(g):
	glyph = g
	set_frame(g)

func set_fg(fg):
	self.fg = fg
	set_modulate(fg)

func set_bg(bg):
	self.bg = bg
	# set_modulate(bg)

func set_visible(show):
	set_hidden( not show )  # invert bool

func toggle_visible():
	set_hidden( not is_hidden() )


