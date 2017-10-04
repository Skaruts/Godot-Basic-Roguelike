extends Node2D

var components = {}

# var debug = settings.DEBUG
var TS = textures.get_tile_size()

# type of entity
var is_mob = false
var is_item = false
var is_object = false
var is_obstacle	= true # whether it blocks the path

# properties

var name
var dungeon
var pos = Vector2()
var glyph = 0
var fg

# sub nodes
var sprite

func _ready():
	sprite = get_node("Sprite")
	switch_texture()

func set_position(p):
	pos = p
	set_pos(pos * TS)

func switch_texture():
	sprite.set_texture( textures.get_texture() )
	TS = textures.get_tile_size()
	set_glyph(glyph)
	set_position(pos)

func set_glyph(g):
	glyph = g
	var tex_x = (glyph % 16) * TS
	var tex_y = int(glyph / 16) * TS
	sprite.set_region_rect( Rect2( Vector2(tex_x, tex_y), Vector2(TS, TS) ) )

func set_foreground(foreground):
	fg = foreground
	sprite.set_modulate(fg)

# sets the map this entity is currently in
func set_dungeon(d):
	dungeon = d

func set_visible(show):
	if show:	set_hidden(false)
	else:		set_hidden(true)

func add_component(cname, comp):
	add_child(comp)
	comp.set_owner(self)
	components[cname] = comp