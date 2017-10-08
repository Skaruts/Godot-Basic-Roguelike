extends "res://scripts/Cell.gd"

var components = {}

# type of entity (redundant because of groups?)
var is_mob = false
var is_item = false
var is_object = false
var is_obstacle	= true

# properties
var name
var dungeon

# func _init(pos, g):
# 	._init(pos, g)

func _ready():
	# ._ready()
	add_to_group("TEXTURED")
	add_to_group("ENTITIES")
	switch_texture()

# sets the map this entity is currently in
func set_dungeon(d):
	dungeon = d

func add_component(cname, comp):
	add_child(comp)
	comp.set_owner(self)
	components[cname] = comp