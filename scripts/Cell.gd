extends Sprite

var pos = Vector2()
var glyph = 0
var fg = Color('000000')
var bg = Color('000000')
var background
var backpoly

func _ready():
	add_to_group("CELLS")


func init(pos, g=0):
	set_position(pos)
	background = get_node("Background")
	#backpoly = get_node("Background").get_polygon()
#	background = Polygon2D.new()
#	add_child(background)
#	background.set_name("Background")
#	background.set_color(Color('000000'))
#	background.set_draw_behind_parent(true)
	#resize_bg()

	switch_texture()
	set_glyph(g)

func resize_bg():
	var TW = textures.get_tile_width()
	var TH = textures.get_tile_height()
	background.set_polygon( Vector2Array( [Vector2(0, 0), Vector2(TW, 0), Vector2(TW, TH), Vector2(0, TH)] ) )

func set_position(p):
	var TW = textures.get_tile_width()
	var TH = textures.get_tile_height()
	pos = p
	set_pos( Vector2(pos.x*TW, pos.y*TH) )

func switch_texture():
	set_texture( textures.get_texture() )
	set_position(pos)
	resize_bg()

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


