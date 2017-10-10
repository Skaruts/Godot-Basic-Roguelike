extends "res://scripts/entities/Entity.gd"

var pre_controls = preload("res://scripts/components/Controls.gd")
var pre_combat = preload("res://scripts/components/Combat.gd")
# var pre_inventory = preload("res://scripts/components/MobInventory.gd")

#debug stuff
var debug
var label

# components
var combat = null
var controls = null

# properties
var alive = true
var sight_range

func _ready():
	global.nodes["player"] = self
	global.player = self

	label = get_node("Label")
	set_debug( settings.SHOW_MOB_HP )

	name = "Player"
	sight_range = 15
	is_obstacle = true

	set_glyph( utils.ascii(charcodes.PLAYER) )
	set_fg( colors.PLAYER )

	# components
	controls = pre_controls.new()
	add_component("controls", controls)

	combat = pre_combat.new()
	combat.hp = 100
	combat.max_hp = 100
	combat.mana = 100
	combat.max_mana = 100
	combat.strength = 5
	combat.defense = 2
	add_component("combat", combat)
	#global.getf("set_hp").call_func(combat.hp, combat.max_hp)

	var TW = textures.get_tile_width()
	if debug:
		# label.set_text(str(hp))
		label.set_pos( Vector2(0, -TW/2) )

func die():
	#global.getf("set_hp").call_func(0, 0)
	is_obstacle = false
	alive = false

	dungeon.add_corpse(name, pos)
	set_glyph(0)
	set_bg(colors.TRANSP)
	set_visible(false)
	# dungeon.kill_entity(self, 'mob')

func set_label_text(text):
	label.set_text(text)

func set_debug(d):
	debug = d
	show_label(d)

func show_label(l):
	# invert the bool so that true makes it visible
	# instead of hiding it, and vice versa
	label.set_hidden(not l)

func toggle_debug():
	label.set_hidden( not label.is_hidden() )

func take_turn():
	#global.getf("set_hp").call_func(combat.hp, combat.max_hp)
	pass
