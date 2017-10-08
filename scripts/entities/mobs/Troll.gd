extends "res://scripts/entities/Mob.gd"

var pre_ai = preload("res://scripts/components/AI_BasicMob.gd")
var pre_combat = preload("res://scripts/components/Combat.gd")
# var pre_inventory = preload("res://scripts/components/MobInventory.gd")

func _ready():
    add_to_group("MAP_ENTITIES")
    name = "Troll"
    sight_range = 3
    is_obstacle = true

    glyph = utils.ascii(charcodes.TROLL)
    set_glyph( glyph )
    set_fg( colors.TROLL )

    # Components
    ai = pre_ai.new()
    add_component("ai", ai)

    combat = pre_combat.new()
    combat.hp = 20
    combat.strength = 4
    combat.defense = 1
    add_component("combat", combat)


