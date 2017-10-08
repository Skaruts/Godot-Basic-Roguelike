extends Sprite

var pos = Vector2()
var glyph = 0
var fg = Color('000000')
var bg = Color('000000')

func init(pos, g=0):
	set_centered(false)
	set_hframes(16)
	set_vframes(16)

	set_position(pos)
	switch_texture()
	set_glyph(g)

func _ready():
	add_to_group("CELLS")

func set_position(p):
	pos = p
	set_pos(pos*textures.get_tile_size())

func switch_texture():
	set_texture( textures.get_texture() )
	set_position(pos)

func set_glyph(g):
	glyph = g
	set_frame(glyph)
func set_fg(fg):
	self.fg = fg
	set_modulate(fg)

func set_bg(bg):
	self.bg = bg
	# I think I need to add a second sprite for this

func set_visible(show):
	set_hidden( not show )	# invert bool

func toggle_visible():
	set_hidden( not is_hidden() )

