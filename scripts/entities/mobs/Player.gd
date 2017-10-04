extends "res://scripts/entities/Mob.gd"

var pre_controls = preload("res://scripts/components/Controls.gd")
var pre_combat = preload("res://scripts/components/Combat.gd")
# var pre_inventory = preload("res://scripts/components/MobInventory.gd")

func _ready():
	name = "Player"
	sight_range = 15
	is_obstacle = true

	glyph = charcodes.PLAYER
	set_glyph( glyph )
	set_foreground( colors.PLAYER )

	# components
	controls = pre_controls.new()
	add_component("controls", controls)

	combat = pre_combat.new()
	combat.hp = 1000
	combat.strength = 5
	combat.defense = 2
	add_component("combat", combat)

	if debug:
		# label.set_text(str(hp))
		label.set_pos( Vector2(0, -TS/2) )


