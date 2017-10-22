#######################################################
# Entity class, for all map objects
#######################################################
extends "res://scripts/factories/Cell.gd"

var components = {}

# type of entity (redundant because of groups?)
var is_mob = false
var is_item = false
var is_object = false
var is_obstacle = true

# properties
var name
var dungeon

func _ready():
	add_to_group("ENTITIES")

# sets the map this entity is currently in
func set_dungeon(d):
	dungeon = d

func add_component(cname, comp):
	add_child(comp)
	comp.set_owner(self)
	components[cname] = comp

func set_visible(vis):
	set_hidden(!vis)

func set_fg(fg):
	self.fg = fg
	set_modulate(fg)
