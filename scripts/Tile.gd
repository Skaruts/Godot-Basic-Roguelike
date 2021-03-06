extends Sprite

var pos = Vector2()
var background
var glyph
var fg
var bg

func _init():
	set_hframes(16)
	set_vframes(16)
	set_centered(false)
	background = Polygon2D.new()
	add_child(background)
	background.set_name("Background")
	background.set_color( colors.BLACK )
	background.set_draw_behind_parent(true)

func _ready():
	add_to_group("TILES")

func init(pos, g=0, fg=0, bg=0):
	set_position(pos)
	switch_font()
	set_glyph(g)
	set_fg(fg)
	set_bg(bg)

func resize_bg():
	var TW = textures.get_tile_width()
	var TH = textures.get_tile_height()
	background.set_polygon( Vector2Array( [Vector2(0, 0), Vector2(TW, 0), Vector2(TW, TH), Vector2(0, TH)] ) )

func set_position(p):
	var TW = textures.get_tile_width()
	var TH = textures.get_tile_height()
	pos = p
	set_pos( Vector2(pos.x*TW, pos.y*TH) )

func switch_font():
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
	background.set_color(bg)

func get_glyph(g):	return get_frame()
func get_fg(fg):	return get_modulate()
func get_bg(bg):	return background.get_color()

func set_visible(show): set_hidden( not show )  # invert bool
func toggle_visible():  set_hidden( not is_hidden() )


