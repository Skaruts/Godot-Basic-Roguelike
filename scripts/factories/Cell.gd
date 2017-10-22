##########################################################
# Base class for map tiles, text charaters, and Entities
##########################################################
extends Sprite

var pos = Vector2()     # local position (in the tile-grid)
var background          # the background 2D polygon
var glyph = 0           # The symbol used for this cell
var fg                  # Foreground Color
var bg                  # Background Color

func _init():
	# I'm taking advantage of Godot's sprite animation settings, in that
	# I assign the tileset to the sprite, set hframes and vframes to how
	# many sprites the tileset has horizontally and vertically, and Godot
	# automatically crops it to the frame set with the glyph value.
	set_hframes(16)
	set_vframes(16)
	set_centered(false)	  # use top-left corner as pivot

	# create the background polygon
	background = Polygon2D.new()
	add_child(background)
	background.set_owner(self)
	background.set_name("Background") # redundant.
	background.set_color( colors.BLACK ) # redundant?
	background.set_draw_behind_parent(true)

func _ready():
	add_to_group("SPRITES")

# would like to rename this function to something else
func init(pos, g=0, fg=colors.RED4, bg=colors.BLACK):
	set_position(pos)
	switch_font()
	set_glyph(g)
	set_fg(fg)
	set_bg(bg)

func switch_font():
	set_texture( textures.get_texture() )
	set_position(pos)
	resize_bg()

func set_position(p):
	var TW = textures.get_tile_width()
	var TH = textures.get_tile_height()
	pos = p
	set_pos( Vector2(pos.x*TW, pos.y*TH) )

func resize_bg():
	var TW = textures.get_tile_width()
	var TH = textures.get_tile_height()
	background.set_polygon( Vector2Array( [Vector2(0, 0), Vector2(TW, 0), Vector2(TW, TH), Vector2(0, TH)] ) )

func set_glyph(g):
	glyph = g
	set_frame(g)

func set_colors(fg=null, bg=null):
	if fg != null: set_fg(fg)
	if bg != null: set_bg(bg)

func set_fg(fg):
	self.fg = fg
	set_modulate(fg)

func set_bg(bg):
	self.bg = bg
	background.set_color(bg)

#func get_glyph():	return get_frame()
#func get_fg():	    return get_modulate()
#func get_bg():	    return background.get_color()


