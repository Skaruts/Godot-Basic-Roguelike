extends "res://scripts/entities/Mob.gd"

var pre_ai = preload("res://scripts/components/AI_BasicMob.gd")
var pre_combat = preload("res://scripts/components/Combat.gd")
# var pre_inventory = preload("res://scripts/components/MobInventory.gd")

func _ready():
	add_to_group("MAP_ENTITIES")

	name = "^1Orc^"
	sight_range = 6
	is_obstacle = true


	set_glyph( utils.ascii(charcodes.ORC) )
	set_fg( colors.ORC )

	# components
	ai = pre_ai.new()
	add_component("ai", ai)

	combat = pre_combat.new()
	combat.hp = 10
	combat.strength = 3
	combat.defense = 0
	add_component("combat", combat)



